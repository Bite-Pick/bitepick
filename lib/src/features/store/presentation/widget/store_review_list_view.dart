import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/review/data/repositories/review_repository.dart';
import 'package:magambell/src/features/review/domain/entities/review.dart';
import 'package:magambell/src/features/review/presentation/store_review_item.dart';

class StoreReviewListView extends ConsumerStatefulWidget {
  const StoreReviewListView(this.storeId, {super.key});
  final String storeId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StoreReviewListViewState();
}

class _StoreReviewListViewState extends ConsumerState<StoreReviewListView> {
  bool _imageCheckOnly = true;

  void _toggleImageCheck() =>
      setState(() => _imageCheckOnly = !_imageCheckOnly);

  @override
  Widget build(BuildContext context) {
    final reviewsAsync = ref.watch(
      reviewsProvider(goodsId: widget.storeId, imageCheck: _imageCheckOnly),
    );
    // return MgAsyncAnimatedSwitcher(
    //   asyncValue: reviewsAsync,
    //   builder: (reviews) {
    //     return SingleChildScrollView(
    //       padding: EdgeInsets.zero,
    //       child: Column(
    //         children: [
    //           Align(
    //             alignment: Alignment.centerLeft,
    //             child: Text(
    //               "이 상품의 모든 리뷰(${reviews.length}개)",
    //             ).textGray().md().margin(top: MgSizes.md),
    //           ),
    //           Row(
    //             children: [
    //               Checkbox(
    //                 value: _imageCheckOnly,
    //                 onChanged: (value) => _toggleImageCheck(),
    //               ),
    //               Text("포토리뷰만 보기").sm(),
    //             ],
    //           ),
    //           ...reviews.map((review) {
    //             return StoreReviewItem(review);
    //           }),
    //         ],
    //       ),
    //     );
    //   },
    // );

    // Mock data 사용
    final reviews = mockReviews;
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "이 상품의 모든 리뷰(${reviews.length}개)",
            ).textGray().md().margin(top: MgSizes.md, left: MgSizes.md),
          ),
          Row(
            children: [
              Checkbox(
                value: _imageCheckOnly,
                onChanged: (value) => _toggleImageCheck(),
              ),
              Text("포토리뷰만 보기").sm(),
            ],
          ),
          ...reviews.map((review) {
            return StoreReviewItem(review);
          }),
        ],
      ),
    );
  }
}
