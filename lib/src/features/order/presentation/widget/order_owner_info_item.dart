import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
import 'package:magambell/src/core/extensions/price_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/features/order/domain/entities/order_owner.dart';
import 'package:magambell/src/features/order/domain/entities/order_status.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class OrderOwnerInfoItem extends ConsumerWidget {
  final OrderOwner order;
  final VoidCallback? onReject;
  final VoidCallback? onAccept;

  const OrderOwnerInfoItem(
    this.order, {
    super.key,
    this.onReject,
    this.onAccept,
  });

  String _getPaymentStatusText(OrderStatus status) {
    return switch (status) {
      OrderStatus.canceled => '결제 취소',
      OrderStatus.failed => '결제 실패',
      _ => '결제완료',
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order.orderStatus.label,
            ).sm().textColor(order.orderStatus.color).bold(),
            Text(
              '${order.goodsName} ${order.quantity}개',
            ).md().bold().margin(top: MgSizes.xs, bottom: MgSizes.size2),
            Text(
              '${_getPaymentStatusText(order.orderStatus)} ${order.totalPrice.toPrice()}',
            ),
            _buildPickupTimeSection().margin(vertical: MgSizes.sm),

            _buildInfoRow('연락처', order.phoneNumber),
            Gaps.h8,
            _buildInfoRow('주문일시', _formatTime(order.createdAt)),
            Gaps.h8,
            Text("요청사항").textGray().sm(),
            Gaps.h4,
            Text(order.memo ?? '요청사항 없음').sm().regular(),

            // 버튼 영역
            if (_buildActionButtons() != null) ...[
              Gaps.h16,
              _buildActionButtons()!,
            ],
          ],
        )
        .margin(all: MgSizes.xl)
        .decorated(
          color: Colors.white,
          borderRadius: BorderRadius.circular(MgRadius.md),
          border: Border.all(color: MgColorScheme.gray8, width: 1),
        );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label).sm().textColor(MgColorScheme.gray4),
        Spacer(),
        Text(value).sm().textColor(MgColorScheme.gray2),
      ],
    );
  }

  Widget? _buildActionButtons() {
    return switch (order.orderStatus) {
      OrderStatus.pending || OrderStatus.paid => Row(
        children: [
          Expanded(
            child: MgButton(
              onPressed: onReject,
              content: Text("주문 거절").textColor(MgColorScheme.gray2),
            ).gray(),
          ),
          Gaps.w8,
          Expanded(
            child: MgButton(
              onPressed: onAccept,
              content: Text("주문 수락"),
            ).primary(),
          ),
        ],
      ),
      OrderStatus.accepted => Row(
        children: [
          Expanded(
            child: MgButton(
              onPressed: onReject,
              content: Text("주문 취소").textColor(MgColorScheme.gray2),
            ).gray(),
          ),
          Gaps.w8,
          Expanded(
            child: MgButton(
              onPressed: onAccept,
              content: Text("준비 완료"),
            ).primary(),
          ),
        ],
      ),
      _ => null,
    };
  }

  Widget _buildPickupTimeSection() {
    return DefaultTextStyle(
      style: MgTheme.getInstance().textTheme.titleMedium!,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseSvgIcon.filledTime(size: MgSizes.md).margin(all: MgSizes.size4),
          Text("픽업시간"),
          Spacer(),
          Text(order.pickupTime.format("HH:mm")), //TODO: AM,PM?
        ],
      ).margin(all: MgSizes.xs).decorated(color: MgColorScheme.lightest),
    );
  }

  String _formatTime(DateTime time) {
    final formatter = DateFormat('yyyy/M/d HH:mm');
    return formatter.format(time);
  }
}
