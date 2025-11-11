import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/features/auth/providers/auth_token_manager.dart';
import 'package:magambell/src/features/image/domain/entities/image_upload_response.dart';
import 'package:magambell/src/features/image/domain/entities/local_image.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'presigned_image_repository.g.dart';

class PreSignedImageRepository {
  final Ref ref;
  late final Dio _s3dio;

  PreSignedImageRepository(this.ref) {
    _s3dio = Dio();
  }

  Future<void> uploadToS3WithPresignedUrl({
    required String presignedUrl,
    required File file,
    void Function(int, int)? onProgress,
  }) async {
    try {
      final fileSize = await file.length();
      final token = await ref.read(authTokenManagerProvider.future);

      await _s3dio.put(
        presignedUrl, // pre-signed URL을 전체 경로로 사용
        data: file.openRead(), // 파일을 스트림으로 전송하여 메모리 효율성 확보
        options: Options(
          headers: {
            'Content-Type': 'image/jpeg',
            'Content-Length': fileSize,
            'Authorization': 'Bearer ${token!.accessToken}',
          },
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
