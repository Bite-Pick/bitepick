import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Reactive Form Item 위젯
///
/// [label] - 폼 라벨
/// [errorText, helperText] - 에러 및 도움말 텍스트
///
/// Usage:
/// ```dart
/// MgFormItem<String>(
///   name: 'email',
///   label: Text('이메일'),
///   helper: Text('이메일을 입력해주세요'),
///   child: MgTextField(hintText: 'example@mail.com'),
/// )
/// ```
class MgFormItem<T> extends ReactiveFormField<T, T> {
  MgFormItem({
    required this.child,
    required this.name,
    super.key,
    super.validationMessages,
    this.label,
    this.showError = true,
    this.helper,
  }) : super(
          formControlName: name,
          showErrors: !showError ? (_) => false : null,
          builder: (field) {
            final isError = field.errorText?.isNotEmpty ?? false;

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label
                if (label != null) ...[
                  DefaultTextStyle(
                    style: const TextStyle().md().bold(),
                    child: label,
                  ),
                  Gaps.h8,
                ],

                // Child Widget
                child,

                // Error Message
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  child: isError
                      ? Column(
                          children: [
                            Gaps.h4,
                            Text(
                              field.errorText ?? "",
                              style: const TextStyle()
                                  .sm()
                                  .copyWith(color: MgColorScheme.red),
                            ),
                          ],
                        )
                      : const Offstage(),
                ),

                // Helper Message
                if (helper != null && !isError) ...[
                  Gaps.h4,
                  DefaultTextStyle(
                    style: const TextStyle().sm().textGray(),
                    child: helper,
                  ),
                ],
              ],
            );
          },
        );

  final Widget child;
  final Widget? label;
  final Widget? helper;
  final String name;
  final bool showError;

  /// Context에서 가장 가까운 MgFormItem 찾기
  static MgFormItem? maybeOf(BuildContext context) {
    return context.findAncestorWidgetOfExactType<MgFormItem>();
  }

  /// MgFormItem 복사
  MgFormItem copyWith({
    String? name,
    Widget? child,
    Widget? label,
    Widget? helper,
  }) =>
      MgFormItem(
        key: key,
        name: name ?? this.name,
        label: label ?? this.label,
        helper: helper ?? this.helper,
        showError: showError,
        validationMessages: super.validationMessages,
        child: child ?? this.child,
      );

  @override
  ReactiveFormFieldState<T, T> createState() => ReactiveFormFieldState<T, T>();
}
