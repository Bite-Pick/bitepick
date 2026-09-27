import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/review/domain/entities/store_review.dart';
import 'package:magambell/src/features/review/presentation/owner_reply_composer.dart';
import 'package:magambell/src/features/review/presentation/review_card_view.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';

class OwnerReviewItem extends ConsumerWidget {
  const OwnerReviewItem(this.review, {super.key});
  final StoreReviewItem review;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ReviewCardView(
      nickName: review.nickName,
      createdAt: review.createdAt,
      description: review.description,
      imageUrls: review.imageUrls,
      replyContent: review.reply?.content,
      replyCreatedAt: review.reply?.createdAt,
      trailing: GestureDetector(
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
    );
  }
}
