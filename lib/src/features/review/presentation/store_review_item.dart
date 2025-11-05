import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/review/domain/entities/review.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/mg_tag.dart';

class StoreReviewItem extends ConsumerStatefulWidget {
  const StoreReviewItem(this.review, {super.key});

  final Review review;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StoreReviewItemState();
}

class _StoreReviewItemState extends ConsumerState<StoreReviewItem> {
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
              ClipOval(
                // child: Image.network(""), // TODO: 이미지 확정 필요..
                child: Container(width: 50, height: 50, color: Colors.red),
              ),
              Gaps.w12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Rating label + Satisfaction reasons tags
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: [
                        MgTag(child: Text(widget.review.ratingLabel)),
                        ...widget.review.satisfactionReasons.map((reason) {
                          return MgTag(child: Text(reason.label));
                        }),
                      ],
                    ),
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
              MgButton(
                onPressed: () {
                  // TODO[report]: 신고하기 API
                },
                content: Text("신고하기").sm(),
                padding: Gutter.wsm,
              ),
            ],
          ),
          Gaps.h12,
          Text(widget.review.description).textGray(),
        ],
      ),
    );
  }
}
