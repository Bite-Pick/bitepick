import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/features/goods/data/repositories/goods_repository.dart';
import 'package:magambell/src/features/goods/domain/entities/goods_detail_item.dart';
import 'package:magambell/src/features/image/data/repositories/presigned_image_repository.dart';
import 'package:magambell/src/features/image/domain/entities/local_image.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'goods_register_screen.controller.freezed.dart';
part 'goods_register_screen.controller.g.dart';

@freezed
class GoodsRegisterState with _$GoodsRegisterState {
  const factory GoodsRegisterState({
    required int currentStep,
    required FormGroup form,
    @Default([]) List<GoodsDetailItem> goodsDetails, // Step4: 상품 상세 정보 리스트
    @Default(false) bool isSubmitting,
    @Default(0.0) double uploadProgress,
    String? error,
  }) = _GoodsRegisterState;
}

const _minDuration = Duration(minutes: 30);

@riverpod
class GoodsRegisterScreenController extends _$GoodsRegisterScreenController {
  @override
  GoodsRegisterState build() {
    final form = _createForm();

    // form 상태 변경을 감지하여 UI 업데이트
    form.statusChanged.listen((_) {
      state = state.copyWith();
    });

    // 가격 계산 로직
    form.control('originalPrice').valueChanges.listen((_) {
      _calculateSalePrice();
    });
    form.control('discount').valueChanges.listen((_) {
      _calculateSalePrice();
    });
    form.control('endTime').valueChanges.listen((end) {
      if (end is! DateTime) return;
      final start = form.control('startTime').value as DateTime?;
      if (start == null) return;
      final minEnd = start.add(_minDuration);

      if (end.isBefore(minEnd)) {
        form.control('endTime').updateValue(minEnd, emitEvent: false);
        form.control('endTime').markAsDirty();

        final context = GlobalVariable.navigatorKey.currentContext;
        if (context != null) {
          ToastPresentor.error(context, "종료시간은 시작시간보다 뒤여야합니다");
        }
      }
    });
    ref.onDispose(() {
      form.dispose();
    });

    return GoodsRegisterState(currentStep: 0, form: form);
  }

