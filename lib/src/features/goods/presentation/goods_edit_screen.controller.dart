// goods_edit_screen.controller.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/features/goods/domain/entities/goods.dart';
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
    @Default(false) bool isSubmitting,
    String? error,
  }) = _GoodsEditState;
}

const _minDuration = Duration(minutes: 10);

@riverpod
class GoodsEditScreenController extends _$GoodsEditScreenController {
  @override
  GoodsEditState build(Goods goods) {
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

    ref.onDispose(form.dispose);
    return GoodsEditState(form: form);
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
      'description': FormControl<String>(
        validators: [Validators.required, Validators.minLength(10)],
      ),
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
      state = state.copyWith(isSubmitting: true, error: null);

      final formValue = form.value;

      final presignedUrls = await ref
          .read(goodsRepositoryProvider)
          .editGoods(
            name: formValue['name'] as String?,
            goodsId: formValue['goodsId'] as String,
            description: formValue['description'] as String,
            originalPrice: formValue['originalPrice'] as int,
            discount: formValue['discount'] as int,
            salePrice: formValue['salePrice'] as int,
            quantity: formValue['quantity'] as int,
            startTime: formValue['startTime'] as DateTime,
            endTime: formValue['endTime'] as DateTime,
          );

      // Presigned URL로 S3에 이미지 업로드
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
      state = state.copyWith(
        isSubmitting: false,
        error: presignedUrls == null ? "API 실패" : null,
      );
      return true;
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: e.toString());
      return false;
    }
  }
}
