import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/review/data/repositories/review_repository.dart';
import 'package:magambell/src/features/review/domain/entities/review.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'store_reviews.controller.g.dart';
part 'store_reviews.controller.freezed.dart';

const _pageSize = 10;

@freezed
class StoreReviewsState with _$StoreReviewsState {
  const factory StoreReviewsState({
    required List<Review> reviews,
    @Default(1) int page,
    @Default(true) bool hasMore,
    @Default(false) bool isLoadingMore,
  }) = _StoreReviewsState;
}

/// 매장 상세 리뷰 목록. 첫 페이지를 불러오고, "더보기"로 다음 페이지를 이어 붙인다.
@riverpod
class StoreReviews extends _$StoreReviews {
  /// 응답 순번. 목록을 새로 만들 때(build) 올려서, 늦게 도착한 이전 요청의
  /// 응답이 새 목록에 이어 붙지 않게 한다.
  int _requestSeq = 0;

  @override
  Future<StoreReviewsState> build(String goodsId) async {
    _requestSeq++;
    final reviews = await _fetch(page: 1);
    return StoreReviewsState(
      reviews: reviews,
      hasMore: reviews.length >= _pageSize,
    );
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || current.isLoadingMore || !current.hasMore) return;

    final seq = _requestSeq;
    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final nextPage = current.page + 1;
      final newItems = await _fetch(page: nextPage);

      final latest = state.value;
      if (seq != _requestSeq || latest == null) return;

      // 페이지 사이에 리뷰가 추가/삭제되면 경계가 밀려 중복될 수 있어 걸러낸다.
      final knownIds = latest.reviews.map((r) => r.reviewId).toSet();
      final added = newItems.where((r) => !knownIds.contains(r.reviewId));

      state = AsyncData(
        latest.copyWith(
          reviews: [...latest.reviews, ...added],
          page: nextPage,
          hasMore: newItems.length >= _pageSize,
          isLoadingMore: false,
        ),
      );
    } catch (e, stack) {
      talker.handle(e, stack, '매장 리뷰 더보기 실패');
      final latest = state.value;
      if (seq != _requestSeq || latest == null) return;
      state = AsyncData(latest.copyWith(isLoadingMore: false));

      final context = GlobalVariable.navigatorKey.currentContext;
      if (context != null && context.mounted) {
        ToastPresentor.error(context, '리뷰를 불러오지 못했어요. 다시 시도해주세요');
      }
    }
  }

  Future<List<Review>> _fetch({required int page}) {
    return ref
        .read(reviewRepositoryProvider)
        .getReviews(
          goodsId: goodsId,
          imageCheck: false,
          page: page,
          size: _pageSize,
        );
  }
}
