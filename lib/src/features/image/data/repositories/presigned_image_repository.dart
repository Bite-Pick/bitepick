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

  /// 로컬 이미지와 presigned URL을 배열 순서로 매칭해 S3에 업로드
  /// (id 매칭 없이 순서만 보장되면 되는 단순 목록에 사용)
  Future<void> uploadLocalImagesInOrder({
    required List<LocalImage> localImages,
    required List<PresignedUrlImage> presignedUrls,
  }) async {
    final filesToUpload = localImages.where((img) => img.file != null).toList();
    final urlsToUpload = presignedUrls.where((u) => u.url != null).toList();
    for (var i = 0; i < filesToUpload.length && i < urlsToUpload.length; i++) {
      await uploadToS3WithPresignedUrl(
        presignedUrl: urlsToUpload[i].url!,
        file: filesToUpload[i].file!,
      );
    }
  }

  Future<void> uploadImagesToS3({
    required List<LocalImage> localImages,
    required List<PresignedUrlImage> presignedUrls,
    void Function(int currentIndex, int total, int sent, int totalBytes)?
    onProgress,
  }) async {
    talker.debug('[S3] ========== uploadImagesToS3 시작 ==========');
    talker.debug('[S3] localImages 개수: ${localImages.length}');
    talker.debug('[S3] presignedUrls 개수: ${presignedUrls.length}');

    // localImages의 id 출력
    for (var i = 0; i < localImages.length; i++) {
      talker.debug('[S3] localImage[$i] - id: ${localImages[i].id}, key: ${localImages[i].key}, file: ${localImages[i].file != null ? "exists" : "null"}');
    }

    // presignedUrls의 id 출력
    for (var i = 0; i < presignedUrls.length; i++) {
      talker.debug('[S3] presignedUrl[$i] - id: ${presignedUrls[i].id}, url: ${presignedUrls[i].url != null ? "exists" : "null"}');
    }

    final imagesToUpload = localImages
        .whereType<LocalImage>()
        .where((img) => img.file != null)
        .toList();

    talker.debug('[S3] 필터링 후 업로드할 이미지: ${imagesToUpload.length}개');

    if (imagesToUpload.isEmpty) {
      talker.info('[S3] No new images to upload');
      return;
    }

    talker.info('[S3] Uploading ${imagesToUpload.length} new images');

    for (var i = 0; i < imagesToUpload.length; i++) {
      final localImage = imagesToUpload[i];
      talker.debug('[S3] [$i] localImage.id로 presignedUrl 찾는 중: ${localImage.id}');

      try {
        final presignedUrl = presignedUrls.firstWhere(
          (url) => url.id == localImage.id,
          orElse: () {
            talker.error('[S3] ❌ Presigned URL not found for image id: ${localImage.id}, key: ${localImage.key}');
            talker.error('[S3] 사용 가능한 presignedUrl ids: ${presignedUrls.map((u) => u.id).toList()}');
            throw Exception('Presigned URL not found for ${localImage.key}');
          },
        );

        if (presignedUrl.url == null) {
          talker.error(
            '[S3] Presigned URL is null for image id: ${presignedUrl.id}',
          );
          return;
        }

        talker.debug('[S3] ✅ [$i] 매칭 성공 - localImage.id: ${localImage.id}, presignedUrl.id: ${presignedUrl.id}');

        await uploadToS3WithPresignedUrl(
          presignedUrl: presignedUrl.url!,
          file: localImage.file!,
          onProgress: onProgress != null
              ? (sent, total) => onProgress(i, imagesToUpload.length, sent, total)
              : null,
        );
      } catch (e, stackTrace) {
        talker.error('[S3] ❌ 이미지 업로드 중 오류', e, stackTrace);
        rethrow;
      }
    }

    talker.debug('[S3] ========== uploadImagesToS3 종료 ==========');
  }
}

@riverpod
PreSignedImageRepository presignedImageRepository(Ref ref) {
  return PreSignedImageRepository(ref);
}
