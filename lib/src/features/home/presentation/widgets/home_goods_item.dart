import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
import 'package:magambell/src/core/extensions/price_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/goods/data/dtos/store_list.dto.dart';
import 'package:magambell/src/features/home/domain/entities/home_goods_item_data.dart';
import 'package:magambell/src/features/store/presentation/store_screen.dart';
import 'package:magambell/src/features/store/presentation/widget/store_image_section.dart';
import 'package:magambell/src/features/store/presentation/widget/store_tags.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';

class HomeGoodsItem extends StatefulWidget {
  const HomeGoodsItem({super.key, required this.goods});

  final HomeGoodsItemData goods;

  @override
  State<HomeGoodsItem> createState() => _HomeGoodsItemState();
}

class _HomeGoodsItemState extends State<HomeGoodsItem> {
  @override
  Widget build(BuildContext context) {
    final goods = widget.goods;
    return GestureDetector(
      onTap: () => StoreRoute(id: goods.storeId!).push(context),
      child: Column(
        children: [
          StoreImageSection(goods.imageUrl ?? []),
          Gaps.h8,
          DefaultTextStyle(
            style: context.textTheme.titleLarge!,
            child: Row(
              children: [
                Gaps.w4,
                Text(goods.storeName!),
                Spacer(),
                Text('${goods.discount}%').red(),
                Gaps.w4,
                Text('${goods.salePrice.toPrice()}원'),
                Gaps.w12,
              ],
            ),
          ),
          DefaultTextStyle(
            style: context.textTheme.bodyMedium!,
            child: Row(
              children: [
                Row(
                  children: [
                    Text(
                      "픽업시간 : ${goods.startTime.convertTime() ?? ''} ~ ${goods.endTime.convertTime() ?? ''}",
                    ),
                    Gaps.w12,
                    // NOTE: https://www.figma.com/design/e99TcNm4fvw1N3PiaWxOxD?node-id=3617-2587#1546301351
                    // if (goods.distance != 0)
                    //   Text("거리 : ${goods.distance.toStringAsFixed(2)}km"),
                  ],
                ),
              ],
            ),
          ).margin(left: MgSizes.size4),
          Gaps.h4,
          StoreTags(
            quantity: goods.quantity,
            saleStatus: goods.saleStatus,
          ).margin(left: MgSizes.size4),
        ],
      ),
    );
  }

}