  FormGroup _createForm() {
    final form = FormGroup({
      'quantity': FormControl<int>(
        value: 1,
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

    // 초기 상태에서는 에러 표시 안함
    form.markAsUntouched();
    return form;
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

  void fillWithMockData(Map<String, Object> data) =>
      state.form.patchValue(data);

  // 상품 상세 정보 추가
  void addGoodsDetail(File file, String name) {
    final fileName = file.path.split('/').last;
    final newDetail = GoodsDetailItem(
      localImage: LocalImage(
        id: state.goodsDetails.length + 1, // 1부터 시작 (서버와 매칭)
        key: fileName,
        file: file,
      ),
      name: name,
    );

    final updatedDetails = [...state.goodsDetails, newDetail];
    state = state.copyWith(goodsDetails: updatedDetails);
  }

  // 상품 상세 정보 업데이트
  void updateGoodsDetail(int index, File? file, String? name) {
    if (index >= 0 && index < state.goodsDetails.length) {
      final detail = state.goodsDetails[index];
      final updatedDetail = GoodsDetailItem(
        localImage: LocalImage(
          id: detail.localImage.id,
          key: file != null ? file.path.split('/').last : detail.localImage.key,
          file: file ?? detail.localImage.file,
          uploadedUrl: detail.localImage.uploadedUrl,
        ),
        name: name ?? detail.name,
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
    talker.debug('========== [GOODS_REGISTER] Submit 시작 ==========');

    // Form validation 체크 - TextField에 인라인 에러 표시
    if (!state.form.valid) {
      talker.warning('[GOODS_REGISTER] Form validation 실패');
      state.form.markAllAsTouched();
      return false;
    }

    try {
      state = state.copyWith(
        isSubmitting: true,
        uploadProgress: 0.0,
        error: null,
      );

      final formValue = state.form.value;
      talker.debug('[GOODS_REGISTER] Form values: ${formValue.keys.toList()}');

      // 1. goodsDetails 상태 확인
      talker.debug('[GOODS_REGISTER] goodsDetails 개수: ${state.goodsDetails.length}');
      for (var i = 0; i < state.goodsDetails.length; i++) {
        final detail = state.goodsDetails[i];
        talker.debug('[GOODS_REGISTER] [$i] name: ${detail.name}, key: ${detail.localImage.key}, file exists: ${detail.localImage.file != null}');
      }

      final imageUploads = state.goodsDetails.mapIndexed((index, goodsDetail) {
        return {
          'key': goodsDetail.localImage.key,
          'id': index + 1,
          'goodsName': goodsDetail.name,
        };
      }).toList();

      talker.debug('[GOODS_REGISTER] imageUploads 생성 완료: ${imageUploads.length}개');
      talker.debug('[GOODS_REGISTER] imageUploads 내용: $imageUploads');

      // TODO: 추가해야함
      // if (imageUploads.isEmpty) {
      //   final context = GlobalVariable.navigatorKey.currentContext;
      //   context != null
      //       ? ToastPresentor.error(context, "상세설명은 1개이상 추가해주세요")
      //       : talker.error("상세설명은 1개이상 추가해주세요");
      //   return false;
      // }

      // 2. Goods 등록 API 호출 (presigned URL 받기)
      talker.info('[GOODS_REGISTER] API 요청 시작 - createGoods');
      final presignedUrls = await ref
          .read(goodsRepositoryProvider)
          .createGoods(
            originalPrice: formValue['originalPrice'] as int,
            discount: formValue['discount'] as int,
            salePrice: formValue['salePrice'] as int,
            quantity: formValue['quantity'] as int,
            startTime: formValue['startTime'] as DateTime,
            endTime: formValue['endTime'] as DateTime,
            goodsImagesRegisters: imageUploads,
          );

      if (presignedUrls == null) {
        talker.error('[GOODS_REGISTER] ❌ API 응답 null - 바이트백 등록 실패');
        state = state.copyWith(isSubmitting: false);
        return false;
      } else {
        talker.info('[GOODS_REGISTER] ✅ API 응답 성공 - presignedUrls 개수: ${presignedUrls.length}');
        for (var i = 0; i < presignedUrls.length; i++) {
          talker.debug('[GOODS_REGISTER] presignedUrl[$i] - id: ${presignedUrls[i].id}, url: ${presignedUrls[i].url?.substring(0, 50)}...');
        }
      }

      // 임시처리
      if (presignedUrls.isEmpty) {
        talker.warning('[GOODS_REGISTER] ⚠️ presignedUrls가 비어있음 - 이미지 업로드 없이 완료');
        state = state.copyWith(isSubmitting: false);
        return true;
      }

      // 3. Presigned URL로 S3에 이미지 업로드
      final localImagesToUpload = state.goodsDetails
          .map((goodsDetail) => goodsDetail.localImage)
          .toList();

      talker.info('[GOODS_REGISTER] S3 업로드 시작 - 파일 개수: ${localImagesToUpload.length}');
      for (var i = 0; i < localImagesToUpload.length; i++) {
        final img = localImagesToUpload[i];
        talker.debug('[GOODS_REGISTER] 업로드 파일[$i] - id: ${img.id}, key: ${img.key}, file: ${img.file?.path}');
      }

      await ref
          .read(presignedImageRepositoryProvider)
          .uploadImagesToS3(
            localImages: localImagesToUpload,
            presignedUrls: presignedUrls,
            onProgress: (currentIndex, total, sent, totalBytes) {
              final fileProgress = totalBytes > 0 ? sent / totalBytes : 0;
              final overallProgress = (currentIndex + fileProgress) / total;
              talker.debug('[GOODS_REGISTER] 업로드 진행률: ${(overallProgress * 100).toStringAsFixed(1)}% ($currentIndex/$total)');
              state = state.copyWith(uploadProgress: overallProgress);
            },
          );

      state = state.copyWith(isSubmitting: false);
      talker.info('[GOODS_REGISTER] ✅ 바이트백 등록 및 이미지 업로드 완료');
      talker.debug('========== [GOODS_REGISTER] Submit 종료 ==========');
      return true;
    } catch (e, stackTrace) {
      talker.error('[GOODS_REGISTER] ❌ Submit 중 오류 발생', e, stackTrace);
      state = state.copyWith(isSubmitting: false, error: e.toString());
      return false;
    }
  }
}
