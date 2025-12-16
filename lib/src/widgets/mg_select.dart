import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_bottomsheet.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// 선택 옵션 모델
class MgSelectOption<T> {
  const MgSelectOption({required this.value, required this.label, this.icon});

  final T value;
  final String label;
  final Widget? icon;
}

class MgSelect<T> extends ReactiveFormField<T, T> {
  MgSelect({
    required this.options,
    super.key,
    super.formControlName,
    this.hintText,
    this.readOnly = false,
    this.enabled = true,
    this.customBottomSheet,
    this.bottomSheetTitle,
  }) : super(
         builder: (ReactiveFormFieldState<T, T> field) {
           final value = field.value;
           MgSelectOption<T>? selectedOption;
           try {
             selectedOption = options.firstWhere((opt) => opt.value == value);
           } catch (_) {
             selectedOption = null;
           }

           return GestureDetector(
             onTap: enabled && !readOnly
                 ? () => customBottomSheet != null
                       ? customBottomSheet(field.context, field, options)
                       : _showSelectBottomSheet(
                           field.context,
                           field,
                           options,
                           bottomSheetTitle,
                         )
                 : null,
             child: Container(
               padding: const EdgeInsets.symmetric(
                 horizontal: MgSizes.md,
                 vertical: MgSizes.sm,
               ),
               decoration: BoxDecoration(
                 color: enabled ? Colors.transparent : MgColorScheme.gray9,
                 borderRadius: BorderRadius.circular(12),
                 border: Border.all(
                   color: field.errorText != null
                       ? MgColorScheme.systemError
                       : MgColorScheme.gray8,
                   width: 1,
                 ),
               ),
               child: Row(
                 children: [
                   if (value != null && selectedOption?.icon != null) ...[
                     selectedOption!.icon!,
                     Gaps.w8,
                   ],
                   Expanded(
                     child:
                         Text(
                           value != null && selectedOption != null
                               ? selectedOption.label
                               : (hintText ?? ''),
                         ).md().textColor(
                           value != null
                               ? MgColorScheme.gray1
                               : MgColorScheme.gray1,
                         ),
                   ),
                   BaseSvgIcon.down(size: 20),
                 ],
               ),
             ),
           );
         },
       );

  final List<MgSelectOption<T>> options;
  final String? hintText;
  final bool readOnly;
  final bool enabled;
  final void Function(
    BuildContext context,
    ReactiveFormFieldState<T, T> field,
    List<MgSelectOption<T>> options,
  )?
  customBottomSheet;
  final String? bottomSheetTitle;

  static void _showSelectBottomSheet<T>(
    BuildContext context,
    ReactiveFormFieldState<T, T> field,
    List<MgSelectOption<T>> options,
    String? title,
  ) {
    MgBottomsheet.show(context, (context, bottomState) {
      return MgBottomsheet(
        SizedBox(
          height: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title ?? '선택해주세요',
              ).lg().bold().margin(vertical: MgSizes.md, horizontal: MgSizes.md),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: options
                        .map(
                          (option) => _buildSelectItem(
                            context,
                            field,
                            option,
                            isSelected: field.value == option.value,
                          ),
                        )
                        .toList(),
                  ).margin(horizontal: MgSizes.md, bottom: MgSizes.md),
                ),
              ),
            ],
          ),
        ),
      );
    }, height: 400);
  }

  static Widget _buildSelectItem<T>(
    BuildContext context,
    ReactiveFormFieldState<T, T> field,
    MgSelectOption<T> option, {
    bool isSelected = false,
  }) {
    return GestureDetector(
      onTap: () {
        field.didChange(option.value);
        Navigator.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.all(MgSizes.md),
        margin: const EdgeInsets.only(bottom: MgSizes.xs),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: MgColorScheme.gray4, width: 1)
              : null,
          color: isSelected ? MgColorScheme.gray10 : null,
        ),
        child: Row(
          children: [
            if (option.icon != null) ...[option.icon!, Gaps.w12],
            Expanded(child: Text(option.label).md()),
            if (isSelected) BaseSvgIcon.check(size: 20),
          ],
        ),
      ),
    );
  }

  @override
  ReactiveFormFieldState<T, T> createState() => ReactiveFormFieldState<T, T>();
}
