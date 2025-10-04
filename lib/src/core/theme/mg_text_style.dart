import 'package:flutter/material.dart';
import 'package:magambell/src/core/theme/mg_color.dart';

/// 마감벨 폰트 패밀리
class MgFontFamily {
  MgFontFamily._();

  static const String black = 'Pretendard-Black'; // 900
  static const String extraBold = 'Pretendard-ExtraBold'; // 800
  static const String bold = 'Pretendard-Bold'; // 700
  static const String semiBold = 'Pretendard-SemiBold'; // 600
  static const String medium = 'Pretendard-Medium'; // 500
  static const String regular = 'Pretendard-Regular'; // 400
  static const String light = 'Pretendard-Light'; // 300
  static const String extraLight = 'Pretendard-ExtraLight'; // 200
  static const String thin = 'Pretendard-Thin'; // 100
}

/// 마감벨 폰트 사이즈
class MgFontSize {
  MgFontSize._();

  static const double xxl = 28.0;
  static const double xl = 24.0;
  static const double lg = 20.0;
  static const double md = 16.0;
  static const double sm = 14.0;
  static const double xs = 12.0;
  static const double xxs = 10.0;
}

extension MgStyledText on Text {
  Text copyWith({
    String? data,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) => Text(
    data ?? this.data!,
    style: style ?? this.style,
    textAlign: textAlign ?? this.textAlign,
    overflow: overflow ?? this.overflow,
    maxLines: maxLines ?? this.maxLines,
  );

  /* ******************* Color ******************* */

  Text primary() => copyWith(
    style: (style ?? const TextStyle()).copyWith(color: MgColorScheme.primary),
  );

  Text secondary() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      color: MgColorScheme.secondary,
    ),
  );

  Text subpointRed() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      color: MgColorScheme.subpointRed,
    ),
  );

  Text subpointGreen() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      color: MgColorScheme.subpointGreen,
    ),
  );

  Text subpointPink() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      color: MgColorScheme.subpointPink,
    ),
  );

  Text textMain() => copyWith(
    style: (style ?? const TextStyle()).copyWith(color: MgColorScheme.text),
  );

  Text textGray() => copyWith(
    style: (style ?? const TextStyle()).copyWith(color: MgColorScheme.gray),
  );

  Text textInactive() => copyWith(
    style: (style ?? const TextStyle()).copyWith(color: MgColorScheme.inactive),
  );

  Text textHeader() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      color: MgColorScheme.headerText,
    ),
  );

  Text white() => copyWith(
    style: (style ?? const TextStyle()).copyWith(color: MgColorScheme.white),
  );

  Text black() => copyWith(
    style: (style ?? const TextStyle()).copyWith(color: MgColorScheme.black),
  );

  Text textColor(Color? color) =>
      copyWith(style: (style ?? const TextStyle()).copyWith(color: color));

  /* ******************* Weight ******************* */

  Text thin() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontFamily: MgFontFamily.thin,
      fontWeight: FontWeight.w100,
    ),
  );

  Text extraLight() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontFamily: MgFontFamily.extraLight,
      fontWeight: FontWeight.w200,
    ),
  );

  Text light() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontFamily: MgFontFamily.light,
      fontWeight: FontWeight.w300,
    ),
  );

  Text regular() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontFamily: MgFontFamily.regular,
      fontWeight: FontWeight.w400,
    ),
  );

  Text medium() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontFamily: MgFontFamily.medium,
      fontWeight: FontWeight.w500,
    ),
  );

  Text semibold() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontFamily: MgFontFamily.semiBold,
      fontWeight: FontWeight.w600,
    ),
  );

  Text bold() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontFamily: MgFontFamily.bold,
      fontWeight: FontWeight.w700,
    ),
  );

  Text extraBold() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontFamily: MgFontFamily.extraBold,
      fontWeight: FontWeight.w800,
    ),
  );

  Text black900() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontFamily: MgFontFamily.black,
      fontWeight: FontWeight.w900,
    ),
  );

  Text fontWeight(FontWeight? fontWeight) => copyWith(
    style: (style ?? const TextStyle()).copyWith(fontWeight: fontWeight),
  );

  /* ******************* Align ******************* */

  Text center() => copyWith(textAlign: TextAlign.center);
  Text left() => copyWith(textAlign: TextAlign.left);
  Text right() => copyWith(textAlign: TextAlign.right);
  Text align(TextAlign? align) => copyWith(textAlign: align);

  /* ******************* Size ******************* */

  Text xxs() => copyWith(
    style: (style ?? const TextStyle()).copyWith(fontSize: MgFontSize.xxs),
  );

  Text xs() => copyWith(
    style: (style ?? const TextStyle()).copyWith(fontSize: MgFontSize.xs),
  );

  Text sm() => copyWith(
    style: (style ?? const TextStyle()).copyWith(fontSize: MgFontSize.sm),
  );

  Text md() => copyWith(
    style: (style ?? const TextStyle()).copyWith(fontSize: MgFontSize.md),
  );

  Text lg() => copyWith(
    style: (style ?? const TextStyle()).copyWith(fontSize: MgFontSize.lg),
  );

  Text xl() => copyWith(
    style: (style ?? const TextStyle()).copyWith(fontSize: MgFontSize.xl),
  );

  Text xxl() => copyWith(
    style: (style ?? const TextStyle()).copyWith(fontSize: MgFontSize.xxl),
  );

  Text fontSize(double? size) =>
      copyWith(style: (style ?? const TextStyle()).copyWith(fontSize: size));

  /* ******************* Etc ******************* */

  Text height(double height) =>
      copyWith(style: (style ?? const TextStyle()).copyWith(height: height));

  Text max(int maxLines) => copyWith(maxLines: maxLines);

  Text ellipsis() => copyWith(overflow: TextOverflow.ellipsis);

  Text clip() => copyWith(overflow: TextOverflow.clip);

  Text fade() => copyWith(overflow: TextOverflow.fade);

  Text underline() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      decoration: TextDecoration.underline,
    ),
  );

  Text lineThrough() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      decoration: TextDecoration.lineThrough,
    ),
  );

  Text italic() => copyWith(
    style: (style ?? const TextStyle()).copyWith(fontStyle: FontStyle.italic),
  );

  Text letterSpacing([double? spacing = 0]) => copyWith(
    style: (style ?? const TextStyle()).copyWith(letterSpacing: spacing),
  );

  Text decorationThickness(double thickness, Color color) => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      decorationThickness: thickness,
      decorationColor: color,
    ),
  );
}

