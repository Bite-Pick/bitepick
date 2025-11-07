import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';

/// 수량 선택 위젯
///
/// MgFormItem과 함께 사용:
/// ```dart
/// MgFormItem<int>(
///   name: 'quantity',
///   child: QuantityPicker(
///     count: value,
///     onCountChanged: (newValue) => control.value = newValue,
///   ),
/// )
/// ```
class QuantityPicker extends StatelessWidget {
  final int count;
  final ValueChanged<int> onCountChanged;

  const QuantityPicker({
    super.key,
    required this.count,
    required this.onCountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: BaseSvgIcon.minus(),
          onTap: count > 0 ? () => onCountChanged(count - 1) : null,
        ),
        Text('$count').md().margin(
          horizontal: MgSizes.xxl,
        ), // NOTE: 다량 구매 고객 많을시 숫자 선택 bottomSheet 나오도록
        GestureDetector(
          child: BaseSvgIcon.plus(),
          onTap: () => onCountChanged(count + 1),
        ),
      ],
    )
        .margin(all: MgSizes.sm)
        .decorated(
          color: MgColorScheme.gray8,
          borderRadius: BorderRadius.circular(8),
        );
  }
}
