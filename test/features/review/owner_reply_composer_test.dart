import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/features/review/data/repositories/review_repository.dart';
import 'package:magambell/src/features/review/domain/entities/store_review.dart';
import 'package:magambell/src/features/review/presentation/owner_reply_composer.dart';

class _FakeRepo extends ReviewRepository {
  _FakeRepo(super.ref);

  static int listLoads = 0;
  static final saveCompleter = Completer<bool>();

  @override
  Future<StoreReviewListResponse?> getStoreReviews({
    String filter = 'ALL',
    int? cursor,
    int size = 100,
  }) async {
    listLoads++;
    return null;
  }

  @override
  Future<bool> addReply(String reviewId, String content) =>
      saveCompleter.future;
}

void main() {
  testWidgets('저장 중에 다른 리뷰로 컴포저가 교체돼도 목록은 다시 불러온다', (tester) async {
    _FakeRepo.listLoads = 0;
    final container = ProviderContainer(
      overrides: [
        apiClientProvider.overrideWith((ref) => Dio()),
        reviewRepositoryProvider.overrideWith(_FakeRepo.new),
      ],
    );
    addTearDown(container.dispose);
    // 목록 provider를 살려 두고 첫 로딩을 끝낸다.
    container.listen(ownerStoreReviewsProvider(), (_, __) {});
    await container.read(ownerStoreReviewsProvider().future);
    final loadsBefore = _FakeRepo.listLoads;

    container.read(activeReplyReviewIdProvider.notifier).state = 'A';
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (_, __) => MaterialApp(
            home: Scaffold(
              body: Consumer(
                builder: (context, ref, _) {
                  final id = ref.watch(activeReplyReviewIdProvider);
                  return id == null
                      ? const SizedBox()
                      : OwnerReplyComposer(key: ValueKey(id));
                },
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump(Duration.zero);

    await tester.enterText(find.byType(TextField), '감사합니다');
    final sendButton = find.descendant(
      of: find.byType(OwnerReplyComposer),
      matching: find.byType(GestureDetector),
    );
    await tester.tap(sendButton.first);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // 요청이 끝나기 전에 다른 리뷰를 선택해 컴포저(A)를 폐기시킨다.
    container.read(activeReplyReviewIdProvider.notifier).state = 'B';
    await tester.pump();

    _FakeRepo.saveCompleter.complete(true);
    await tester.pumpAndSettle();

    expect(
      _FakeRepo.listLoads,
      greaterThan(loadsBefore),
      reason: '저장이 성공했으므로 컴포저가 폐기돼도 목록을 다시 불러와야 한다',
    );
  });
}
