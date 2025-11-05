import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/utils/debug_text.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_tag.dart';

// TODO[bitebag]: 백엔드 개발 이후 개발예정
// 바이트백(가제) 구성
class StoreInfoView extends StatelessWidget {
  StoreInfoView({super.key});
  final images = [
    BiteBag(
      "https://d1xe26zpyg8fzv.cloudfront.net/STORE/OWNER/758244341543821802/1_b02.jpg",
      "마늘육쪽빵",
    ),
    BiteBag(
      "https://d1xe26zpyg8fzv.cloudfront.net/STORE/OWNER/758244341543821802/2_b03.jpg",
      "도넛",
    ),
    BiteBag(
      "https://d1xe26zpyg8fzv.cloudfront.net/STORE/OWNER/758244341543821802/3_bakery01.jpeg",
      "몽블랑",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: DebugText("백엔드 개발필요")), // TODO[bitebag]: 삭제
        _buildNoticeItem(),
        _buildImages(images),
        Gaps.h16,
        _buildTags(["갓성비", "당일생산 당일판매"]).margin(left: MgSizes.sm),
      ],
    ).margin(horizontal: MgSizes.md);
  }

  Widget _buildNoticeItem() {
    return Row(
          children: [
            BaseSvgIcon.speakerFilled(color: MgColorScheme.alertRed),
            Gaps.w8,
            Text("아래의 상품 중 랜덤으로 구성됩니다!"), // TODO[bitebag]: mock data
          ],
        )
        .margin(horizontal: MgSizes.md, vertical: MgSizes.md)
        .decorated(
          color: MgColorScheme.gray9,
          borderRadius: BorderRadius.circular(10),
        )
        .margin(vertical: MgSizes.md);
  }

  Widget _buildImages(List<BiteBag> bitebags) {
    return Center(
      child: Wrap(
        runSpacing: MgSizes.md,
        spacing: MgSizes.md,
        children: bitebags
            .map(
              (bitebag) => Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: bitebag.imageUrl,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 100.w,
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                  Gaps.h4,
                  Text(bitebag.name),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildTags(List<String> tags) {
    return Wrap(
      spacing: MgSizes.xs,
      children: tags
          .map((tag) => MgTag(child: Text("#$tag")).gray(light: true))
          .toList(),
    );
  }
}

class BiteBag {
  final String imageUrl;
  final String name;
  const BiteBag(this.imageUrl, this.name);
}
