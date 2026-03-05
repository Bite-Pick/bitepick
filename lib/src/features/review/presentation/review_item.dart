import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/review/data/repositories/review_repository.dart';
import 'package:magambell/src/features/review/domain/entities/review.dart';
import 'package:magambell/src/features/user/presentation/user_profile_item.dart';
import 'package:magambell/src/features/user/providers/user.provider.dart';
import 'package:magambell/src/widgets/base_network_image.dart';
import 'package:magambell/src/widgets/mg_alert_dialog.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/mg_tag.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';

enum ReviewItemButtonType { report, delete, none }

class ReviewItem extends ConsumerStatefulWidget {
  const ReviewItem(
    this.review, {
    this.buttonType = ReviewItemButtonType.none,
    super.key,
  });

  final Review review;
  final ReviewItemButtonType buttonType;

  factory ReviewItem.userReview(Review review) {
    return ReviewItem(review, buttonType: ReviewItemButtonType.report);
  }

  factory ReviewItem.myReview(Review review) {
    return ReviewItem(review, buttonType: ReviewItemButtonType.delete);
  }

  @override
  ConsumerState<ReviewItem> createState() => _ReviewItemState();
}

class _ReviewItemState extends ConsumerState<ReviewItem> {
  @override
  Widget build(BuildContext context) {
    final user = ref.read(userStateProvider).asData!.value;
    final isLogin = user != null;
    return Container(
      padding: const EdgeInsets.all(MgSizes.md),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: MgColorScheme.gray8, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.review.nickName).sm(),
          Gaps.h(6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MgTag(child: Text(widget.review.ratingLabel)),
              Gaps.w8,
              Text(widget.review.createdAt.toDate()).textGray().xs(),
              if (isLogin) ...[Spacer(), _buildActionButton()],
            ],
          ),
          Text(widget.review.description).sm().margin(vertical: MgSizes.sm),
          if (widget.review.imageUrls.isNotEmpty)
            Row(
              children: widget.review.imageUrls
                  .map(
                    (imageUrl) => BaseNetworkImage(
                      imageUrl: imageUrl,
                      height: 120.w,
                      width: 120.w,
                    ),
                  )
                  .toList(),
            ).constrained(height: 120),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return switch (widget.buttonType) {
      ReviewItemButtonType.report => MgButton(
        onPressed: () async => _showReportDialog(),
        content: Text("신고하기").xs(),
        padding: EdgeInsets.symmetric(horizontal: MgSizes.sm),
      ),
      ReviewItemButtonType.delete => MgButton(
        onPressed: () async => _showDeleteDialog(),
        content: Text("삭제").xs().textGray(),
        padding: EdgeInsets.symmetric(horizontal: MgSizes.sm),
      ),
      ReviewItemButtonType.none => const SizedBox.shrink(),
    };
  }

  // TODO[review]: 테스트 필요
  Future<void> _showReportDialog() async {
    await showDialog(
      context: context,
      builder: (context) => MgAlertDialog.basic(
        title: '이 리뷰를 신고할까요?',
        content: Text('신고하면 리뷰가 보이지 않아요.'),
        onConfirm: () async => ref
            .read(reviewRepositoryProvider)
            .reportReview(widget.review.reviewId),
      ),
    );
  }

  Future<void> _showDeleteDialog() async {
    await showDialog(
      context: context,
      builder: (context) => MgAlertDialog.basic(
        title: '리뷰 삭제',
        content: Text('리뷰를 삭제하시겠습니까?'),
        onConfirm: () async {
          final res = await ref
              .read(reviewRepositoryProvider)
              .deleteReview(widget.review.reviewId);
          if (res) {
            ToastPresentor.success(context, "리뷰가 삭제되었습니다.");
            // TODO: refactor 각 화면에서 사용하는 provider만 invalidate하도록
            ref.invalidate(reviewsProvider(goodsId: widget.review.goodsId));
            ref.invalidate(myReviewsProvider);
          } else {
            ToastPresentor.error(context, "리뷰 삭제에 실패했습니다. 문의해주세요");
          }
        },
      ),
    );
  }
}
