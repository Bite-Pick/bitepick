import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/features/image/domain/entities/image_upload_response.dart';
import 'package:magambell/src/features/image/domain/entities/local_image.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'presigned_image_repository.g.dart';

class PreSignedImageRepository {
  final Ref ref;
  late final Dio _dio;

  PreSignedImageRepository(this.ref) {
    _dio = ref.read(apiClientProvider);
  }

  Future<void> uploadToS3WithPresignedUrl({
    required String presignedUrl,
    required File file,
    void Function(int, int)? onProgress,
  }) async {
    try {
      final bytes = await file.readAsBytes();

      await _dio.put(
        presignedUrl,
        data: bytes,
        options: Options(
          headers: {'Content-Type': 'image/jpeg'},
          contentType: 'image/jpeg',
        ),
        onSendProgress: onProgress,
      );
    } catch (e) {
      throw Exception('S3 업로드 실패: $e');
    }
  }

  Future<void> uploadImagesToS3({
    required List<LocalImage> localImages,
    required List<PresignedUrlImage> presignedUrls,
    void Function(int currentIndex, int total, int sent, int totalBytes)?
    onProgress,
  }) async {
    for (var i = 0; i < localImages.length; i++) {
      final localImage = localImages[i];
      final presignedUrl = presignedUrls.firstWhere(
        (url) => url.name == localImage.key,
        orElse: () =>
            throw Exception('Presigned URL not found for ${localImage.key}'),
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
PreSignedImageRepository presignedImageRepository(Ref ref) {
  return PreSignedImageRepository(ref);
}
