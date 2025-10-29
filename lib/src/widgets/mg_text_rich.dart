import 'package:flutter/material.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';

class MgTextRich extends Text {
  MgTextRich({
    required this.children,
    super.key,
    this.text = '',
    super.style,
    super.textAlign,
    super.maxLines,
    bool? asterisk,
  })  : _asterisk = asterisk ?? false,
        super.rich(TextSpan(text: text));

  MgTextRich.singleAsterisk(
    this.text, {
    super.key,
    super.style,
    super.textAlign,
    super.maxLines,
  })  : children = [],
        _asterisk = true,
        super.rich(TextSpan(text: text));

  final List<InlineSpan> children;
  final String text;
  final bool _asterisk;

  MgTextRich copyWith({
    bool? asterisk,
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
  }) =>
      MgTextRich(
        children: children,
        text: text,
        asterisk: asterisk ?? _asterisk,
        style: style ?? super.style,
        textAlign: textAlign ?? super.textAlign,
        maxLines: maxLines ?? super.maxLines,
      );

  MgTextRich asterisk() => copyWith(asterisk: true);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: text),
          ...children,
          if (_asterisk) ...[
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Text(" *")
                  .copyWith(
                    style: (style ?? const TextStyle()).copyWith(
                      color: MgColorScheme.subpointRed,
                      fontFamily: MgFontFamily.bold,
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
            ),
          ],
        ],
      ),
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }

  /* ******************* Color ******************* */

  MgTextRich primary() => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          color: MgColorScheme.primary,
        ),
      );

  MgTextRich secondary() => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          color: MgColorScheme.secondary,
        ),
      );

  MgTextRich red() => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          color: MgColorScheme.subpointRed,
        ),
      );

  MgTextRich subpointGreen() => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          color: MgColorScheme.subpointGreen,
        ),
      );

  MgTextRich subpointPink() => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          color: MgColorScheme.subpointPink,
        ),
      );

  MgTextRich textMain() => copyWith(
        style: (style ?? const TextStyle()).copyWith(color: MgColorScheme.text),
      );

  MgTextRich textGray() => copyWith(
        style: (style ?? const TextStyle()).copyWith(color: MgColorScheme.gray),
      );

  MgTextRich textInactive() => copyWith(
        style:
            (style ?? const TextStyle()).copyWith(color: MgColorScheme.inactive),
      );

  MgTextRich textHeader() => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          color: MgColorScheme.headerText,
        ),
      );

  MgTextRich white() => copyWith(
        style: (style ?? const TextStyle()).copyWith(color: MgColorScheme.white),
      );

  MgTextRich black() => copyWith(
        style: (style ?? const TextStyle()).copyWith(color: MgColorScheme.black),
      );

  MgTextRich textColor(Color? color) =>
      copyWith(style: (style ?? const TextStyle()).copyWith(color: color));

  /* ******************* Weight ******************* */

  MgTextRich thin() => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          fontFamily: MgFontFamily.thin,
          fontWeight: FontWeight.w100,
        ),
      );

  MgTextRich extraLight() => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          fontFamily: MgFontFamily.extraLight,
          fontWeight: FontWeight.w200,
        ),
      );

  MgTextRich light() => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          fontFamily: MgFontFamily.light,
          fontWeight: FontWeight.w300,
        ),
      );

  MgTextRich regular() => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          fontFamily: MgFontFamily.regular,
          fontWeight: FontWeight.w400,
        ),
      );

  MgTextRich medium() => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          fontFamily: MgFontFamily.medium,
          fontWeight: FontWeight.w500,
        ),
      );

  MgTextRich semibold() => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          fontFamily: MgFontFamily.semiBold,
          fontWeight: FontWeight.w600,
        ),
      );

  MgTextRich bold() => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          fontFamily: MgFontFamily.bold,
          fontWeight: FontWeight.w700,
        ),
      );

  MgTextRich extraBold() => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          fontFamily: MgFontFamily.extraBold,
          fontWeight: FontWeight.w800,
        ),
      );

  MgTextRich black900() => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          fontFamily: MgFontFamily.black,
          fontWeight: FontWeight.w900,
        ),
      );

  MgTextRich fontWeight(FontWeight? fontWeight) => copyWith(
        style: (style ?? const TextStyle()).copyWith(fontWeight: fontWeight),
      );

  /* ******************* Size ******************* */

  MgTextRich xxs() => copyWith(
        style: (style ?? const TextStyle()).copyWith(fontSize: MgFontSize.xxs),
      );

  MgTextRich xs() => copyWith(
        style: (style ?? const TextStyle()).copyWith(fontSize: MgFontSize.xs),
      );

  MgTextRich sm() => copyWith(
        style: (style ?? const TextStyle()).copyWith(fontSize: MgFontSize.sm),
      );

  MgTextRich md() => copyWith(
        style: (style ?? const TextStyle()).copyWith(fontSize: MgFontSize.md),
      );

  MgTextRich lg() => copyWith(
        style: (style ?? const TextStyle()).copyWith(fontSize: MgFontSize.lg),
      );

  MgTextRich xl() => copyWith(
        style: (style ?? const TextStyle()).copyWith(fontSize: MgFontSize.xl),
      );

  MgTextRich xxl() => copyWith(
        style: (style ?? const TextStyle()).copyWith(fontSize: MgFontSize.xxl),
      );

  MgTextRich fontSize(double? size) =>
      copyWith(style: (style ?? const TextStyle()).copyWith(fontSize: size));

  /* ******************* Align ******************* */

  MgTextRich center() => copyWith(textAlign: TextAlign.center);
  MgTextRich left() => copyWith(textAlign: TextAlign.left);
  MgTextRich right() => copyWith(textAlign: TextAlign.right);
  MgTextRich align(TextAlign? align) => copyWith(textAlign: align);

  /* ******************* Etc ******************* */

  MgTextRich height(double height) =>
      copyWith(style: (style ?? const TextStyle()).copyWith(height: height));

  MgTextRich max(int maxLines) => copyWith(maxLines: maxLines);

  MgTextRich ellipsis() => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          overflow: TextOverflow.ellipsis,
        ),
      );

  MgTextRich underline() => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          decoration: TextDecoration.underline,
        ),
      );

  MgTextRich lineThrough() => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          decoration: TextDecoration.lineThrough,
        ),
      );

  MgTextRich letterSpacing([double? spacing = 0]) => copyWith(
        style: (style ?? const TextStyle()).copyWith(letterSpacing: spacing),
      );
}
