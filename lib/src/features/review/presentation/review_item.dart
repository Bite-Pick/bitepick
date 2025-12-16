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
    return Container(
      padding: const EdgeInsets.all(MgSizes.md),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: MgColorScheme.divider, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserProfileItem(size: 40),
              Gaps.w12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MgTag(child: Text(widget.review.ratingLabel)),
                    Gaps.h4,
                    Row(
                      children: [
                        Text(widget.review.nickName),
                        Gaps.w8,
                        Text(widget.review.createdAt.toDate()).textGray(),
                      ],
                    ),
                  ],
                ),
              ),
              _buildActionButton(),
            ],
          ),
          Gaps.h12,
          Text(widget.review.description).textGray(),
          Gaps.h8,
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
        content: Text("신고하기").sm(),
        padding: EdgeInsets.symmetric(horizontal: MgSizes.sm),
      ),
      ReviewItemButtonType.delete => MgButton(
        onPressed: () async => _showDeleteDialog(),
        content: Text("삭제").sm().textGray(),
        padding: EdgeInsets.symmetric(horizontal: MgSizes.sm),
      ),
      ReviewItemButtonType.none => const SizedBox.shrink(),
    };
  }

  // TODO[review]: 테스트 필요
  Future<void> _showReportDialog() async {
    await showDialog(
      context: context,
      builder: (context) => MgAlertDialog(
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
      builder: (context) => MgAlertDialog(
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
