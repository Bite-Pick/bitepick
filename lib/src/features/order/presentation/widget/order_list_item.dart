import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/utils/inquiry_button.dart';
import 'package:magambell/src/features/map/presentation/widget/store_location_info_view.dart';
import 'package:magambell/src/features/order/data/repositories/order_repository.dart';
import 'package:magambell/src/features/order/domain/entities/order_guest_status.dart';
import 'package:magambell/src/features/order/domain/entities/order_list_item_state.dart';
import 'package:magambell/src/features/order/presentation/widget/order_detail_info_dialog.dart';
import 'package:magambell/src/features/order/presentation/widget/order_info_item.dart';
import 'package:magambell/src/features/review/presentation/reivew_register_screen.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_alert_dialog.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/mg_tag.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';

class OrderListItem extends ConsumerStatefulWidget {
  const OrderListItem(this.order, {super.key});
  final OrderListItemState order;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderListItemState();
}

class _OrderListItemState extends ConsumerState<OrderListItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleSection(),
        Gaps.h8,
        if (widget.order.orderStatus != OrderGuestStatus.completed) ...[
          Text(
            "${widget.order.pickupTime?.convertTime()}픽업 예정",
          ).lg().bold(), // 오후 추가
          Text("픽업 예정 시간을 꼭 지켜서 와주세요!").md().textGray(),
          Gaps.h20,
        ],
        OrderInfoItem(
          imageUrl: widget.order.imageUrls[0],
          storeName: widget.order.storeName,
          address: widget.order.address ?? "",
          discount: widget.order.discount ?? 0,
          price: widget.order.salePrice,
          count: widget.order.quantity,
        ),
        Gaps.h16,
        if (widget.order.orderStatus != OrderGuestStatus.completed)
          StoreLocationInfoView(
            storeId: widget.order.storeId,
            address: widget.order.address ?? "",
            latitude: widget.order.latitude,
            longitude: widget.order.latitude,
            storeName: widget.order.storeName,
            mapHeight: 160,
          ),

        _buildActions(),
      ],
    ).margin(horizontal: MgSizes.md);
  }

  Widget _buildTitleSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MgTag(
          paddingHeight: MgSizes.size2,
          backgroundColor: widget.order.orderStatus.color,
          color: MgColorScheme.gray1,
          child: Text(widget.order.orderStatus.label),
        ),
        Gaps.w8,
        Text(widget.order.createdAt.convertDate(isLong: true) ?? "").textGray(),
        Spacer(),
        MgButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) =>
                  Dialog(child: OrderDetailInfoDialog(widget.order.orderId)),
            );
          },
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("주문상세").textGray().xs(),
              BaseSvgIcon.right(size: MgSizes.lg, color: MgColorScheme.gray4),
            ],
          ),
          padding: Gutter.hlg + Gutter.wsm.copyWith(right: 0),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return switch (widget.order.orderStatus) {
      OrderGuestStatus.pending || OrderGuestStatus.paid => MgButton(
        content: Text("주문 취소").textGray().regular(),
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) => MgAlertDialog(
              title: '주문 취소',
              content: Text('주문을 취소하시겠습니까?'),
              onConfirm: () {
                ref
                    .read(orderRepositoryProvider)
                    .cancelOrder(widget.order.orderId);
              },

              // TODO: +)주문내역 리스트 리로드
            ),
          );
        },
      ),
      OrderGuestStatus.completed => MgButton(
        onPressed: () async {
          if (widget.order.orderGoodsId == null) {
            ToastPresentor.error(context, "리뷰 작성이 불가능한 주문입니다.");
            return;
          }
          await ReviewRegisterRoute(
            orderGoodsId: widget.order.orderGoodsId!,
          ).push(context);
        },
        content: Text("리뷰쓰기").sm(),
        padding: Gutter.hxs,
      ).primary(),
      _ => MgButton(
        content: Text("문의하기").sm().regular(),
        onPressed: () {
          return InquiryButton.showInquiryBottomSheet(context);
        },
        padding: Gutter.hxs,
      ),
    };
  }
}
