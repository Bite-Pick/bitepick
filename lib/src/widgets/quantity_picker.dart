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
  final MainAxisAlignment alignment;
  final Color backgroundColor;
  final int? maxCount;
  final VoidCallback? onMaxReached;

  const QuantityPicker({
    super.key,
    required this.count,
    required this.onCountChanged,
    this.alignment = MainAxisAlignment.center,
    this.backgroundColor = MgColorScheme.gray8,
    this.maxCount,
    this.onMaxReached,
  });

  @override
  Widget build(BuildContext context) {
    final isMaxReached = maxCount != null && count >= maxCount!;
    return Container(
      constraints: BoxConstraints(minHeight: 48),
      padding: EdgeInsets.symmetric(
        horizontal: MgSizes.md,
        vertical: MgSizes.sm,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: alignment,
        children: [
          GestureDetector(
            onTap: count > 1 ? () => onCountChanged(count - 1) : null,
            child: BaseSvgIcon.minus(),
          ),
          Text('$count').md().margin(
            horizontal: MgSizes.xxl,
          ), // NOTE: 다량 구매 고객 많을시 숫자 선택 bottomSheet 나오도록
          GestureDetector(
            child: BaseSvgIcon.plus(),
            onTap: isMaxReached ? onMaxReached : () => onCountChanged(count + 1),
          ),
        ],
      ),
    );
  }
}
