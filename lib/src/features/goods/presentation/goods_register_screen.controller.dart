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

const _minDuration = Duration(minutes: 10);

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
    // 시간 강제: startTime 변경 시 endTime 자동 보정
    form.control('startTime').valueChanges.listen((start) {
      if (start is! DateTime) return;
      final endCtrl = form.control('endTime');
      final end = endCtrl.value as DateTime?;
      final minEnd = start.add(_minDuration);

      if (end == null || end.isBefore(minEnd)) {
        // emitEvent: false로 순환 이벤트/밸리데이션 폭주 방지
        endCtrl.updateValue(minEnd, emitEvent: false);
        // 필요하면 markAsDirty/markAsTouched로 UI 반영
        endCtrl.markAsDirty();
      }
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
    return FormGroup({
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
        id: state.goodsDetails.length,
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

  // 필드명 한글 매핑
  static const Map<String, String> _fieldNameMap = {
    'quantity': '수량',
    'startTime': '픽업 시작 시간',
    'endTime': '픽업 마감 시간',
    'originalPrice': '정가',
    'discount': '할인율',
    'salePrice': '판매가',
  };

  // 최종 제출
  Future<bool> submit() async {
    if (!state.form.valid) {
      state.form.markAllAsTouched();

      // 각 필드의 에러를 한글로 출력
      final invalidFieldNames = state.form.controls.entries
          .where((entry) => entry.value.invalid)
          .map((entry) => _fieldNameMap[entry.key] ?? entry.key)
          .join(', ');

      if (invalidFieldNames.isNotEmpty) {
        final context = GlobalVariable.navigatorKey.currentContext;
        if (context != null) {
          ToastPresentor.error(context, '다음 항목을 확인해주세요 : $invalidFieldNames');
        }
      }

      return false;
    }

    try {
      state = state.copyWith(
        isSubmitting: true,
        uploadProgress: 0.0,
        error: null,
      );

      final formValue = state.form.value;

      final imageUploads = state.goodsDetails.mapIndexed((index, goodsDetail) {
        return {
          'key': goodsDetail.localImage.key,
          'id': index + 1,
          'goodsName': goodsDetail.name,
        };
      }).toList();

      // TODO: 추가해야함
      // if (imageUploads.isEmpty) {
      //   final context = GlobalVariable.navigatorKey.currentContext;
      //   context != null
      //       ? ToastPresentor.error(context, "상세설명은 1개이상 추가해주세요")
      //       : talker.error("상세설명은 1개이상 추가해주세요");
      //   return false;
      // }

      // 2. Goods 등록 API 호출 (presigned URL 받기)
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
        talker.error('바이트백 등록 실패');
        return false;
      } else {
        talker.info('바이트백 등록 성공');
      }
      // 임시처리
      if (presignedUrls.isEmpty) {
        state = state.copyWith(isSubmitting: false);
        return true;
      }
      // 3. Presigned URL로 S3에 이미지 업로드
      await ref
          .read(presignedImageRepositoryProvider)
          .uploadImagesToS3(
            localImages: state.goodsDetails
                .map((goodsDetail) => goodsDetail.localImage)
                .toList(),
            presignedUrls: presignedUrls,
            onProgress: (currentIndex, total, sent, totalBytes) {
              final fileProgress = totalBytes > 0 ? sent / totalBytes : 0;
              final overallProgress = (currentIndex + fileProgress) / total;
              state = state.copyWith(uploadProgress: overallProgress);
            },
          );
      state = state.copyWith(isSubmitting: false);
      talker.debug('바이트백 등록 및 이미지 업로드 완료');
      return true;
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: e.toString());
      return false;
    }
  }
}
