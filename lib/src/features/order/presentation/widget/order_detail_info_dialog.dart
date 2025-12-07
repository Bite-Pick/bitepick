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
        if (orderDetail == null) {
          return Center(
            child: Text(
              '주문정보를 불러올 수 없습니다.',
            ).md().textColor(MgColorScheme.gray4),
          );
        }

        final paymentMethodText = _getPaymentMethodText(
          orderDetail.payType,
          orderDetail.easyPayProvider,
        );

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Gaps.h16,
              Center(
                child: Text("주문상세").bold().md().margin(vertical: MgSizes.md),
              ),
              MgTag(child: Text(orderDetail.orderStatus.label)).gray(),
              Gaps.h12,
              Text(orderDetail.storeName).md().bold(),
              Text(orderDetail.storeAddress).textGray().md(),
              Gaps.h12,
              Divider(color: MgColorScheme.gray8, thickness: 1),
              _buildInfoTile(
                "픽업시간",
                orderDetail.pickupTime.convertDate(isLong: true),
              ).margin(vertical: MgSizes.md),
              Divider(color: MgColorScheme.gray8),
              Gaps.h16,
              _buildInfoTile("주문수량", "${orderDetail.quantity}개"),
              Gaps.h8,
              _buildInfoTile("주문금액", '${orderDetail.totalPrice.toPrice()}원'),
              Gaps.h16,
              Divider(color: MgColorScheme.gray8),
              _buildInfoTile(
                "결제수단",
                paymentMethodText,
              ).margin(vertical: MgSizes.md),
              Divider(color: MgColorScheme.gray8),
              Gaps.h16,
              _buildInfoTile(
                "총 결제금액",
                orderDetail.totalPrice.toPrice(),
                style: MgTheme.getInstance().textTheme.bodyLarge!.copyWith(
                  color: MgColorScheme.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // NOTE: 현재 요청사항 field를 사용하지 않음
              // if (orderDetail.memo != null) ...[
              //   Gaps.h16,
              //   Divider(color: MgColorScheme.gray8),
              //   Gaps.h16,
              //   Text("요청사항").bold().sm().textGray(),
              //   Gaps.h8,
              //   Text(orderDetail.memo!).md(),
              // ],
              Gaps.h24,
            ],
          ).margin(horizontal: MgSizes.lg),
        );
      },
    );
  }

  Widget _buildInfoTile(String title, String? subtitle, {TextStyle? style}) {
    if (subtitle == null) return const SizedBox.shrink();
    return DefaultTextStyle(
      style:
          style ??
          MgTheme.getInstance().textTheme.bodyLarge!.copyWith(
            color: MgColorScheme.gray2,
          ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Flexible(
            child: Text(
              subtitle,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // TODO: 전체 결제 수단 확인및 entity로 이동
  String _getPaymentMethodText(String payType, String easyPayProvider) {
    // payType: "PaymentMethodEasyPay", "PaymentMethodCard" 등
    // easyPayProvider: "TOSS", "KAKAO", "NAVER", "PAYCO" 등

    if (payType.contains("EasyPay")) {
      switch (easyPayProvider.toUpperCase()) {
        case "TOSS":
          return "토스페이";
        case "KAKAO":
        case "KAKAOPAY":
          return "카카오페이";
        case "NAVER":
        case "NAVERPAY":
          return "네이버페이";
        case "PAYCO":
          return "페이코";
        default:
          return "간편결제 ($easyPayProvider)";
      }
    } else if (payType.contains("Card")) {
      return "카드결제";
    }

    return payType;
  }
}
