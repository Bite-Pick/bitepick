import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/order/domain/entities/order.dart';
import 'package:magambell/src/features/order/presentation/widget/order_info_item.dart';
import 'package:magambell/src/widgets/mg_tag.dart';

class OrderListItem extends ConsumerStatefulWidget {
  const OrderListItem(this.order, {super.key});
  final Order order;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderListItemState();
}

class _OrderListItemState extends ConsumerState<OrderListItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MgTag(
          paddingHeight: MgSizes.size2,
          backgroundColor: widget.order.orderStatus.color,
          color: MgColorScheme.gray1,
          child: Text(widget.order.orderStatus.label),
        ),
        Gaps.h8,
        if (widget.order.orderStatus != OrderStatus.completed) ...[
          Text("픽업 예정").lg().bold(), //pickupTime
          Text("픽업 예정 시간을 꼭 지켜서 와주세요!").md().textGray(),
          Gaps.h20,
        ],
        OrderInfoItem(
          imageUrl:
              "https://d1xe26zpyg8fzv.cloudfront.net/STORE/OWNER/758244341543821802/1_b02.jpg",
          storeName: "가게이름",
          address: "경상북도 경산시 백자로 76 3층",
          discount: 10,
          price: 5000,
          count: 2,
        ),
        // TODO: Map
      ],
    ).margin(all: MgSizes.md);
  }
}
