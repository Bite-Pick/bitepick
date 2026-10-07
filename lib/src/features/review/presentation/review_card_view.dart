import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/base_network_image.dart';

class ReviewCardView extends StatelessWidget {
  const ReviewCardView({
    super.key,
    required this.nickName,
    required this.createdAt,
    required this.description,
    required this.imageUrls,
    this.trailing,
    this.replyContent,
    this.replyCreatedAt,
  });

  final String nickName;
  final DateTime createdAt;
  final String description;
  final List<String> imageUrls;
  final Widget? trailing;
  final String? replyContent;
  final DateTime? replyCreatedAt;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/review_customer.png',
              width: 34,
              height: 34,
            ),
            Gaps.w8,
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nickName)
                      .semibold()
                      .fontSize(15)
                      .height(1.5)
                      .letterSpacing(-0.375)
                      .textColor(NewColorScheme.gray1),
                  Text(createdAt.format('MM.dd'))
                      .xs()
                      .height(1.5)
                      .letterSpacing(-0.3)
                      .textColor(NewColorScheme.gray7),
                ],
              ),
            ),
            Gaps.w8,
            if (trailing != null) trailing!,
          ],
        ).margin(horizontal: MgSizes.md),
        Gaps.h(MgSizes.size10),
        Text(description)
            .fontSize(15)
            .height(1.5)
            .letterSpacing(-0.375)
            .textColor(NewColorScheme.gray1)
            .margin(horizontal: MgSizes.md),
        if (imageUrls.isNotEmpty) ...[
          Gaps.h(MgSizes.size10),
          SizedBox(
            height: 142,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: MgSizes.md),
              itemCount: imageUrls.length,
              separatorBuilder: (_, __) => const SizedBox(width: MgSizes.size4),
              itemBuilder: (_, index) => ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(MgSizes.size8),
                  bottomLeft: Radius.circular(MgSizes.size8),
                ),
                child: BaseNetworkImage(
                  imageUrl: imageUrls[index],
                  width: 142,
                  height: 142,
                ),
              ),
            ),
          ),
        ],
        Gaps.h(MgSizes.size10),
        _buildRecommendTag(context).margin(horizontal: MgSizes.md),
        if (replyContent != null && replyCreatedAt != null) ...[
          Gaps.h16,
          _buildReplyBlock(context, replyContent!, replyCreatedAt!),
        ],
      ],
    );
  }

  Widget _buildRecommendTag(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: MgSizes.size6,
        vertical: MgSizes.xss,
      ),
      decoration: BoxDecoration(
        color: NewColorScheme.gray14,
        borderRadius: BorderRadius.circular(MgSizes.xss),
        border: Border.all(color: NewColorScheme.gray11, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/menu.png', width: 12, height: 12),
          Gaps.w4,
          Text('추천해요')
              .xs()
              .height(1.5)
              .letterSpacing(-0.3)
              .textColor(NewColorScheme.gray4),
        ],
      ),
    );
  }

  Widget _buildReplyBlock(BuildContext context, String content, DateTime createdAt) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/review_owner.png',
          width: 34,
          height: 34,
        ),
        Expanded(
          child: Stack(
            children: [
              const Positioned(
                left: 0,
                top: 0,
                child: SizedBox(
                  width: 10,
                  height: 9,
                  child: CustomPaint(painter: _BubbleTailPainter()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 9),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: MgSizes.md)
                      .copyWith(
                    top: MgSizes.size16 + MgSizes.size1,
                    bottom: MgSizes.size16 + MgSizes.size1,
                  ),
                  decoration: BoxDecoration(
                    color: NewColorScheme.gray12,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(MgSizes.size12),
                      bottomRight: Radius.circular(MgSizes.size12),
                      bottomLeft: Radius.circular(MgSizes.size12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('사장님')
                          .semibold()
                          .fontSize(15)
                          .height(1.5)
                          .letterSpacing(-0.375)
                          .textColor(NewColorScheme.gray1),
                      Gaps.h12,
                      Text(content)
                          .fontSize(15)
                          .height(1.5)
                          .letterSpacing(-0.375)
                          .textColor(NewColorScheme.gray1),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ).margin(horizontal: MgSizes.md);
  }
}

class _BubbleTailPainter extends CustomPainter {
  const _BubbleTailPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = NewColorScheme.gray12;
    final path = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
