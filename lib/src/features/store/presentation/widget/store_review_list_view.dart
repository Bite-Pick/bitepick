import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/review/data/repositories/review_repository.dart';
import 'package:magambell/src/features/review/presentation/review_item.dart';
import 'package:magambell/src/features/user/providers/user.provider.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';
import 'package:magambell/src/widgets/mg_checkbox.dart';

class StoreReviewListView extends ConsumerStatefulWidget {
  const StoreReviewListView(this.goodsId, {super.key});
  final String goodsId;

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
      reviewsProvider(goodsId: widget.goodsId, imageCheck: _imageCheckOnly),
    );
    return MgAsyncAnimatedSwitcher(
      asyncValue: reviewsAsync,
      emptyBuilder: () => Center(child: Text("리뷰가 없습니다")),
      builder: (reviews) {
        return SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Row(
                children: [
                  MgCheckbox(
                    initialValue: _imageCheckOnly,
                    onChanged: (value) => _toggleImageCheck(),
                  ),
                  Gaps.w8,
                  Text("포토리뷰").sm(),
                ],
              ).margin(horizontal: MgSizes.md, top: MgSizes.xxl),
              ...reviews.map((review) {
                // TODO: review에 userId가 내려오거나, 본인 리뷰 여부를 판별할 수 있는 flag가 추가되어야함
                return review.nickName ==
                        ref.read(userStateProvider).asData!.value?.nickName
                    ? ReviewItem.myReview(review)
                    : ReviewItem.userReview(review);
              }),
            ],
          ),
        );
      },
    );
  }
}
