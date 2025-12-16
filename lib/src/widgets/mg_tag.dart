import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';

class MgTag extends StatelessWidget {
  const MgTag({
    required this.child,
    super.key,
    this.prefix,
    this.suffix,
    this.prefixGap = MgSizes.size4,
    this.suffixGap = MgSizes.size4,
    this.height = 24,
    double? paddingWidth,
    double? paddingHeight,
    double? iconSize,
    Color? color,
    Color? backgroundColor,
  }) : _paddingWidth = paddingWidth,
       _paddingHeight = paddingHeight,
       _iconSize = iconSize,
       _color = color,
       _backgroundColor = backgroundColor;

  final Widget child;
  final Widget? prefix;
  final Widget? suffix;
  final double prefixGap;
  final double suffixGap;
  final double height;
  final double? _paddingWidth;
  final double? _paddingHeight;
  final double? _iconSize;
  final Color? _color;
  final Color? _backgroundColor;

  MgTag copyWith({
    Widget? child,
    Widget? prefix,
    Widget? suffix,
    double? prefixGap,
    double? suffixGap,
    double? height,
    double? paddingWidth,
    double? paddingHeight,
    double? iconSize,
    Color? color,
    Color? backgroundColor,
  }) {
    return MgTag(
      prefix: prefix ?? this.prefix,
      suffix: suffix ?? this.suffix,
      prefixGap: prefixGap ?? this.prefixGap,
      suffixGap: suffixGap ?? this.suffixGap,
      height: height ?? this.height,
      paddingWidth: paddingWidth ?? _paddingWidth,
      paddingHeight: paddingHeight ?? _paddingHeight,
      iconSize: iconSize ?? _iconSize,
      color: color ?? _color,
      backgroundColor: backgroundColor ?? _backgroundColor,
      child: child ?? this.child,
    );
  }

  MgTag primary({bool light = false}) => copyWith(
    color: light ? MgColorScheme.primary : MgColorScheme.gray11,
    backgroundColor: light ? MgColorScheme.primaryLightest : MgColorScheme.primary,
  );

  MgTag secondary({bool light = false}) => copyWith(
    color: light ? MgColorScheme.oldSecondary : MgColorScheme.gray11,
    backgroundColor: light ? MgColorScheme.gray9 : MgColorScheme.oldSecondary,
  );

  MgTag danger({bool light = false}) => copyWith(
    color: light ? MgColorScheme.systemError : MgColorScheme.gray11,
    backgroundColor: light ? Colors.transparent : MgColorScheme.systemError,
  );

  MgTag gray({bool light = false}) => copyWith(
    color: light ? MgColorScheme.gray5 : MgColorScheme.gray11,
    backgroundColor: light ? MgColorScheme.gray9 : MgColorScheme.gray5,
  );

  MgTag transparent() => copyWith(backgroundColor: Colors.transparent);

  Widget _buildAffix(Widget? affix, BuildContext context) {
    if (affix == null) return const SizedBox.shrink();

    final iconColor = _color ?? context.colorScheme.onPrimary;
    final size = _iconSize ?? MgSizes.size16;

    return SizedBox(
      width: size,
      height: size,
      child: IconTheme(
        data: IconThemeData(
          size: size,
          color: iconColor,
        ),
        child: affix,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding:
          Gutter.w(_paddingWidth ?? MgSizes.size8) +
          Gutter.h(_paddingHeight ?? MgSizes.size2),
      decoration: BoxDecoration(
        color: _backgroundColor ?? context.colorScheme.primary,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAffix(prefix, context),
          if (prefix != null) Gaps.w(prefixGap),
          DefaultTextStyle(
            style: context.textTheme.labelSmall!.copyWith(
              color: _color ?? context.colorScheme.onPrimary,
            ),
            child: child,
          ),
          if (suffix != null) Gaps.w(suffixGap),
          _buildAffix(suffix, context),
        ],
      ),
    );
  }
}
