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
import 'package:magambell/src/features/order/domain/entities/order_owner_status.dart';
import 'package:magambell/src/features/order/presentation/widget/order_accept_dialog.dart';
import 'package:magambell/src/features/order/presentation/widget/order_reject_dialog.dart';
import 'package:magambell/src/features/owner/prsentation/owner_order_list_view.controller.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_alert_dialog.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class OrderOwnerInfoItem extends ConsumerStatefulWidget {
  final OrderOwner order;

  const OrderOwnerInfoItem(this.order, {super.key});

  @override
  ConsumerState<OrderOwnerInfoItem> createState() => _OrderOwnerInfoItemState();
}

class _OrderOwnerInfoItemState extends ConsumerState<OrderOwnerInfoItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.order.orderStatus.label,
            ).sm().textColor(widget.order.orderStatus.color).bold(),
            Text(
              '${widget.order.goodsName} ${widget.order.quantity}개',
            ).md().bold().margin(top: MgSizes.xs, bottom: MgSizes.size2),
            Text(
              '${_getPaymentStatusText()} ${widget.order.totalPrice.toPrice()}',
            ),
            _buildPickupTimeSection().margin(vertical: MgSizes.sm),

            _buildInfoRow('연락처', widget.order.phoneNumber),
            Gaps.h8,
            _buildInfoRow('주문일시', _formatTime(widget.order.createdAt)),
            Gaps.h8,
            Text("요청사항").textGray().sm(),
            Gaps.h4,
            Text(widget.order.memo ?? '요청사항 없음').sm().regular(),

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
        const Spacer(),
        Text(value).sm().textColor(MgColorScheme.gray2),
      ],
    );
  }

  Widget? _buildActionButtons() {
    return switch (widget.order.orderStatus) {
      OrderOwnerStatus.paid => Row(
        children: [
          Expanded(
            child: MgButton(
              onPressed: _showRejectDialog,
              content: Text("주문 거절").textColor(MgColorScheme.gray2),
            ).gray(),
          ),
          Gaps.w8,
          Expanded(
            child: MgButton(
              onPressed: _showAcceptDialog,
              content: const Text("주문 수락"),
            ).primary(),
          ),
        ],
      ),
      OrderOwnerStatus.accepted => Row(
        children: [
          Expanded(
            child: MgButton(
              onPressed: _showCancelDialog,
              content: Text("주문 취소").textColor(MgColorScheme.gray2),
            ).gray(),
          ),
          Gaps.w8,
          Expanded(
            child: MgButton(
              onPressed: _showCompleteDialog,
              content: const Text("준비 완료"),
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
          const Text("픽업시간"),
          const Spacer(),
          Text(widget.order.pickupTime.format("HH:mm")), //TODO: AM,PM?
        ],
      ).margin(all: MgSizes.xs).decorated(color: MgColorScheme.lightest),
    );
  }

  String _formatTime(DateTime time) {
    final formatter = DateFormat('yyyy/M/d HH:mm');
    return formatter.format(time);
  }

  String _getPaymentStatusText() {
    return switch (widget.order.orderStatus) {
      // OrderStatus.canceled => '결제 취소',
      // OrderStatus.failed => '결제 실패',
      _ => '결제완료',
    };
  }

  void _showAcceptDialog() {
    showDialog(
      context: context,
      builder: (context) => OrderAcceptDialog(
        onConfirm: () => ref
            .read(ownerOrderListControllerProvider.notifier)
            .approveOrder(widget.order.orderId),
      ),
    );
  }

  void _showRejectDialog() {
    showDialog(
      context: context,
      builder: (context) => OrderRejectDialog(
        onConfirm: (reason) => ref
            .read(ownerOrderListControllerProvider.notifier)
            .rejectOrder(widget.order.orderId, rejectReason: reason),
      ),
    );
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (context) => MgAlertDialog(
        title: '주문 취소',
        content: Text('주문을 취소하시겠습니까?'),
        onConfirm: () => ref
            .read(ownerOrderListControllerProvider.notifier)
            .cancelOrder(widget.order.orderId),
      ),
    );
  }

  void _showCompleteDialog() {
    showDialog(
      context: context,
      builder: (context) => MgAlertDialog(
        title: '준비 완료',
        content: Text('준비 완료 처리하시겠습니까?'),
        onConfirm: () => ref
            .read(ownerOrderListControllerProvider.notifier)
            .completeOrder(widget.order.orderId),
      ),
    );
  }
}
