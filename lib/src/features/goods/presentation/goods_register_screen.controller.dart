import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'goods_register_screen.controller.freezed.dart';
part 'goods_register_screen.controller.g.dart';

@freezed
class GoodsRegisterState with _$GoodsRegisterState {
  const factory GoodsRegisterState({
    required int currentStep,
    required FormGroup form,
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

    return GoodsRegisterState(
      currentStep: 0,
      form: form,
    );
  }

  FormGroup _createForm() {
    return FormGroup({
      // Step 1: 마감백 설명 및 이미지
      'description': FormControl<String>(
        validators: [Validators.required, Validators.minLength(10)],
      ),
      'images': FormControl<List<String>>(
        value: [],
        validators: [Validators.required],
      ),

      // Step 2: 가격 정보
      'originalPrice': FormControl<int>(
        validators: [Validators.required, Validators.min(0)],
      ),
      'discount': FormControl<int>(
        validators: [Validators.required, Validators.min(0), Validators.max(100)],
      ),
      'salePrice': FormControl<int>(),

      // Step 3: 수량
      'quantity': FormControl<int>(
        value: 0,
        validators: [Validators.required, Validators.min(1)],
      ),

      // Step 4: 시간
      'startTime': FormControl<DateTime>(
        validators: [Validators.required],
      ),
      'endTime': FormControl<DateTime>(
        validators: [Validators.required],
      ),
    });
  }

  void _calculateSalePrice() {
    final originalPrice = state.form.control('originalPrice').value as int? ?? 0;
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

  // 최종 제출
  Future<void> submit() async {
    if (!state.form.valid) {
      state.form.markAllAsTouched();
      return;
    }

    final formValue = state.form.value;
    // TODO: API 호출
    print('Form submitted: $formValue');
  }
}
