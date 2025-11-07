import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'goods_register_screen.controller.g.dart';

@riverpod
class GoodsRegisterScreenController extends _$GoodsRegisterScreenController {
  @override
  int build() {
    return 0; // 현재 단계 (0-4)
  }

  // 다음 단계로 이동
  void nextStep() {
    if (state < 4) state = state + 1;
  }

  // 이전 단계로 이동
  void previousStep() {
    if (state > 0) state = state - 1;
  }

  // 특정 단계로 이동
  void goToStep(int step) {
    if (step >= 0 && step <= 4) state = step;
  }

  // 진행률 계산 (0.0 ~ 1.0)
  double get progress => (state + 1) / 5;
}
