import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/features/goods/presentation/goods_register_screen.controller.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step1_basic_info.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step2_price_info.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step3_quantity_info.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step4_time_info.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step5_confirm.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_button.dart';

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
    final currentStep = ref.watch(goodsRegisterScreenControllerProvider);
    final controller = ref.read(goodsRegisterScreenControllerProvider.notifier);

    return BaseScaffold(
      appBar: BaseAppBar(title: Text('마감백 등록')),
      body: Column(
        children: [
          _buildProgressBar(currentStep),
          Gaps.h24,
          Expanded(child: _buildStepContent(currentStep)),
          MgButton(
            onPressed: () {
              if (currentStep < STEPS - 1) {
                controller.nextStep();
              } else {
                // TODO: 최종 제출
                context.pop();
              }
            },
            content: Text(currentStep < STEPS - 1 ? '다음' : '완료'),
          ).primary().margin(horizontal: MgSizes.md, top: MgSizes.md),
        ],
      ),
    );
  }

  Widget _buildProgressBar(int currentStep) {
    return Row(
      children: List.generate(STEPS, (index) {
        final isActive = index <= currentStep;
        return Expanded(
          child: Container(
            height: 6,
            margin: EdgeInsets.only(right: index < 4 ? MgSizes.xs : 0),
            decoration: BoxDecoration(
              color: isActive ? MgColorScheme.primary : MgColorScheme.gray9,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    ).margin(vertical: MgSizes.sm, horizontal: MgSizes.md);
  }

  Widget _buildStepContent(int step) => switch (step) {
    0 => const Step1BasicInfo(),
    1 => const Step2PriceInfo(),
    2 => const Step3QuantityInfo(),
    3 => const Step4TimeInfo(),
    4 => const Step5Confirm(),
    _ => const SizedBox.shrink(),
  };
}
