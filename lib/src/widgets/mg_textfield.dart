import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magambell/src/constants/mg_sizes.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';

class MgTextField extends StatefulWidget {
  const MgTextField({
    super.key,
    this.label,
    this.error,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.hintText,
    this.maxLines = 1,
    this.textInputAction,
    this.inputStyle,
    this.boxDecoration,
    this.prefixIcon,
    this.suffixIcon,
  });

  final String? label;
  final String? error;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final String? hintText;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final TextStyle? inputStyle;
  final BoxDecoration? boxDecoration;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  State<MgTextField> createState() => _MgTextFieldState();
}

class _MgTextFieldState extends State<MgTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  static const double spacingSm = MgSizes.xs;
  static const double spacingMd = MgSizes.sm;
  static const double fontSizeSm = MgSizes.sm;
  static const double borderRadiusMd = MgSizes.size10;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  Color get _borderColor {
    if (!widget.enabled) return Colors.transparent;

    if (widget.error != null && widget.error!.isNotEmpty) {
      return MgColorScheme.subpointRed;
    }
    // TODO: focus 되었을 때 색상 논의(_isFocused ? MgColorScheme.primary :)
    return _isFocused ? MgColorScheme.primary : MgColorScheme.gray7;
  }

  double get _borderWidth {
    if (widget.error != null && widget.error!.isNotEmpty) {
      return 1.0;
    }
    return _isFocused ? 1.5 : 1.0;
  }

  // 키보드 타입에 따른 TextInputAction 결정
  TextInputAction get _effectiveTextInputAction {
    if (widget.textInputAction != null) {
      return widget.textInputAction!;
    }

    // 숫자 키보드일 때도 done 버튼 표시
    if (widget.keyboardType == TextInputType.number ||
        widget.keyboardType == TextInputType.phone ||
        widget.keyboardType == const TextInputType.numberWithOptions(
          signed: true,
          decimal: true,
        )) {
      return TextInputAction.done;
    }

    return TextInputAction.done;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: spacingMd),
      decoration: widget.boxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label != null && widget.label!.isNotEmpty) ...[
            Text(widget.label!).bold().md().padding(bottom: MgSizes.size8),
          ],

          SizedBox(
            height: 50,
            child: CupertinoTextField(
              controller: widget.controller,
              focusNode: _focusNode,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              enabled: widget.enabled,
              maxLines: widget.maxLines,
              textInputAction: _effectiveTextInputAction,
              cursorColor: MgColorScheme.gray1, // TODO: 논의 필요
              style:
                  widget.inputStyle ??
                  const TextStyle(
                    fontSize: MgFontSize.md,
                    color: MgColorScheme.text,
                  ),
              placeholder: widget.hintText,
              placeholderStyle: const TextStyle(
                fontSize: MgFontSize.md,
                color: MgColorScheme.gray4,
              ),
              prefix: widget.enabled
                  ? (widget.prefixIcon ??
                        BaseSvgIcon.search().gray().margin(all: MgSizes.md))
                  : null,
              prefixMode: widget.enabled
                  ? OverlayVisibilityMode.always
                  : OverlayVisibilityMode.never,
              suffix: !widget.enabled
                  ? null
                  : GestureDetector(
                      onTap: () => widget.controller?.clear(),
                      child:
                          widget.suffixIcon ??
                          BaseSvgIcon.close().margin(all: MgSizes.md),
                    ),
              suffixMode: OverlayVisibilityMode.editing,
              padding: EdgeInsets.symmetric(
                horizontal: widget.prefixIcon == SizedBox.shrink()
                    ? 0
                    : spacingMd,
                vertical: spacingSm,
              ),
              decoration: BoxDecoration(
                color: widget.enabled
                    ? MgColorScheme.gray11
                    : MgColorScheme.gray9,
                borderRadius: BorderRadius.circular(borderRadiusMd),
                border: Border.all(color: _borderColor, width: _borderWidth),
              ),
            ),
          ),

          // Error Message
          if (widget.error != null && widget.error!.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 4),
              child: Text(
                widget.error!,
                style: const TextStyle(
                  color: MgColorScheme.subpointRed,
                  fontSize: fontSizeSm,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
