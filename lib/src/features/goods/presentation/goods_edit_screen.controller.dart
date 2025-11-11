// goods_edit_screen.controller.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/features/goods/domain/entities/goods.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'goods_edit_screen.dart'; // Goods 타입 참조
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

@riverpod
class GoodsEditScreenController extends _$GoodsEditScreenController {
  @override
  GoodsEditState build(Goods goods) {
    final form = _createForm();

    // 등록 화면과 동일한 자동 계산 로직
    form.control('originalPrice').valueChanges.listen((_) {
      _calculateSalePrice(form);
    });
    form.control('discount').valueChanges.listen((_) {
      _calculateSalePrice(form);
    });

    // 서버에서 받은 Goods로 초기값 채우기
    form.patchValue(_initialFormValueFrom(goods), updateParent: true);

    ref.onDispose(form.dispose);
    return GoodsEditState(form: form);
  }

  Map<String, Object?> _initialFormValueFrom(Goods g) {
    DateTime? _tryParse(String s) {
      try {
        return DateTime.parse(s);
      } catch (_) {
        return null;
      }
    }

    return {
      'description': g.description,
      // 이미지 개수는 수정화면에서 필수가 아닐 수 있음(이미 업로드된 상태)
      'images': 0,
      'quantity': g.stockQuantity,
      'startTime': _tryParse(g.startTime),
      'endTime': _tryParse(g.endTime),
      'originalPrice': g.originPrice,
      'discount': g.discount,
      'salePrice': g.salePrice,
    };
  }

  FormGroup _createForm() {
    return FormGroup({
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

  Future<bool> submit() async {
    final form = state.form;
    if (!form.valid) {
      form.markAllAsTouched();
      return false;
    }

    try {
      state = state.copyWith(isSubmitting: true, error: null);

      final v = form.value;
      // TODO: edit api 호출
      state = state.copyWith(isSubmitting: false);
      return true;
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: e.toString());
      return false;
    }
  }
}
