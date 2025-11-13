import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/goods/data/repositories/goods_repository.dart';
import 'package:magambell/src/features/goods/domain/entities/goods_detail_item.dart';
import 'package:magambell/src/features/image/data/repositories/presigned_image_repository.dart';
import 'package:magambell/src/features/image/domain/entities/image_meta_data.dart';
import 'package:magambell/src/features/image/domain/entities/local_image.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'goods_register_screen.controller.freezed.dart';
part 'goods_register_screen.controller.g.dart';

@freezed
class GoodsRegisterState with _$GoodsRegisterState {
  const factory GoodsRegisterState({
    required int currentStep,
    required FormGroup form,
    @Default([]) List<LocalImage> localImages, // Step1: 대표 이미지 파일들
    @Default([]) List<GoodsDetailItem> goodsDetails, // Step4: 상품 상세 정보 리스트
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
      // Step 2: 수량, 판매 시작,마감 시간
      'quantity': FormControl<int>(
        value: 0,
        validators: [Validators.required, Validators.min(1)],
      ),

      'startTime': FormControl<DateTime>(validators: [Validators.required]),
      'endTime': FormControl<DateTime>(validators: [Validators.required]),

      // Step 3: 가격 정보
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
    });
  }

  void _calculateSalePrice() {
    final originalPrice =
        state.form.control('originalPrice').value as int? ?? 0;
    final discount = state.form.control('discount').value as int? ?? 0;
    final salePrice = originalPrice - (originalPrice * discount ~/ 100);
    state.form.control('salePrice').value = salePrice;
  }

  // // Step별 validation
  // bool validateStep(int step) {
  //   switch (step) {
  //     case 0:
  //       return state.form.control('description').valid &&
  //           state.form.control('images').valid;
  //     case 1:
  //       return state.form.control('originalPrice').valid &&
  //           state.form.control('discount').valid;
  //     case 2:
  //       return state.form.control('quantity').valid;
  //     case 3:
  //       return state.form.control('startTime').valid &&
  //           state.form.control('endTime').valid;
  //     case 4:
  //       return state.form.valid;
  //     default:
  //       return false;
  //   }
  // }

  void fillWithMockData(Map<String, Object> data) {
    state.form.patchValue(data);
  }

  // 상품 상세 정보 추가
  void addGoodsDetail({required File file, required String name}) {
    final fileName = file.path.split('/').last;
    final newDetail = GoodsDetailItem(
      id: state.goodsDetails.length,
      key: fileName,
      name: name,
      file: file,
    );

    final updatedDetails = [...state.goodsDetails, newDetail];
    state = state.copyWith(goodsDetails: updatedDetails);
  }

  // 상품 상세 정보 업데이트
  void updateGoodsDetail({required int index, File? file, String? name}) {
    if (index >= 0 && index < state.goodsDetails.length) {
      final detail = state.goodsDetails[index];
      final updatedDetail = GoodsDetailItem(
        id: detail.id,
        key: file != null ? file.path.split('/').last : detail.key,
        name: name ?? detail.name,
        file: file ?? detail.file,
        uploadedUrl: detail.uploadedUrl,
      );

      final updatedDetails = List<GoodsDetailItem>.from(state.goodsDetails);
      updatedDetails[index] = updatedDetail;
      state = state.copyWith(goodsDetails: updatedDetails);
    }
  }

  // 상품 상세 정보 제거
  void removeGoodsDetail(int index) {
    if (index >= 0 && index < state.goodsDetails.length) {
      final updatedDetails = List<GoodsDetailItem>.from(state.goodsDetails)
        ..removeAt(index);
      state = state.copyWith(goodsDetails: updatedDetails);
    }
  }

  // 최종 제출
  Future<bool> submit() async {
    if (!state.form.valid) {
      state.form.markAllAsTouched();
      // Iterate over the form controls and print errors for invalid ones.
      state.form.controls.forEach((key, control) {
        if (control.invalid) {
          talker.debug('Invalid field: [$key], Errors: ${control.errors}');
        }
      });
      return false;
    }

    try {
      state = state.copyWith(
        isSubmitting: true,
        uploadProgress: 0.0,
        error: null,
      );

      final formValue = state.form.value;

      // 2. Goods 등록 API 호출 (presigned URL 받기)
      final presignedUrls = await ref
          .read(goodsRepositoryProvider)
          .createGoods(
            description: formValue['description'] as String,
            originalPrice: formValue['originalPrice'] as int,
            discount: formValue['discount'] as int,
            salePrice: formValue['salePrice'] as int,
            quantity: formValue['quantity'] as int,
            startTime: formValue['startTime'] as DateTime,
            endTime: formValue['endTime'] as DateTime,
            // TODO: 상세 설명추가
          );

      // 3. Presigned URL로 S3에 이미지 업로드
      // TODO: 상세설명 API 수정 이후 연결
      // await ref
      //     .read(presignedImageRepositoryProvider)
      //     .uploadImagesToS3(
      //       localImages: state.localImages,
      //       presignedUrls: presignedUrls,
      //       onProgress: (currentIndex, total, sent, totalBytes) {
      //         final fileProgress = totalBytes > 0 ? sent / totalBytes : 0;
      //         final overallProgress = (currentIndex + fileProgress) / total;
      //         state = state.copyWith(uploadProgress: overallProgress);
      //       },
      //     );

      state = state.copyWith(isSubmitting: false, uploadProgress: 1.0);

      // 성공 처리
      talker.debug('Goods 등록 및 이미지 업로드 완료');
      return true;
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: e.toString());
      return false;
    }
  }
}
