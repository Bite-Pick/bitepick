import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/features/goods/presentation/goods_register_screen.controller.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step1_basic_info_view.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step3_price_info_view.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step4_goods_info_view.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step2_time_info_view.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step5_tags_view.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:reactive_forms/reactive_forms.dart';

class GoodsRegisterRoute extends GoRouteData {
  const GoodsRegisterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const GoodsRegisterScreen();
  }
}

class GoodsRegisterScreen extends ConsumerStatefulWidget {
  const GoodsRegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GoodsRegisterScreenState();
}

class _GoodsRegisterScreenState extends ConsumerState<GoodsRegisterScreen> {
  static const STEPS = 5;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(goodsRegisterScreenControllerProvider);
    final controller = ref.read(goodsRegisterScreenControllerProvider.notifier);

    return ReactiveForm(
      formGroup: state.form,
      child: BaseScaffold(
        appBar: BaseAppBar(title: Text('마감백 등록')),
        body: Column(
          children: [
            _buildProgressBar(state.currentStep),
            Gaps.h24,
            Expanded(child: _buildStepContent(state.currentStep)),
            MgButton(
              onPressed: () async {
                if (state.currentStep < STEPS - 1) {
                  // if (controller.validateStep(state.currentStep)) {
                  controller.nextStep();
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(content: Text('입력 항목을 확인해주세요')),
                  //   );
                  // }
                } else {
                  await controller.submit();
                  if (context.mounted) context.pop();
                }
              },
              content: Text(state.currentStep < STEPS - 1 ? '다음' : '완료'),
            ).primary().margin(horizontal: MgSizes.md, top: MgSizes.md),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(int currentStep) {
    return Row(
      children: List.generate(STEPS, (index) {
        final isActive = index <= currentStep;
        return Expanded(
          child: GestureDetector(
            onTap: () {
              ref
                  .read(goodsRegisterScreenControllerProvider.notifier)
                  .goToStep(index);
            },
            child: Container(
              height: 6,
              margin: EdgeInsets.only(right: index < 4 ? MgSizes.xs : 0),
              decoration: BoxDecoration(
                color: isActive ? MgColorScheme.primary : MgColorScheme.gray9,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        );
      }),
    ).margin(vertical: MgSizes.sm, horizontal: MgSizes.md);
  }

  Widget _buildStepContent(int step) => switch (step) {
    0 => const Step1BasicInfoView(),
    1 => const Step2TimeInfoView(),
    2 => const Step3PriceInfoView(),
    3 => const Step4GoodsInfoView(),
    4 => const Step5TagsView(),
    _ => const SizedBox.shrink(),
  };
}
