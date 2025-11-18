import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/list_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/order/domain/entities/order_reject_reason.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class OrderRejectDialog extends StatelessWidget {
  final Function(OrderRejectReason reason) onConfirm;

  const OrderRejectDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    OrderRejectReason? selectedReason;
    final reasons = OrderRejectReason.values;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MgRadius.md),
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            width: 300,
            padding: EdgeInsets.all(MgSizes.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('주문 거절').lg().bold().textColor(MgColorScheme.gray1),
                Text(
                  '주문 거절 사유를 선택해주세요',
                ).sm().textGray().margin(top: MgSizes.xss, bottom: MgSizes.xl),
                ...reasons
                    .map(
                      (reason) => _buildReasonOption(
                        context,
                        reason,
                        selectedReason,
                        (value) => setState(() => selectedReason = value),
                      ),
                    )
                    .joinWithWidget(Gaps.h8),
                Gaps.h24,

                // 주문 거절 완료 버튼
                MgButton(
                  onPressed: selectedReason != null
                      ? () {
                          context.pop();
                          onConfirm(selectedReason!);
                        }
                      : null,
                  content: Text('주문 거절 완료').textColor(
                    selectedReason != null
                        ? MgColorScheme.text
                        : MgColorScheme.gray4,
                  ),
                  backgroundColor: selectedReason != null
                      ? MgColorScheme.primary
                      : MgColorScheme.gray7,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildReasonOption(
    BuildContext context,
    OrderRejectReason reason, // Changed type to RejectReason
    OrderRejectReason? selectedReason, // Changed type to RejectReason?
    Function(OrderRejectReason)
    onSelect, // Changed type to Function(RejectReason)
  ) {
    final isSelected = selectedReason == reason;

    return GestureDetector(
      onTap: () => onSelect(reason),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: MgSizes.lg,
          vertical: MgSizes.md,
        ),
        decoration: BoxDecoration(
          color: isSelected ? MgColorScheme.lightest : Colors.white,
          borderRadius: BorderRadius.circular(MgRadius.sm),
          border: Border.all(
            color: isSelected ? MgColorScheme.primary : MgColorScheme.gray7,
            width: 1,
          ),
        ),
        child:
            Text(reason.description) // Display the description
                .sm()
                .bold()
                .textColor(
                  isSelected ? MgColorScheme.gray1 : MgColorScheme.gray4,
                )
                .center(),
      ),
    );
  }
}
