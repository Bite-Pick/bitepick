import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/features/goods/domain/entities/image_upload_request.dart';
import 'package:magambell/src/features/goods/domain/entities/local_image.dart';
import 'package:magambell/src/features/image/domain/entities/image_upload_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'goods_repository.g.dart';

class GoodsRepository {
  final Ref ref;
  late final Dio _dio;

  GoodsRepository(this.ref) {
    _dio = ref.read(apiClientProvider);
  }

  /// Goods 등록 API 호출 (이미지 메타데이터 포함)
  /// 응답에서 goodsPreSignedImages만 파싱하여 반환
  Future<List<PresignedUrlImage>> createGoods({
    required String description,
    required int originalPrice,
    required int discount,
    required int salePrice,
    required int quantity,
    required DateTime startTime,
    required DateTime endTime,
    required List<ImageMetadata> goodsImagesRegisters,
  }) async {
    final response = await _dio.post(
      '/v1/goods',
      data: {
        'description': description,
        'originalPrice': originalPrice,
        'discount': discount,
        'salePrice': salePrice,
        'quantity': quantity,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
        'goodsImagesRegisters': goodsImagesRegisters
            .map((e) => e.toJson())
            .toList(),
      },
    );

    // data['goodsPreSignedImages']에서 presigned URL 배열만 추출
    final presignedImagesData = response.data['data']['goodsPreSignedImages'] as List;
    return presignedImagesData
        .map((json) => PresignedUrlImage.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Presigned URL로 S3에 직접 업로드 (PUT 요청)
  Future<void> uploadToS3WithPresignedUrl({
    required String presignedUrl,
    required File file,
    void Function(int, int)? onProgress,
  }) async {
    try {
      final bytes = await file.readAsBytes();
      final dio = Dio();

      await dio.put(
        presignedUrl,
        data: bytes,
        options: Options(
          headers: {
            'Content-Type': 'image/jpeg',
          },
          contentType: 'image/jpeg',
        ),
        onSendProgress: onProgress,
      );
    } catch (e) {
      throw Exception('S3 업로드 실패: $e');
    }
  }

  /// 여러 이미지를 presigned URL로 업로드
  Future<void> uploadImagesToS3({
    required List<LocalImage> localImages,
    required List<PresignedUrlImage> presignedUrls,
    void Function(int currentIndex, int total, int sent, int totalBytes)? onProgress,
  }) async {
    for (var i = 0; i < localImages.length; i++) {
      final localImage = localImages[i];
      final presignedUrl = presignedUrls.firstWhere(
        (url) => url.name == localImage.key,
        orElse: () => throw Exception('Presigned URL not found for ${localImage.key}'),
      );

      await uploadToS3WithPresignedUrl(
        presignedUrl: presignedUrl.url,
        file: localImage.file,
        onProgress: onProgress != null
            ? (sent, total) => onProgress(i, localImages.length, sent, total)
            : null,
      );
    }
  }
}

@riverpod
GoodsRepository goodsRepository(Ref ref) {
  return GoodsRepository(ref);
}
