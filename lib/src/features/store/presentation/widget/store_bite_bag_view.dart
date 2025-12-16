import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/goods/domain/entities/goods.dart';
import 'package:magambell/src/widgets/base_network_image.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_tag.dart';

// NOTE[bitebag]: bitebag == goods 라서 용어 통일필요
class StoreBiteBagView extends StatelessWidget {
  StoreBiteBagView(this.goodsImages, {super.key});
  final List<GoodsImagesList> goodsImages;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildNoticeItem(),
        _buildImages(goodsImages),
        Gaps.h16,
        // _buildTags(["dd", "dd", "dd"]), // NOTE: tag는 런칭이후 개발예정
      ],
    ).margin(horizontal: MgSizes.md);
  }

  Widget _buildNoticeItem() {
    return Row(
          children: [
            BaseSvgIcon.speakerFilled(color: MgColorScheme.alertRed),
            Gaps.w8,
            Text("아래의 상품 중 랜덤으로 구성됩니다!"),
          ],
        )
        .margin(horizontal: MgSizes.md, vertical: MgSizes.md)
        .decorated(
          color: MgColorScheme.gray9,
          borderRadius: BorderRadius.circular(10),
        )
        .margin(vertical: MgSizes.md);
  }

  Widget _buildImages(List<GoodsImagesList> goodsImages) {
    final _goodsImages = goodsImages
        .where((g) => g.id != null && g.goodsName != null && g.imageUrl != null)
        .toList();
    if (_goodsImages.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(R.ASSETS_IMAGES_CHARACTER_1_PNG, width: 160.w),
          Gaps.h12,
          Text("앗! 아직 등록된 메뉴소개가 없어요.").bold(),
        ],
      );
    }
    return Center(
      child: Wrap(
        runSpacing: MgSizes.md,
        spacing: MgSizes.md,
        children: _goodsImages
            .map(
              (goodsImage) => Column(
                children: [
                  BaseNetworkImage(
                    imageUrl: goodsImage.imageUrl!,
                    width: 100.w,
                    height: 100.w,
                  ),
                  Gaps.h4,
                  Text(goodsImage.goodsName!),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  // Widget _buildTags(List<String> tags) {
  //   return Wrap(
  //     spacing: MgSizes.xs,
  //     children: tags
  //         .map((tag) => MgTag(child: Text("#$tag")).gray(light: true))
  //         .toList(),
  //   );
  // }
}
