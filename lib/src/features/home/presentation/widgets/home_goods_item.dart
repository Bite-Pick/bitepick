import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
import 'package:magambell/src/core/extensions/list_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/features/home/domain/entity/goods.dart';
import 'package:magambell/src/widgets/mg_tag.dart';

class HomeGoodsItem extends StatefulWidget {
  const HomeGoodsItem({super.key, required this.goods});

  final Goods goods;

  @override
  State<HomeGoodsItem> createState() => _HomeGoodsItemState();
}

class _HomeGoodsItemState extends State<HomeGoodsItem> {
  @override
  Widget build(BuildContext context) {
    final goods = widget.goods;
    return Column(
      children: [
        _buildImageListView(goods.ImageUrl),
        Gaps.h8,
        DefaultTextStyle(
          style: context.textTheme.titleLarge!,
          child: Row(
            children: [
              Gaps.w4,
              Text(goods.storeName),
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
        Gaps.h4,
        _buildTags(
          goods.quantity,
          goods.saleStatus,
        ).margin(left: MgSizes.size4),
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
          if (image == "") return SizedBox.shrink();
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

  Widget _buildTags(double quantity, String saleStatus) {
    final List<Widget> tags = [];
    // TODO: saleStatus enum으로 변경및 조건문 수정
    if (saleStatus == "ON") tags.add(MgTag(child: Text("픽업가능")));

    tags.add(
      quantity >= 10
          ? MgTag(child: Text('재고있음')).gray()
          : MgTag(child: Text('${quantity.toInt()}개 남음')).danger(),
    );

    if (quantity <= 4) {
      tags.add(
        MgTag(
          prefix: Image.asset(R.ASSETS_ICONS_TIME_PNG),
          child: Text('품절임박'),
        ).danger(light: true),
      );
    }

    return Row(children: tags.joinWithWidget(Gaps.w6));
  }
}
