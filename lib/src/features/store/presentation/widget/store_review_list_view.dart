import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/review/presentation/store_reviews.controller.dart';
import 'package:magambell/src/features/review/presentation/review_item.dart';
import 'package:magambell/src/features/user/providers/user.provider.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/mg_checkbox.dart';

class StoreReviewListView extends ConsumerStatefulWidget {
  const StoreReviewListView(this.goodsId, {super.key});
  final String goodsId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StoreReviewListViewState();
}

class _StoreReviewListViewState extends ConsumerState<StoreReviewListView> {
  @override
  Widget build(BuildContext context) {
    final reviewsState = ref.watch(storeReviewsProvider(widget.goodsId));
    final reviewsAsync = reviewsState.whenData((state) => state.reviews);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
       // Row(
       //   children: [
       //     MgCheckbox(
       //       initialValue: _imageCheckOnly,
       //       onChanged: (value) => _toggleImageCheck(),
       //    ),
       //     Gaps.w8,
       //     Text("포토리뷰").sm(),
       //   ],
       // ).margin(horizontal: MgSizes.md, top: MgSizes.xxl),
        MgAsyncAnimatedSwitcher(
          asyncValue: reviewsAsync,
          onRetry: () => ref.invalidate(storeReviewsProvider(widget.goodsId)),
          emptyBuilder: () => Center(
            child: Column(
              children: [
                Gaps.h(24.h),
                Image.asset(R.ASSETS_IMAGES_CHARACTER_EMPTY_PNG, width: 160.w),
                Gaps.h12,
                Text("아직 등록된 리뷰가 없어요").bold(),
              ],
            ),
          ),
          builder: (reviews) => Column(
            children: [
              for (int i = 0; i < reviews.length; i++) ...[
                if (i != 0) Gaps.h16,
              // TODO: review에 userId가 내려오거나, 본인 리뷰 여부를 판별할 수 있는 flag가 추가되어야함
                reviews[i].nickName ==
                        ref.read(userStateProvider).asData!.value?.nickName
                    ? ReviewItem.myReview(
                        reviews[i],
                        showDivider: i != reviews.length - 1,
                      )
                    : ReviewItem.userReview(
                      reviews[i],
                      showDivider: i != reviews.length - 1,
                      )
              ],
            ],
          ),
        ),
        if (reviewsState.value?.hasMore ?? false)
          _buildLoadMoreButton(reviewsState.value!.isLoadingMore),
      ],
    );
  }

  Widget _buildLoadMoreButton(bool isLoading) {
    return MgButton(
      onPressed: isLoading
          ? null
          : () => ref
                .read(storeReviewsProvider(widget.goodsId).notifier)
                .loadMore(),
      content: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Text('리뷰 더보기'),
    ).gray().margin(
      horizontal: MgSizes.md, 
      top: MgSizes.md,
      bottom: MgSizes.xxl,
    );
  }
}
