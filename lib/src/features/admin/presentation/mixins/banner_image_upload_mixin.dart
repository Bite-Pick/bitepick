import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/features/admin/data/repositories/admin_repository.dart';
import 'package:magambell/src/features/image/utils/image_requester.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';

/// 배너 이미지 업로드 공통 로직 Mixin
mixin BannerImageUploadMixin {
  /// 배너 이미지 선택 및 업로드 처리
  ///
  /// [context]: BuildContext
  /// [ref]: WidgetRef
  /// [bannerId]: 배너 ID (새 배너는 0, 수정은 기존 ID)
  /// [onUpload]: 업로드 함수 (Controller의 uploadImage 또는 editBanner)
  Future<void> handleBannerImageUpload(
    BuildContext context,
    WidgetRef ref, {
    required int bannerId,
    required Future<bool> Function(File file, int bannerId) onUpload,
    required String toastMessage,
  }) async {
    // 1. 이미지 선택
    final pickedFile = await ImageRequester().pickFileFromGallery(
      quality: 85,
      maxWidth: 1920,
      maxHeight: 1920,
    );

    if (pickedFile == null) return;

    // 2. 배너 이미지 업로드 (Presigned URL 받아서 S3 업로드)
    final success = await onUpload(pickedFile, bannerId);
    if (!success) {
      ToastPresentor.error(context, "$toastMessage 실패");
      return;
    }

    ToastPresentor.success(context, "$toastMessage 성공");
    ref.invalidate(bannerImagesProvider);
  }
}
