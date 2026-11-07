import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/review/data/repositories/review_repository.dart';
import 'package:magambell/src/features/review/domain/entities/review.dart';
import 'package:magambell/src/features/review/presentation/store_reviews.controller.dart';

Review _review(int id) => Review(
  reviewId: '$id',
  rating: 3,
  description: '리뷰 $id',
  createdAt: DateTime(2026, 1, 1),
  imageUrls: const [],
  nickName: '닉네임',
  goodsId: '1',
  storeId: '1',
  storeName: '매장',
);

class _FakeReviewRepository extends ReviewRepository {
  _FakeReviewRepository(super.ref, {required this.total});

  final int total;
  final requestedPages = <int>[];
  bool failNext = false;

  @override
  Future<List<Review>> getReviews({
    required String goodsId,
    bool imageCheck = true,
    int page = 1,
    int size = 10,
  }) async {
    requestedPages.add(page);
    if (failNext) {
      failNext = false;
      throw DioException(requestOptions: RequestOptions());
    }
    final start = (page - 1) * size;
    if (start >= total) return [];
    final end = (start + size).clamp(0, total);
    return [for (var i = start; i < end; i++) _review(i + 1)];
  }
}

ProviderContainer _container(_FakeReviewRepository Function(Ref) create) {
  final container = ProviderContainer(
    overrides: [
      apiClientProvider.overrideWith((ref) => Dio()),
      reviewRepositoryProvider.overrideWith(create),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(MgTalker.init);

  test('첫 페이지는 10개, 11개 이상이면 더보기가 가능하다', () async {
    final container = _container(
      (ref) => _FakeReviewRepository(ref, total: 25),
    );

    final state = await container.read(storeReviewsProvider('1').future);

    expect(state.reviews.length, 10);
    expect(state.hasMore, isTrue);
  });

  test('더보기를 누를 때마다 10개씩 이어 붙고 마지막 페이지에서 멈춘다', () async {
    final container = _container(
      (ref) => _FakeReviewRepository(ref, total: 25),
    );
    await container.read(storeReviewsProvider('1').future);
    final notifier = container.read(storeReviewsProvider('1').notifier);

    await notifier.loadMore();
    expect(container.read(storeReviewsProvider('1')).value!.reviews.length, 20);
    expect(container.read(storeReviewsProvider('1')).value!.hasMore, isTrue);

    await notifier.loadMore();
    final last = container.read(storeReviewsProvider('1')).value!;
    expect(last.reviews.length, 25);
    expect(last.hasMore, isFalse);

    final repo =
        container.read(reviewRepositoryProvider) as _FakeReviewRepository;
    final before = repo.requestedPages.length;
    await notifier.loadMore();
    expect(repo.requestedPages.length, before);
  });

  test('10개 이하면 더보기가 없다', () async {
    final container = _container((ref) => _FakeReviewRepository(ref, total: 7));

    final state = await container.read(storeReviewsProvider('1').future);

    expect(state.reviews.length, 7);
    expect(state.hasMore, isFalse);
  });

  test('딱 10개면 다음 페이지가 비어 있어도 안전하게 끝난다', () async {
    final container = _container(
      (ref) => _FakeReviewRepository(ref, total: 10),
    );
    await container.read(storeReviewsProvider('1').future);
    final notifier = container.read(storeReviewsProvider('1').notifier);

    await notifier.loadMore();

    final state = container.read(storeReviewsProvider('1')).value!;
    expect(state.reviews.length, 10);
    expect(state.hasMore, isFalse);
  });

  test('더보기가 실패해도 기존 목록은 유지되고 다시 시도할 수 있다', () async {
    final container = _container(
      (ref) => _FakeReviewRepository(ref, total: 25),
    );
    await container.read(storeReviewsProvider('1').future);
    final notifier = container.read(storeReviewsProvider('1').notifier);
    final repo =
        container.read(reviewRepositoryProvider) as _FakeReviewRepository;

    repo.failNext = true;
    await notifier.loadMore();
    final failed = container.read(storeReviewsProvider('1')).value!;
    expect(failed.reviews.length, 10);
    expect(failed.isLoadingMore, isFalse);
    expect(failed.hasMore, isTrue);

    await notifier.loadMore();
    expect(container.read(storeReviewsProvider('1')).value!.reviews.length, 20);
  });
}
