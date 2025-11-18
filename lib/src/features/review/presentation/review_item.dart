import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/review/domain/entities/review.dart';
import 'package:magambell/src/features/user/presentation/user_profile_item.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/mg_tag.dart';

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
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return switch (widget.buttonType) {
      ReviewItemButtonType.report => MgButton(
        onPressed: () {
          // TODO[report]: 신고하기 API
        },
        content: Text("신고하기").sm(),
        padding: EdgeInsets.symmetric(horizontal: MgSizes.sm),
      ),
      ReviewItemButtonType.delete => MgButton(
        onPressed: () {
          // TODO[delete]: 삭제하기 API
        },
        content: Text("삭제").sm().textGray(),
        padding: EdgeInsets.symmetric(horizontal: MgSizes.sm),
      ),
      ReviewItemButtonType.none => const SizedBox.shrink(),
    };
  }
}
