import 'dart:io';

import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/admin/data/repositories/admin_repository.dart';
import 'package:magambell/src/features/banner/domain/entities/banner_image.dart';
import 'package:magambell/src/features/image/data/repositories/presigned_image_repository.dart';
import 'package:magambell/src/features/image/domain/entities/image_upload_response.dart';
import 'package:magambell/src/features/image/domain/entities/local_image.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'admin_banner_list_screen.controller.freezed.dart';
part 'admin_banner_list_screen.controller.g.dart';

@freezed
class AdminBannerListScreenControllerState
    with _$AdminBannerListScreenControllerState {
  const factory AdminBannerListScreenControllerState({
    required bool isProgress,
    int? uploadingId,
  }) = _AdminBannerListScreenControllerState;
}

@riverpod
class AdminBannerListScreenController extends _$AdminBannerListScreenController {
  @override
  AdminBannerListScreenControllerState build() {
    return const AdminBannerListScreenControllerState(isProgress: false);
  }

  /// 배너 등록 (새로운 배너)
  Future<bool> registerBanner(File file, int id) async {
    return _uploadBanner(
      file: file,
      id: id,
      getPresignedUrl: ref.read(adminRepositoryProvider).registerBanner,
    );
  }

  /// 배너 이미지 수정 (기존 배너)
  Future<bool> editBanner(File file, int bannerId) async {
    return _uploadBanner(
      file: file,
      id: bannerId,
      getPresignedUrl: (id, key) => ref
          .read(adminRepositoryProvider)
          .editBannerImage(bannerId: bannerId, id: id, key: getFileName(file)),
    );
  }

  /// 공통 업로드 로직
  Future<bool> _uploadBanner({
    required File file,
    required int id,
    required Future<BannerImage?> Function(int id, String key) getPresignedUrl,
  }) async {
    state = state.copyWith(isProgress: true, uploadingId: id);

    try {
      talker.debug('[Banner] Starting upload for ID: $id');

      // 1. Presigned URL 요청
      final bannerImage = await getPresignedUrl(id, _getFileName(file));
      if (bannerImage == null) {
        talker.error('[Banner] Failed to get presigned URL for ID: $id');
        state = state.copyWith(isProgress: false, uploadingId: null);
        return false;
      }

      final presignedImage = PresignedUrlImage(
        id: bannerImage.id,
        url: bannerImage.url,
      );

      talker.debug('[Banner] Got presigned URL for ID: $id');

      // 2. S3에 업로드
      final success = await ref
          .read(presignedImageRepositoryProvider)
          .uploadToS3WithPresignedUrl(
            file: file,
            presignedUrl: presignedImage.url,
            onProgress: (sent, totalBytes) {
              final progress = (sent / totalBytes * 100).toStringAsFixed(1);
              talker.debug(
                '[Banner] Upload progress: $progress% ($sent/$totalBytes)',
              );
            },
          );

      state = state.copyWith(isProgress: false, uploadingId: null);

      success
          ? talker.info('[Banner] ✅ Upload success for ID: $id')
          : talker.error('[Banner] ❌ Upload failed for ID: $id');

      return success;
    } catch (e, stack) {
      talker.error('[Banner] Upload exception for ID: $id', e, stack);
      state = state.copyWith(isProgress: false, uploadingId: null);
      return false;
    }
  }

  /// 파일명 추출
  String _getFileName(File file) => file.path.split('/').last;
}
