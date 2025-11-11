import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/features/review/domain/entities/review.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'review_repository.g.dart';

class ReviewRepository {
  final Ref ref;
  late final Dio _dio;

  ReviewRepository(this.ref) {
    _dio = ref.read(apiClientProvider);
  }

  Future<List<Review>> getReviews({
    required String goodsId,
    bool imageCheck = true,
    int page = 1,
    int size = 10,
  }) async {
    final res = await _dio.post(
      '/v1/review',
      data: {
        'goodsId': goodsId,
        'imageCheck': imageCheck,
        'page': page,
        'size': size,
      },
    );
    final data = res.data['data'] as Map<String, dynamic>?;
    if (res.data['status'] != 'OK' || data == null) return [];
    final list = data['reviewListDTOList'] as List? ?? [];
    return list
        .map((json) => Review.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

@riverpod
ReviewRepository reviewRepository(Ref ref) {
  return ReviewRepository(ref);
}
@riverpod
Future<List<Review>> reviews(
  Ref ref, {
  required String goodsId,
  bool imageCheck = true,
  int page = 1,
  int size = 10,
}) async {
  return ref.read(reviewRepositoryProvider).getReviews(
        goodsId: goodsId,
        imageCheck: imageCheck,
        page: page,
        size: size,
      );
}
