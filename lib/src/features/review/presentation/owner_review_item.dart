import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/features/review/domain/entities/store_review.dart';
import 'package:magambell/src/features/review/presentation/owner_reply_composer.dart';
import 'package:magambell/src/widgets/base_network_image.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';

class OwnerReviewItem extends ConsumerWidget {
  const OwnerReviewItem(this.review, {super.key});
  final StoreReviewItem review;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  Text(review.nickName)
                      .semibold()
                      .fontSize(15)
                      .height(1.5)
                      .letterSpacing(-0.375)
                      .textColor(NewColorScheme.gray1),
                  Text(review.createdAt.format('MM.dd'))
                      .xs()
                      .height(1.5)
                      .letterSpacing(-0.3)
                      .textColor(NewColorScheme.gray7),
                ],
              ),
            ),
            Gaps.w8,
            GestureDetector(
              onTap: review.reply == null 
                  ? () {
                      ref.read(activeReplyReviewIdProvider.notifier).state = 
                          review.reviewId;
                      Scrollable.ensureVisible(
                        context,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        alignment: 0,
                      );
                    }
                  : null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BaseSvgIcon.edit(size: MgSizes.xl, color: NewColorScheme.gray5),
                  Gaps.w2,
                  Text(review.reply == null ? '댓글 달기' : '댓글 수정')
                      .semibold()
                      .sm()
                      .height(1.5)
                      .letterSpacing(-0.35)
                      .textColor(NewColorScheme.gray5),
                ],
              ),
            ),
          ],
        ).margin(horizontal: MgSizes.md),
        Gaps.h(MgSizes.size10),
        Text(review.description)
            .fontSize(15)
            .height(1.5)
            .letterSpacing(-0.375)
            .textColor(NewColorScheme.gray1)
            .margin(horizontal: MgSizes.md),
        if (review.imageUrls.isNotEmpty) ...[
          Gaps.h(MgSizes.size10),
          SizedBox(
            height: 142,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: MgSizes.md),
              itemCount: review.imageUrls.length,
              separatorBuilder: (_, __) => const SizedBox(width: MgSizes.size4),
              itemBuilder: (_, index) => ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(MgSizes.size8),
                  bottomLeft: Radius.circular(MgSizes.size8)
                ),
                child: BaseNetworkImage(
                  imageUrl: review.imageUrls[index],
                  width: 142,
                  height: 142,
                ),
              ),
            ),
          ),
        ],
        Gaps.h(MgSizes.size10),
        _buildRecommendTag(context).margin(horizontal: MgSizes.md),
        if (review.reply != null) ...[
          Gaps.h16,
          _buildReplyBlock(context, review.reply!),
        ],
      ],
    );
  }

  Widget _buildRecommendTag(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: MgSizes.size6, vertical: MgSizes.size6),
      decoration: BoxDecoration(
        color: NewColorScheme.gray14,
        borderRadius: BorderRadius.circular(MgSizes.xss),
        border: Border.all(color: NewColorScheme.gray11, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/menu.png', width: MgSizes.sm, height: MgSizes.sm),
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

  Widget _buildReplyBlock(BuildContext context, StoreReviewReply reply) {
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
                  width: MgSizes.size10,
                  height: 9,
                  child: CustomPaint(painter: _BubbleTailPainter()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 9),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: MgSizes.md).copyWith(
                    top: 17,
                    bottom: 17
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
                      Text(reply.content)
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