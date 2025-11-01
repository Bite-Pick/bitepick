import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/features/review/data/repositories/review_repository.dart';
import 'package:magambell/src/features/review/presentation/store_review_item.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';

class StoreReviewListView extends ConsumerStatefulWidget {
  const StoreReviewListView(this.storeId, {super.key});
  final String storeId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StoreReviewListViewState();
}

class _StoreReviewListViewState extends ConsumerState<StoreReviewListView> {
  @override
  Widget build(BuildContext context) {
    final reviewsAsync = ref.watch(reviewsProvider(goodsId: widget.storeId));
    return MgAsyncAnimatedSwitcher(
      asyncValue: reviewsAsync,
      builder: (reviews) {
        if (reviews.isEmpty) return Text("리뷰가 없어요");
        return ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final reivew = reviews[index];
            return StoreReviewItem(reivew);
          },
        );
      },
    );
  }
}
