import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/features/review/data/repositories/review_repository.dart';
import 'package:magambell/src/features/review/presentation/review_item.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';

class MyReviewListRoute extends GoRouteData {
  const MyReviewListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MyReviewListScreen();
  }
}

class MyReviewListScreen extends ConsumerWidget {
  const MyReviewListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(myReviewsProvider());
    return BaseScaffold(
      appBar: BaseAppBar(title: const Text('리뷰 관리')),
      body: MgAsyncAnimatedSwitcher(
        emptyBuilder: () => Center(child: Text("작성한 리뷰가 없습니다")),
        asyncValue: reviewsAsync,
        onRetry: () => ref.invalidate(myReviewsProvider()),
        builder: (reviews) {
          return ListView.separated(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return ReviewItem.myReview(review);
            },
            separatorBuilder: (context, index) => Gaps.h16,
          ).margin(top: MgSizes.md);
        },
      ),
    );
  }
}
