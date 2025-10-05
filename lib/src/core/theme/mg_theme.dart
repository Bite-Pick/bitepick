import 'package:flutter/material.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';

class MgTheme {
  MgTheme._();

  static MgTheme? _instance;

  static MgTheme getInstance() {
    _instance ??= MgTheme._();
    return _instance!;
  }

  // Theme Data
  ThemeData get themeData {
    final colorScheme = ColorScheme.light(
      primary: MgColorScheme.primary,
      secondary: MgColorScheme.secondary,
      surface: MgColorScheme.background,
      error: MgColorScheme.subpointRed,
      onPrimary: MgColorScheme.black,
      onSecondary: MgColorScheme.white,
      onSurface: MgColorScheme.text,
      onError: MgColorScheme.white,
    );

    return ThemeData(
      textTheme: mgTextTheme(colorScheme),
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: MgColorScheme.background,
      fontFamily: MgFontFamily.regular,
      useMaterial3: true,
      dividerTheme: const DividerThemeData(
        color: MgColorScheme.divider,
        thickness: 1,
        space: 1,
      ),
    );
  }

  // Semantic Color Scheme
  MgSemanticColorScheme get semanticColorScheme => const MgSemanticColorScheme(
    primary: MgColorScheme.primary,
    secondary: MgColorScheme.secondary,
    success: MgColorScheme.subpointGreen,
    warning: MgColorScheme.primary,
    danger: MgColorScheme.subpointRed,
    text: MgColorScheme.text,
    subText: MgColorScheme.gray,
    optionalText: MgColorScheme.inactive,
    reversedText: MgColorScheme.white,
    background: MgColorScheme.background,
    surface: MgColorScheme.white,
    divider: MgColorScheme.divider,
    border: MgColorScheme.gray7,
  );
}

/// 시맨틱 컬러 스키마 (의미론적 색상)
class MgSemanticColorScheme {
  final Color primary;
  final Color secondary;
  final Color success;
  final Color warning;
  final Color danger;
  final Color text;
  final Color subText;
  final Color optionalText;
  final Color reversedText;
  final Color background;
  final Color surface;
  final Color divider;
  final Color border;

  const MgSemanticColorScheme({
    required this.primary,
    required this.secondary,
    required this.success,
    required this.warning,
    required this.danger,
    required this.text,
    required this.subText,
    required this.optionalText,
    required this.reversedText,
    required this.background,
    required this.surface,
    required this.divider,
    required this.border,
  });
}

// 추후 다크테마 구분시 활용
extension MgThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  MgSemanticColorScheme get semanticColors =>
      MgTheme.getInstance().semanticColorScheme;
}
