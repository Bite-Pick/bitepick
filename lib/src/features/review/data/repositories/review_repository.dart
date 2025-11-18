import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/features/image/domain/entities/image_upload_response.dart';
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
    final res = await _dio.get(
      '/v1/review',
      queryParameters: {
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

  Future<List<Review>> getMyReviews({int page = 1, int size = 10}) async {
    final res = await _dio.get(
      '/v1/review/me',
      queryParameters: {'page': page, 'size': size},
    );
    final data = res.data['data'] as Map<String, dynamic>?;
    if (res.data['status'] != 'OK' || data == null) return [];
    final list = data['reviewListDTOList'] as List? ?? [];
    return list
        .map((json) => Review.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// 1. 리뷰 삭제
  Future<bool> deleteReview(String reviewId) async {
    final res = await _dio.delete('/v1/review/$reviewId');
    return res.data['status'] == 'OK';
  }

  /// 2. 리뷰 신고
  Future<bool> reportReview(String reviewId) async {
    final res = await _dio.post('/v1/review/report/$reviewId');
    return res.data['status'] == 'OK';
  }

  /// 4. 리뷰 신고 리스트 조회
  /// TODO[ADMIN]: 신고 리스트
  Future<List<Map<String, dynamic>>> getReportedReviews({
    int page = 1,
    int size = 10,
  }) async {
    final res = await _dio.get(
      '/v1/review/report',
      queryParameters: {'page': page, 'size': size},
    );

    final data = res.data['data'] as Map<String, dynamic>?;
    if (data == null) return [];

    return (data['reviewReportList'] as List? ?? [])
        .map((e) => e as Map<String, dynamic>)
        .toList();
  }

  /// 5. 리뷰 등록
  Future<List<PresignedUrlImage>?> createReview({
    required String orderGoodsId,
    required int rating,
    required String description,
    Map<String, dynamic>? reviewImageRegisters,
  }) async {
    final res = await _dio.post(
      '/v1/review',
      data: {
        'goodsId': orderGoodsId,
        'rating': rating,
        'content': description,
        'reviewImageRegisters': reviewImageRegisters,
      },
    );

    if (res.data['status'] != 'OK') return null;

    final presignedImagesData =
        res.data['data']['reviewPreSignedUrlImages'] as List?;
    if ((presignedImagesData ?? []).isEmpty) return [];

    return presignedImagesData!
        .map((json) => PresignedUrlImage.fromJson(json as Map<String, dynamic>))
        .toList();
  }

   // /// 3. 리뷰 평점별 조회
  // Future<Map<String, dynamic>> getRatingStats(String goodsId) async {
  //   final res = await _dio.get(
  //     '/v1/review/rating',
  //     queryParameters: {'goodsId': goodsId},
  //   );
  //   final data = res.data['data'] as Map<String, dynamic>?;
  //   return data ?? {};
  // }
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
  return ref
      .read(reviewRepositoryProvider)
      .getReviews(
        goodsId: goodsId,
        imageCheck: imageCheck,
        page: page,
        size: size,
      );
}

@riverpod
Future<List<Review>> myReviews(Ref ref, {int page = 1, int size = 10}) async {
  return ref
      .read(reviewRepositoryProvider)
      .getMyReviews(page: page, size: size);
}
