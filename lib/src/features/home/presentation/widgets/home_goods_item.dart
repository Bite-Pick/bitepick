import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/features/home/domain/entity/goods.dart';

class HomeGoodsItem extends StatefulWidget {
  const HomeGoodsItem({super.key});

  @override
  State<HomeGoodsItem> createState() => _HomeGoodsItemState();
}

class _HomeGoodsItemState extends State<HomeGoodsItem> {
  @override
  Widget build(BuildContext context) {
    final goods = mockData;
    return Column(
      children: [
        _buildImageListView(goods.imageUrl),
        Gaps.h8,
        DefaultTextStyle(
          style: context.textTheme.titleLarge!,
          child: Row(
            children: [
              Gaps.w4,
              Text(goods.goodsName),
              Spacer(),
              Text('${goods.discount}%').red(),
              Gaps.w4,
              Text('${goods.salePrice}원'),
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
        // TODO : 태그 추가
      ],
    );
  }

  Widget _buildImageListView(List<String> images) {
    // TODO[home] : 기기에 따라 크기를 조정해야하는지 검토
    // TODO[home] : 3개 이상 넘어가면 하단에 +n 표시
    const double imageHeight = 109;
    const double imageWidth = 108;
    return SizedBox(
      height: imageHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          final image = images[index];
          return CachedNetworkImage(
            imageUrl: image,
            imageBuilder: (context, imageProvider) => Container(
              height: imageHeight,
              width: imageWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => Container(
              height: imageHeight,
              width: imageWidth,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ).margin(right: MgSizes.size8);
        },
      ),
    );
  }
}
