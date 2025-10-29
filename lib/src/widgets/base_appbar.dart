import 'package:flutter/material.dart';
import 'package:magambell/src/constants/mg_sizes.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar({
    super.key,
    this.title,
    this.leading,
    this.leadingWidth,
    this.leadingColor = Colors.grey,
    this.backgroundColor = Colors.transparent,
    this.elevation = 0.0,
    this.action,
    this.bottom,
    this.height = kToolbarHeight,
    this.centerTitle = true,
    this.titleSpacing,
    bool? canPop,
  }) : _canPop = canPop;
  final Widget? title;
  final bool? _canPop;

  final Color leadingColor;
  final Color backgroundColor;
  final double elevation;

  final Widget? leading;
  final double? leadingWidth;

  final Widget? action;

  final PreferredSizeWidget? bottom;

  final double height;
  final bool centerTitle;
  final double? titleSpacing;

  @override
  Size get preferredSize =>
      Size.fromHeight(height + (bottom?.preferredSize.height ?? 0.0));

  @override
  Widget build(BuildContext context) {
    final canPop = _canPop ?? Navigator.of(context).canPop();
    Future<void> onPopPressed() async {
      await BaseScaffold.of(context).onBack?.call();
      Navigator.of(context).pop();
    }

    return AppBar(
      toolbarHeight: height,
      leading:
          leading ??
          (canPop
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: onPopPressed,
                      child: BaseSvgIcon.left(size: 24),
                    ).padding(all: MgSizes.md),
                  ],
                )
              : const Offstage()),
      leadingWidth: leadingWidth,
      backgroundColor: backgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: elevation,
      title: title,
      bottom: bottom,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      actions: action != null ? [action!] : [],
    );
  }
}
