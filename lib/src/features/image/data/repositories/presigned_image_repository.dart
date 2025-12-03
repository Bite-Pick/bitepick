import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/image/domain/entities/image_upload_response.dart';
import 'package:magambell/src/features/image/domain/entities/local_image.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'presigned_image_repository.g.dart';

class PreSignedImageRepository {
  final Ref ref;
  late final Dio _s3dio;

  PreSignedImageRepository(this.ref) {
    _s3dio = Dio(
      BaseOptions(
        // 에러일 때도 본문(XML)을 받자
        receiveDataWhenStatusError: true,
        followRedirects: false,
        validateStatus: (s) => s != null && s < 500,
      ),
    );
  }

  Future<bool> uploadToS3WithPresignedUrl({
    required String presignedUrl,
    required File file,
    void Function(int, int)? onProgress,
  }) async {
    try {
      final fileSize = await file.length();
      final fileName = file.path.split('/').last;

      // presigned URL 정리 (개행/공백 제거)
      final url = presignedUrl.replaceAll(RegExp(r'\s+'), '');

      talker.info('[S3] Uploading $fileName ($fileSize bytes)');
      talker.debug('[S3] URL: ${url.substring(0, 100)}...');

      // ⚠️ IMPORTANT: Presigned URL에는 Authorization 헤더를 보내면 안됨!
      // URL 자체에 이미 인증 정보가 포함되어 있음
      final res = await _s3dio.put(
        url,
        data: file.openRead(),
        options: Options(
          headers: {
            'Content-Type': 'image/jpeg',
            'Content-Length': fileSize,
            // ❌ Authorization 헤더 제거 - Presigned URL은 이미 인증됨
          },
        ),
        onSendProgress: onProgress,
      );

      if (res.statusCode == 200 || res.statusCode == 204) {
        talker.info('[S3] ✅ Upload success: $fileName');
        return true;
      }

      // ❌ 실패: XML에서 Code/Message 추출
      final body = res.data?.toString() ?? '';
      final codeMatch = RegExp(r'<Code>([^<]+)</Code>').firstMatch(body);
      final msgMatch = RegExp(r'<Message>([^<]+)</Message>').firstMatch(body);
      final code = codeMatch?.group(1) ?? 'UNKNOWN';
      final message = msgMatch?.group(1) ?? body;

      talker.error(
        '[S3] ❌ Upload failed: $fileName\n'
        'Status: ${res.statusCode}\n'
        'Code: $code\n'
        'Message: $message',
      );
      return false;
    } catch (e, stackTrace) {
      talker.error('[S3] Exception during upload', e, stackTrace);
      return false;
    }
  }

  Future<void> uploadImagesToS3({
    required List<LocalImage> localImages,
    required List<PresignedUrlImage> presignedUrls,
    void Function(int currentIndex, int total, int sent, int totalBytes)?
    onProgress,
  }) async {
    // 이미 업로드된 이미지(uploadedUrl이 있고 file이 null인 경우)는 제외
    final imagesToUpload = localImages
        .where((img) => img.file != null && img.uploadedUrl == null)
        .toList();

    if (imagesToUpload.isEmpty) {
      talker.info('[S3] No new images to upload');
      return;
    }

    talker.info('[S3] Uploading ${imagesToUpload.length} new images');

    for (var i = 0; i < imagesToUpload.length; i++) {
      final localImage = imagesToUpload[i];
      final presignedUrl = presignedUrls.firstWhere(
        (url) =>
            url.id == localImage.id + 1, // TODO[image]:저장할때부터 0번째 Index로 넣기
        orElse: () =>
            throw Exception('Presigned URL not found for ${localImage.key}'),
      );

      await uploadToS3WithPresignedUrl(
        presignedUrl: presignedUrl.url,
        file: localImage.file!,
        onProgress: onProgress != null
            ? (sent, total) => onProgress(i, imagesToUpload.length, sent, total)
            : null,
      );
    }
  }
}

@riverpod
PreSignedImageRepository presignedImageRepository(Ref ref) {
  return PreSignedImageRepository(ref);
}
