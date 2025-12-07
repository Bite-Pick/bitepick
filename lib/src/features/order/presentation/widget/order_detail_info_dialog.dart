import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
import 'package:magambell/src/core/extensions/price_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/features/order/data/repositories/order_repository.dart';
import 'package:magambell/src/features/order/domain/entities/order_guest_status.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';
import 'package:magambell/src/widgets/mg_tag.dart';

// TODO: UI 구성 확인 필요
class OrderDetailInfoDialog extends ConsumerWidget {
  const OrderDetailInfoDialog(this.orderId, {super.key});
  final String orderId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderDetailAsync = ref.watch(
      userOrderDetailProvider(orderId: orderId),
    );

    return MgAsyncAnimatedSwitcher(
      asyncValue: orderDetailAsync,
      builder: (orderDetail) {
        if (orderDetail == null) return SizedBox.shrink(); // TODO: 확인 필요
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("주문상세").center().margin(vertical: MgSizes.md),
            MgTag(child: Text(orderDetail.orderStatus.label)).gray(),
            Gaps.h12,
            Text(orderDetail.storeName).md().bold(),
            Text(orderDetail.storeAddress).textGray().md(),
            Divider(),
            _buildInfoTile(
              "픽업시간",
              orderDetail.pickupTime.convertDate(isLong: true),
            ).margin(vertical: MgSizes.md),
            Divider(),
            Gaps.h16,
            _buildInfoTile("주문금액", orderDetail.totalPrice.toPrice()),
            Gaps.h8,
            _buildInfoTile("즉시할인", orderDetail.totalPrice.toPrice()),
            Gaps.h16,
            Divider(),
            _buildInfoTile(
              "결제수단",
              orderDetail.payType,
            ).margin(vertical: MgSizes.md),
            Divider(),
            Gaps.h16,
            _buildInfoTile(
              "총 결제금액",
              orderDetail.totalPrice.toPrice(),
              style: MgTheme.getInstance().textTheme.bodyLarge!.copyWith(
                color: MgColorScheme.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ).margin(horizontal: MgSizes.lg);
      },
    );
  }

  Widget _buildInfoTile(String title, String? subtitle, {TextStyle? style}) {
    if (subtitle == null) return SizedBox.shrink();
    return DefaultTextStyle(
      style:
          style ??
          MgTheme.getInstance().textTheme.bodyLarge!.copyWith(
            color: MgColorScheme.gray2,
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), Text(subtitle)],
      ),
    );
  }
}
