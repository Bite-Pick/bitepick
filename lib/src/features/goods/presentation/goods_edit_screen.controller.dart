// goods_edit_screen.controller.dart
import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/goods/data/dtos/goods_detail.dto.dart';
import 'package:magambell/src/features/goods/domain/entities/goods.dart';
import 'package:magambell/src/features/goods/domain/entities/goods_detail_item.dart';
import 'package:magambell/src/features/image/data/repositories/presigned_image_repository.dart';
import 'package:magambell/src/features/image/domain/entities/local_image.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:magambell/src/features/goods/data/repositories/goods_repository.dart';

part 'goods_edit_screen.controller.freezed.dart';
part 'goods_edit_screen.controller.g.dart';

@freezed
class GoodsEditState with _$GoodsEditState {
  const factory GoodsEditState({
    required FormGroup form,
    @Default([]) List<GoodsDetailItem> goodsDetails,
    @Default(false) bool isSubmitting,
    @Default(0.0) double uploadProgress,
    String? error,
  }) = _GoodsEditState;
}

const _minDuration = Duration(minutes: 10);

@riverpod
class GoodsEditScreenController extends _$GoodsEditScreenController {
  @override
  GoodsEditState build((Goods, List<GoodsImagesList>?) param) {
    final (goods, goodsImageList) = param;
    final form = _createForm();

    // form 상태 변경을 감지하여 UI 업데이트
    form.statusChanged.listen((_) {
      state = state.copyWith();
    });

    // 등록 화면과 동일한 자동 계산 로직
    form.control('originalPrice').valueChanges.listen((_) {
      _calculateSalePrice(form);
    });
    form.control('discount').valueChanges.listen((_) {
      _calculateSalePrice(form);
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

    // 사용자가 endTime을 과거로 선택해도 즉시 보정
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

    // 서버에서 받은 Goods로 초기값 채우기
    form.patchValue(_initialFormValueFrom(goods), updateParent: true);

    // goodsImageList를 goodsDetails로 변환하여 초기값 설정
    final initialGoodsDetails = _convertGoodsImageListToDetails(goodsImageList);

    ref.onDispose(form.dispose);
    return GoodsEditState(form: form, goodsDetails: initialGoodsDetails);
  }

  List<GoodsDetailItem> _convertGoodsImageListToDetails(
      List<GoodsImagesList>? goodsImageList) {
    if (goodsImageList == null || goodsImageList.isEmpty) {
      return [];
    }

    return goodsImageList.mapIndexed((index, imageItem) {
      // 서버에서 받은 이미지는 이미 업로드된 상태이므로 uploadedUrl에 저장
      return GoodsDetailItem(
        localImage: LocalImage(
          id: index,
          key: imageItem.imageUrl?.split('/').last ?? '',
          file: null, // 이미 업로드된 이미지는 file이 없음
          uploadedUrl: imageItem.imageUrl,
        ),
        name: imageItem.goodsName ?? '',
      );
    }).toList();
  }

  Map<String, Object?> _initialFormValueFrom(Goods goods) {
    DateTime? tryParse(String s) {
      try {
        return DateTime.parse(s);
      } catch (_) {
        return null;
      }
    }

    return {
      'name': goods.storeName,
      'goodsId': goods.goodsId,
      'description': goods.description,
      // 이미지 개수는 수정화면에서 필수가 아닐 수 있음(이미 업로드된 상태)
      'quantity': goods.stockQuantity,
      'startTime': tryParse(goods.startTime),
      'endTime': tryParse(goods.endTime),
      'originalPrice': goods.originPrice,
      'discount': goods.discount,
      'salePrice': goods.salePrice,
    };
  }

  FormGroup _createForm() {
    return FormGroup({
      'name': FormControl<String>(),
      'goodsId': FormControl<String>(),
      'description': FormControl<String>(),
      'images': FormControl<int>(value: 0),
      'quantity': FormControl<int>(
        validators: [Validators.required, Validators.min(1)],
      ),
      'startTime': FormControl<DateTime>(validators: [Validators.required]),
      'endTime': FormControl<DateTime>(validators: [Validators.required]),
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
      'salePrice': FormControl<int>(validators: [Validators.required]),
    });
  }

  void _calculateSalePrice(FormGroup form) {
    final originalPrice = form.control('originalPrice').value as int? ?? 0;
    final discount = form.control('discount').value as int? ?? 0;
    final salePrice = originalPrice - (originalPrice * discount ~/ 100);
    form.control('salePrice').value = salePrice;
  }

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
    'description': '상품 설명',
    'quantity': '수량',
    'startTime': '픽업 시작 시간',
    'endTime': '픽업 마감 시간',
    'originalPrice': '정가',
    'discount': '할인율',
    'salePrice': '판매가',
  };

  Future<bool> submit() async {
    final form = state.form;
    if (!form.valid) {
      form.markAllAsTouched();

      // 각 필드의 에러를 한글로 출력
      final invalidFieldNames = form.controls.entries
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

      final formValue = form.value;

      // 상품 상세 정보를 imageUploads 형식으로 변환
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
      //   state = state.copyWith(isSubmitting: false);
      //   return false;
      // }

      final presignedUrls = await ref
          .read(goodsRepositoryProvider)
          .editGoods(
            // name: formValue['name'] as String?,
            goodsId: formValue['goodsId'] as String,
            // description: formValue['description'] as String?,
            originalPrice: formValue['originalPrice'] as int,
            discount: formValue['discount'] as int,
            salePrice: formValue['salePrice'] as int,
            quantity: formValue['quantity'] as int,
            startTime: formValue['startTime'] as DateTime,
            endTime: formValue['endTime'] as DateTime,
            goodsImagesRegisters: imageUploads,
          );

      if (presignedUrls == null) {
        talker.error('바이트백 수정 실패');
        state = state.copyWith(isSubmitting: false);
        return false;
      } else {
        talker.info('바이트백 수정 성공, 이미지 업로드 준비');
      }
      // 임시처리
      if (presignedUrls.isEmpty) {
        state = state.copyWith(isSubmitting: false);
        return true;
      }

      // Presigned URL로 S3에 이미지 업로드
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
      talker.debug('바이트백 수정 및 이미지 업로드 완료');
      return true;
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: e.toString());
      return false;
    }
  }
}
