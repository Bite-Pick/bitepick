import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/image/data/repositories/presigned_image_repository.dart';
import 'package:magambell/src/features/image/domain/entities/local_image.dart';
import 'package:magambell/src/features/review/data/repositories/review_repository.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'review_register_screen.controller.freezed.dart';
part 'review_register_screen.controller.g.dart';

@freezed
class ReviewRegisterState with _$ReviewRegisterState {
  const factory ReviewRegisterState({
    @Default(0) int rating,
    @Default('') String description,
    @Default([]) List<LocalImage> images,
    @Default(false) bool isSubmitting,
    @Default(0.0) double uploadProgress,
    String? error,
  }) = _ReviewRegisterState;
}

@riverpod
class ReviewRegisterScreenController extends _$ReviewRegisterScreenController {
  @override
  ReviewRegisterState build(String orderGoodsId) {
    return const ReviewRegisterState();
  }

  void setRating(int rating) {
    state = state.copyWith(rating: rating);
  }

  void setDescription(String description) {
    state = state.copyWith(description: description);
  }

  void addImages(List<File> files) {
    final newImages = files.mapIndexed((index, file) {
      final currentLength = state.images.length;
      return LocalImage(
        id: currentLength + index,
        key: file.path.split('/').last,
        file: file,
      );
    }).toList();

    state = state.copyWith(images: [...state.images, ...newImages]);
  }

  void removeImage(int index) {
    if (index >= 0 && index < state.images.length) {
      final updatedImages = List<LocalImage>.from(state.images)..removeAt(index);
      state = state.copyWith(images: updatedImages);
    }
  }

  Future<bool> submit() async {
    // Validation
    if (state.rating == 0) {
      final context = GlobalVariable.navigatorKey.currentContext;
      if (context != null) {
        ToastPresentor.error(context, '별점을 선택해주세요');
      }
      return false;
    }

    if (state.description.trim().isEmpty) {
      final context = GlobalVariable.navigatorKey.currentContext;
      if (context != null) {
        ToastPresentor.error(context, '리뷰 내용을 작성해주세요');
      }
      return false;
    }

    try {
      state = state.copyWith(
        isSubmitting: true,
        uploadProgress: 0.0,
        error: null,
      );

      // 이미지 메타데이터 생성
      final imageRegisters = state.images.isNotEmpty
          ? state.images.mapIndexed((index, image) {
              return {
                'key': image.key,
                'id': index + 1,
              };
            }).toList()
          : null;

      // 리뷰 등록 API 호출
      final presignedUrls = await ref
          .read(reviewRepositoryProvider)
          .createReview(
            orderGoodsId: orderGoodsId,
            rating: state.rating,
            description: state.description.trim(),
            reviewImageRegisters: imageRegisters != null
                ? {'reviewImageRegisters': imageRegisters}
                : null,
          );

      if (presignedUrls == null) {
        talker.error('리뷰 등록 실패');
        state = state.copyWith(isSubmitting: false);
        return false;
      }

      talker.info('리뷰 등록 성공');

      // 이미지가 있으면 S3 업로드
      if (presignedUrls.isNotEmpty && state.images.isNotEmpty) {
        await ref.read(presignedImageRepositoryProvider).uploadImagesToS3(
              localImages: state.images,
              presignedUrls: presignedUrls,
              onProgress: (currentIndex, total, sent, totalBytes) {
                final fileProgress = totalBytes > 0 ? sent / totalBytes : 0;
                final overallProgress = (currentIndex + fileProgress) / total;
                state = state.copyWith(uploadProgress: overallProgress);
              },
            );

        talker.info('리뷰 이미지 업로드 완료');
      }

      state = state.copyWith(isSubmitting: false);
      return true;
    } catch (e) {
      talker.error('리뷰 등록 중 오류: $e');
      state = state.copyWith(
        isSubmitting: false,
        error: e.toString(),
      );
      return false;
    }
  }
}
