import 'package:flutter/material.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/constants/mg_sizes.dart';

// TODO: isDisabled
// TODO: loading progress animation 추가
class MgButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget content;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? height;
  final double borderRadius;
  final EdgeInsets? padding;
  // TODO: 동작 확인 필요
  final bool fullWidth;
  final bool disabled;

  const MgButton({
    super.key,
    required this.onPressed,
    required this.content,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.height,
    this.borderRadius = MgRadius.md,
    this.padding,
    this.fullWidth = false,
    this.disabled = false,
  });

  MgButton copyWith({
    VoidCallback? onPressed,
    Widget? content,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
    double? height,
    double? borderRadius,
    EdgeInsets? padding,
    bool? fullWidth,
    bool? disabled,
  }) {
    return MgButton(
      onPressed: onPressed ?? this.onPressed,
      content: content ?? this.content,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      borderColor: borderColor ?? this.borderColor,
      height: height ?? this.height,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      fullWidth: fullWidth ?? this.fullWidth,
      disabled: disabled ?? this.disabled,
    );
  }

  MgButton primary({bool whiteBg = false}) => copyWith(
    backgroundColor: whiteBg ? MgColorScheme.white : MgColorScheme.primary,
    textColor: whiteBg ? MgColorScheme.primary : MgColorScheme.text,
    borderColor: whiteBg ? MgColorScheme.primary : null,
  );

  MgButton secondary({bool whiteBg = false}) => copyWith(
    backgroundColor: whiteBg ? MgColorScheme.white : MgColorScheme.secondary,
    textColor: whiteBg ? MgColorScheme.secondary : MgColorScheme.white,
    borderColor: whiteBg ? MgColorScheme.secondary : null,
  );
  MgButton transparent() => copyWith(
    backgroundColor: MgColorScheme.white,
    textColor: MgColorScheme.text,
    borderColor: Colors.transparent,
  );

  MgButton asDisabled() => copyWith(
    backgroundColor: MgColorScheme.gray10,
    textColor: MgColorScheme.white,
    disabled: true,
  );

  MgButton red() => copyWith(
    backgroundColor: MgColorScheme.alertRed,
    textColor: MgColorScheme.white,
    borderColor: Colors.transparent,
  );

  MgButton gray() => copyWith(
    backgroundColor: MgColorScheme.gray9,
    textColor: MgColorScheme.gray1,
    borderColor: null,
  );

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = disabled || onPressed == null;

    // disabled 상태일 때 자동으로 스타일 적용
    final effectiveBackgroundColor = isDisabled
        ? MgColorScheme.gray8
        : backgroundColor;
    final effectiveTextColor = isDisabled
        ? MgColorScheme.gray4
        : (textColor ?? MgColorScheme.text);

    final child = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding:
              padding ??
              const EdgeInsets.symmetric(
                horizontal: MgSizes.md,
                vertical: MgSizes.sm,
              ),
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: borderColor != null
                ? Border.all(color: borderColor!)
                : null,
          ),
          alignment: Alignment.center,
          child: DefaultTextStyle(
            style: TextStyle(
              color: effectiveTextColor,
              fontSize: MgFontSize.md,
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
            child: content,
          ),
        ),
      ),
    );

    // height나 fullWidth가 지정된 경우에만 SizedBox 사용
    if (height != null || fullWidth) {
      return SizedBox(
        width: fullWidth ? double.infinity : null,
        height: height,
        child: child,
      );
    }

    return child;
  }

  /// 텍스트 버튼 (기존 MgButton.text 호환용)
  factory MgButton.text({
    String text = '다음',
    required VoidCallback onPressed,
    bool isActive = true,
  }) {
    return MgButton(
      onPressed: onPressed,
      content: Text(text).md().bold(),
      backgroundColor: isActive
          ? MgColorScheme.primary
          : MgColorScheme.disabled,
      textColor: const Color(0xFF212121),
      height: 52,
      padding: const EdgeInsets.symmetric(vertical: 17),
      fullWidth: true,
      disabled: !isActive,
    );
  }
}