extension MgStyledTextSpan on TextSpan {
  TextSpan copyWith({TextStyle? style}) => TextSpan(
    text: text,
    children: children,
    style: style ?? this.style,
    recognizer: recognizer,
    semanticsLabel: semanticsLabel,
  );

  /* ******************* Color ******************* */

  TextSpan primary() => copyWith(
    style: (style ?? const TextStyle()).copyWith(color: MgColorScheme.primary),
  );

  TextSpan secondary() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      color: MgColorScheme.secondary,
    ),
  );

  TextSpan subpointRed() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      color: MgColorScheme.subpointRed,
    ),
  );

  TextSpan subpointGreen() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      color: MgColorScheme.subpointGreen,
    ),
  );

  TextSpan subpointPink() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      color: MgColorScheme.subpointPink,
    ),
  );

  TextSpan textMain() => copyWith(
    style: (style ?? const TextStyle()).copyWith(color: MgColorScheme.text),
  );

  TextSpan textGray() => copyWith(
    style: (style ?? const TextStyle()).copyWith(color: MgColorScheme.gray),
  );

  TextSpan white() => copyWith(
    style: (style ?? const TextStyle()).copyWith(color: MgColorScheme.white),
  );

  TextSpan black() => copyWith(
    style: (style ?? const TextStyle()).copyWith(color: MgColorScheme.black),
  );

  TextSpan textColor(Color? color) =>
      copyWith(style: (style ?? const TextStyle()).copyWith(color: color));

  /* ******************* Weight ******************* */

  TextSpan thin() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontFamily: MgFontFamily.thin,
      fontWeight: FontWeight.w100,
    ),
  );

  TextSpan light() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontFamily: MgFontFamily.light,
      fontWeight: FontWeight.w300,
    ),
  );

  TextSpan regular() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontFamily: MgFontFamily.regular,
      fontWeight: FontWeight.w400,
    ),
  );

  TextSpan medium() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontFamily: MgFontFamily.medium,
      fontWeight: FontWeight.w500,
    ),
  );

  TextSpan semibold() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontFamily: MgFontFamily.semiBold,
      fontWeight: FontWeight.w600,
    ),
  );

  TextSpan bold() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontFamily: MgFontFamily.bold,
      fontWeight: FontWeight.w700,
    ),
  );

  TextSpan extraBold() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontFamily: MgFontFamily.extraBold,
      fontWeight: FontWeight.w800,
    ),
  );

  TextSpan black900() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontFamily: MgFontFamily.black,
      fontWeight: FontWeight.w900,
    ),
  );

  TextSpan fontWeight(FontWeight? fontWeight) => copyWith(
    style: (style ?? const TextStyle()).copyWith(fontWeight: fontWeight),
  );

  /* ******************* Size ******************* */

  TextSpan xxs() => copyWith(
    style: (style ?? const TextStyle()).copyWith(fontSize: MgFontSize.xxs),
  );

  TextSpan xs() => copyWith(
    style: (style ?? const TextStyle()).copyWith(fontSize: MgFontSize.xs),
  );

  TextSpan sm() => copyWith(
    style: (style ?? const TextStyle()).copyWith(fontSize: MgFontSize.sm),
  );

  TextSpan md() => copyWith(
    style: (style ?? const TextStyle()).copyWith(fontSize: MgFontSize.md),
  );

  TextSpan lg() => copyWith(
    style: (style ?? const TextStyle()).copyWith(fontSize: MgFontSize.lg),
  );

  TextSpan xl() => copyWith(
    style: (style ?? const TextStyle()).copyWith(fontSize: MgFontSize.xl),
  );

  TextSpan xxl() => copyWith(
    style: (style ?? const TextStyle()).copyWith(fontSize: MgFontSize.xxl),
  );

  TextSpan fontSize(double? size) =>
      copyWith(style: (style ?? const TextStyle()).copyWith(fontSize: size));

  /* ******************* Etc ******************* */

  TextSpan height(double height) =>
      copyWith(style: (style ?? const TextStyle()).copyWith(height: height));

  TextSpan underline() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      decoration: TextDecoration.underline,
    ),
  );

  TextSpan lineThrough() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      decoration: TextDecoration.lineThrough,
    ),
  );

  TextSpan letterSpacing([double? spacing = 0]) => copyWith(
    style: (style ?? const TextStyle()).copyWith(letterSpacing: spacing),
  );
}
