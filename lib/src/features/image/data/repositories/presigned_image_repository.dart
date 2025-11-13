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
    final fileSize = await file.length();
    final bytes = await file.readAsBytes();

    final token = await ref.read(authTokenManagerProvider.future);
    // presigned URL이 로그 복붙으로 개행/공백이 섞였을 수 있어 한 줄로 정리
    final url = presignedUrl.replaceAll(RegExp(r'\s+'), '');
    // +    // 서버가 presign 생성 시 Content-Type을 고정했다면 동일하게 맞춰야 함
    // +    // 필요 시 mime 패키지 사용 가능: lookupMimeType(file.path) ?? 'application/octet-stream'
    const contentType = 'image/jpeg';
    // 바이트 로드

    // Content-Type 결정: 서버가 ‘이 타입’으로 서명했으면 반드시 동일하게 넣어야 함.
    // final contentType = lookupMimeType(file.path) ?? 'application/octet-stream';
    final res = await _s3dio.put(
      url, // pre-signed URL을 전체 경로로 사용
      data: file.openRead(), // 파일을 스트림으로 전송하여 메모리 효율성 확보
      options: Options(
        headers: {
          'Content-Type': contentType,
          // 'Content-Length': fileSize,
          'Authorization': 'Bearer ${token!.accessToken}',
        },
      ),
      onSendProgress: onProgress,
    );
    if (res.statusCode == 200 || res.statusCode == 204) {
      return true;
    }

    // ❌ 실패: XML에서 Code/Message 추출해서 로깅/처리
    final body = res.data?.toString() ?? '';
    final codeMatch = RegExp(r'<Code>([^<]+)</Code>').firstMatch(body);
    final msgMatch = RegExp(r'<Message>([^<]+)</Message>').firstMatch(body);
    final code = codeMatch?.group(1) ?? 'UNKNOWN';
    final message = msgMatch?.group(1) ?? body;

    print(
      'S3 upload failed: status=${res.statusCode}, code=$code, msg=$message',
    );
    return false;
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
