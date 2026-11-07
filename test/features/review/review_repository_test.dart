import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/core/network/api_exception.dart';
import 'package:magambell/src/features/review/data/repositories/review_repository.dart';

class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this.body);

  final Map<String, dynamic> body;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      jsonEncode(body),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

ReviewRepository _repository(Map<String, dynamic> responseBody) {
  final container = ProviderContainer(
    overrides: [
      apiClientProvider.overrideWith(
        (ref) => Dio()..httpClientAdapter = _FakeAdapter(responseBody),
      ),
    ],
  );
  addTearDown(container.dispose);
  return container.read(reviewRepositoryProvider);
}

Map<String, dynamic> _review(int id) => {
  'reviewId': '$id',
  'rating': 3,
  'description': '리뷰 $id',
  'createdAt': '2026-10-01T00:00:00',
  'imageUrls': <String>[],
  'nickName': '닉네임',
  'goodsId': '1',
  'storeId': '1',
  'storeName': '매장',
};

void main() {
  group('getReviews', () {
    test('정상 응답이면 리뷰 목록을 돌려준다', () async {
      final repo = _repository({
        'status': 'OK',
        'data': {
          'reviewListDTOList': [_review(1), _review(2)],
        },
      });

      final reviews = await repo.getReviews(goodsId: '1');

      expect(reviews.length, 2);
    });

    test('정상 응답의 빈 목록은 빈 리스트로 돌려준다', () async {
      final repo = _repository({
        'status': 'OK',
        'data': {'reviewListDTOList': <Map<String, dynamic>>[]},
      });

      expect(await repo.getReviews(goodsId: '1'), isEmpty);
    });

    test('status가 OK가 아니면 빈 목록이 아니라 예외를 던진다', () async {
      final repo = _repository({'status': 'ERROR', 'data': null});

      expect(
        () => repo.getReviews(goodsId: '1'),
        throwsA(isA<ApiResponseException>()),
      );
    });

    test('data가 없으면 예외를 던진다', () async {
      final repo = _repository({'status': 'OK', 'data': null});

      expect(
        () => repo.getReviews(goodsId: '1'),
        throwsA(isA<ApiResponseException>()),
      );
    });
  });

  group('getReviewTotalCount', () {
    test('totalCount를 돌려준다', () async {
      final repo = _repository({
        'status': 'OK',
        'data': {'totalCount': 25},
      });

      expect(await repo.getReviewTotalCount('1'), 25);
    });

    test('명시적인 0은 리뷰 0건으로 처리한다', () async {
      final repo = _repository({
        'status': 'OK',
        'data': {'totalCount': 0},
      });

      expect(await repo.getReviewTotalCount('1'), 0);
    });

    test('status가 OK가 아니면 0이 아니라 예외를 던진다', () async {
      final repo = _repository({'status': 'ERROR', 'data': null});

      expect(
        () => repo.getReviewTotalCount('1'),
        throwsA(isA<ApiResponseException>()),
      );
    });

    test('totalCount가 없으면 0이 아니라 예외를 던진다', () async {
      final repo = _repository({'status': 'OK', 'data': <String, dynamic>{}});

      expect(
        () => repo.getReviewTotalCount('1'),
        throwsA(isA<ApiResponseException>()),
      );
    });
  });
}
