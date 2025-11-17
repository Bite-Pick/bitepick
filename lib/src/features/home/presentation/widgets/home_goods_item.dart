import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
import 'package:magambell/src/core/extensions/price_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/goods/data/dtos/store_list_response.dart';
import 'package:magambell/src/features/store/presentation/store_screen.dart';
import 'package:magambell/src/features/store/presentation/widget/store_tags.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';

class HomeGoodsItem extends StatefulWidget {
  const HomeGoodsItem({super.key, required this.goods});

  final StoreListResponse goods;

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
          _buildImageListView(goods.imageUrl ?? []),
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
                    Text("거리 : ${goods.distance}"),
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

  Widget _buildImageListView(List<String> images) {
    // TODO[home] : 기기에 따라 크기를 조정해야하는지 검토
    // TODO[home] : 3개 이상 넘어가면 하단에 +n 표시
    final double imagesize = 109.w;
    return SizedBox(
      height: imagesize,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          final image = images[index];
          if (image == "") return SizedBox.shrink();
          return CachedNetworkImage(
            imageUrl: image,
            imageBuilder: (context, imageProvider) => Container(
              height: imagesize,
              width: imagesize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => Container(
              height: imagesize,
              width: imagesize,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ).margin(right: MgSizes.size8.w);
        },
      ),
    );
  }
}
