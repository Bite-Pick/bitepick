import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/features/goods/data/repositories/goods_repository.dart';
import 'package:magambell/src/features/goods/domain/entities/image_upload_request.dart';
import 'package:magambell/src/features/goods/domain/entities/local_image.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'goods_register_screen.controller.freezed.dart';
part 'goods_register_screen.controller.g.dart';

@freezed
class GoodsRegisterState with _$GoodsRegisterState {
  const factory GoodsRegisterState({
    required int currentStep,
    required FormGroup form,
    @Default([]) List<LocalImage> localImages, // 로컬 이미지 파일들
    @Default(false) bool isSubmitting,
    @Default(0.0) double uploadProgress,
    String? error,
  }) = _GoodsRegisterState;
}

@riverpod
class GoodsRegisterScreenController extends _$GoodsRegisterScreenController {
  @override
  GoodsRegisterState build() {
    final form = _createForm();

    // 가격 계산 로직
    form.control('originalPrice').valueChanges.listen((_) {
      _calculateSalePrice();
    });
    form.control('discount').valueChanges.listen((_) {
      _calculateSalePrice();
    });

    ref.onDispose(() {
      form.dispose();
    });

    return GoodsRegisterState(currentStep: 0, form: form);
  }

  FormGroup _createForm() {
    return FormGroup({
      // Step 1: 마감백 설명 및 이미지
      'description': FormControl<String>(
        validators: [Validators.required, Validators.minLength(10)],
      ),
      'images': FormControl<int>(
        value: 0,
        validators: [Validators.required, Validators.min(1)],
      ),

      // Step 2: 가격 정보
      'originalPrice': FormControl<int>(
        validators: [Validators.required, Validators.min(0)],
      ),
      'discount': FormControl<int>(
        validators: [
          Validators.required,
          Validators.min(0),
          Validators.max(100),
        ],
      ),
      'salePrice': FormControl<int>(),

      // Step 3: 수량
      'quantity': FormControl<int>(
        value: 0,
        validators: [Validators.required, Validators.min(1)],
      ),

      // Step 4: 시간
      'startTime': FormControl<DateTime>(validators: [Validators.required]),
      'endTime': FormControl<DateTime>(validators: [Validators.required]),
    });
  }

  void _calculateSalePrice() {
    final originalPrice =
        state.form.control('originalPrice').value as int? ?? 0;
    final discount = state.form.control('discount').value as int? ?? 0;
    final salePrice = originalPrice - (originalPrice * discount ~/ 100);
    state.form.control('salePrice').value = salePrice;
  }

  // 다음 단계로 이동
  void nextStep() {
    if (state.currentStep < 4) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  // 이전 단계로 이동
  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  // 특정 단계로 이동
  void goToStep(int step) {
    if (step >= 0 && step <= 4) {
      state = state.copyWith(currentStep: step);
    }
  }

  // 진행률 계산 (0.0 ~ 1.0)
  double get progress => (state.currentStep + 1) / 5;

  // Step별 validation
  bool validateStep(int step) {
    switch (step) {
      case 0:
        return state.form.control('description').valid &&
            state.form.control('images').valid;
      case 1:
        return state.form.control('originalPrice').valid &&
            state.form.control('discount').valid;
      case 2:
        return state.form.control('quantity').valid;
      case 3:
        return state.form.control('startTime').valid &&
            state.form.control('endTime').valid;
      case 4:
        return state.form.valid;
      default:
        return false;
    }
  }

  // 로컬 이미지 추가 (갤러리에서 선택한 파일)
  void addLocalImages(List<File> files) {
    final newImages = <LocalImage>[];
    var currentId = state.localImages.length;

    for (final file in files) {
      final fileName = file.path.split('/').last;
      newImages.add(
        LocalImage(
          id: currentId,
          key: fileName,
          file: file,
        ),
      );
      currentId++;
    }

    final updatedImages = [...state.localImages, ...newImages];
    state = state.copyWith(localImages: updatedImages);

    // Form에 이미지 개수 업데이트
    state.form.control('images').value = updatedImages.length;
  }

  // 이미지 제거
  void removeImage(int index) {
    if (index >= 0 && index < state.localImages.length) {
      final updatedImages = List<LocalImage>.from(state.localImages)
        ..removeAt(index);
      state = state.copyWith(localImages: updatedImages);

      // Form에 이미지 개수 업데이트
      state.form.control('images').value = updatedImages.length;
    }
  }

  // 최종 제출
  Future<void> submit() async {
    if (!state.form.valid) {
      state.form.markAllAsTouched();
      return;
    }

    try {
      state = state.copyWith(
        isSubmitting: true,
        uploadProgress: 0.0,
        error: null,
      );

      final formValue = state.form.value;
      final repository = ref.read(goodsRepositoryProvider);

      // 1. 이미지 메타데이터 생성
      final imageMetadataList = state.localImages
          .map((img) => ImageMetadata(id: img.id, key: img.key))
          .toList();

      // 2. Goods 등록 API 호출 (presigned URL 받기)
      final presignedUrls = await repository.createGoods(
        description: formValue['description'] as String,
        originalPrice: formValue['originalPrice'] as int,
        discount: formValue['discount'] as int,
        salePrice: formValue['salePrice'] as int,
        quantity: formValue['quantity'] as int,
        startTime: formValue['startTime'] as DateTime,
        endTime: formValue['endTime'] as DateTime,
        goodsImagesRegisters: imageMetadataList,
      );

      // 3. Presigned URL로 S3에 이미지 업로드
      await repository.uploadImagesToS3(
        localImages: state.localImages,
        presignedUrls: presignedUrls,
        onProgress: (currentIndex, total, sent, totalBytes) {
          final fileProgress = totalBytes > 0 ? sent / totalBytes : 0;
          final overallProgress = (currentIndex + fileProgress) / total;
          state = state.copyWith(uploadProgress: overallProgress);
        },
      );

      state = state.copyWith(
        isSubmitting: false,
        uploadProgress: 1.0,
      );

      // 성공 처리
      print('Goods 등록 및 이미지 업로드 완료');
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        error: e.toString(),
      );
    }
  }
}
