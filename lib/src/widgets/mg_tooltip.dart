import 'dart:async';

import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/theme/mg_color.dart';

part 'mg_tooltip_item.dart';

class MgTooltip extends StatefulWidget {
  const MgTooltip({
    required this.item,
    required this.child,
    super.key,
    this.defaultVisible = false,
    this.offset = Offset.zero,
    this.closable = true,
    this.barrierColor = Colors.transparent,
    this.timeoutDuration,
    this.backgroundColor,
    this.showItemArrow,
    this.itemAlignment = Alignment.topCenter,
    this.disabled = false,
  });

  /// tooltip item
  /// * 기본 [padding]: all:[MgSizes.sm]
  /// * 기본 [textStyle]: color:[text], size:[MgFontSize.xs]
  final Widget? item;

  /// tooltip item이 anchor의 대상이 되는 위젯
  final Widget child;

  /// tooltip item 초기 visible 여부
  final bool defaultVisible;

  ///* 외부를 터치했을때 tooltip item이 닫히는지 여부
  final bool closable;

  ///* tooltip Item 외의 배경 색상
  final Color barrierColor;

  ///* tooltip item이 자동으로 닫히는 시간
  final Duration? timeoutDuration;

  ///* item의 link ancher; item을 기준으로 [Alignment.topLeft]
  final Alignment itemAlignment;

  ///## child로부터 tooltip item의 offset
  ///* x: 오른쪽에 배치한다면 양수, 왼쪽에 배치한다면 음수
  ///* y: 위에 배치한다면 음수, 아래에 배치한다면 양수
  final Offset offset;

  //==============tooltip item decoration Style==============
  ///* default: gray9
  final Color? backgroundColor;

  ///* default: true
  final bool? showItemArrow;

  //=========================================================
  ///* tooltip child를 클릭했을때 tooltip이 뜨지 않는 상태로 만들어준다.
  final bool disabled;

  //TODO: open, onOpenChange 기능 추가

  @override
  State<MgTooltip> createState() => _MgTooltipState();
}

class _MgTooltipState extends State<MgTooltip>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final LayerLink _layerLink = LayerLink();

  late OverlayPortalController _overlayController;
  bool _isVisible = false;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _overlayController = OverlayPortalController();

    if (widget.defaultVisible) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showTooltip();
      });
    }
  }

  @override
  void dispose() {
    _hideTooltip();
    _animationController.dispose();
    super.dispose();
  }

  void _showTooltip() {
    if (_isVisible || widget.item == null) return;

    final route = ModalRoute.of(context);
    if (route == null || !route.isCurrent) return;

    setState(() => _isVisible = true);

    _overlayController.show();
    _animationController.forward();

    if (widget.timeoutDuration != null) {
      Future.delayed(widget.timeoutDuration!, _hideTooltip);
    }
  }

  void _hideTooltip() {
    if (!_isVisible) return;

    unawaited(
      _animationController.reverse().then((_) {
        if (mounted) {
          _overlayController.hide();
          setState(() {
            _isVisible = false;
          });
        }
      }),
    );
  }

  Widget _createTooltipItem(BuildContext context) {
    return Stack(
      children: [
        if (widget.closable)
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _hideTooltip,
              child: const SizedBox.expand(),
            ),
          ),
        CompositedTransformFollower(
          key: _key,
          link: _layerLink,
          showWhenUnlinked: false,
          followerAnchor: Alignment(
            -widget.itemAlignment.x,
            -widget.itemAlignment.y,
          ),
          targetAnchor: widget.itemAlignment,
          offset: widget.offset,
          child: FittedBox(
            fit: BoxFit.none,
            child: FadeTransition(
              opacity: _animationController,
              child: Material(
                type: MaterialType.transparency,
                child: _MgTooltipItem(
                  widget.item!,
                  backgroundColor: widget.backgroundColor,
                  showArrow: widget.showItemArrow,
                  alignment: Alignment(
                    -widget.itemAlignment.x,
                    -widget.itemAlignment.y,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: _createTooltipItem,
        child: Semantics(
          tooltip:
              widget.item is Text
                  ? (widget.item as Text?)?.data ?? ''
                  : 'Tooltip',
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap:
                widget.disabled
                    ? null
                    : _isVisible
                        ? _hideTooltip
                        : _showTooltip,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
