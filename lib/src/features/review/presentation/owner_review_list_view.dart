import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/features/review/data/repositories/review_repository.dart';
import 'package:magambell/src/features/review/presentation/owner_review_item.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';

class OwnerReviewListView extends ConsumerWidget {
  const OwnerReviewListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(ownerStoreReviewsProvider());
    return MgAsyncAnimatedSwitcher(
      asyncValue: reviewsAsync, 
      onRetry: () => ref.invalidate(ownerStoreReviewsProvider),
      builder: (response) {
        final items = response?.items ?? [];
        if (items.isEmpty) {
          return Center(
            child: Column(
              children: [
                Gaps.h(24.h),
                Image.asset(R.ASSETS_IMAGES_CHARACTER_EMPTY_PNG, width: 160.w),
                Gaps.h12,
                Text('아직 등록된 리뷰가 없어요').bold(),
              ],
            ),
          );
        }
        return Column(
          children: [
            for (int i = 0; i < items.length; i++) ...[
              OwnerReviewItem(items[i]),
              if (i != items.length - 1) ...[
                Gaps.h20,
                Container(
                  height: 1,
                  color: NewColorScheme.gray12,
                  margin: const EdgeInsets.symmetric(horizontal: MgSizes.md),
                ),
                Gaps.h20,
              ],
            ],
          ],
        );
      },
    );
  }
}