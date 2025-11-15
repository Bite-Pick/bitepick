import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/features/goods/presentation/goods_register_screen.controller.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step3_price_info_view.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step4_goods_info_view.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step2_time_info_view.dart';
import 'package:magambell/src/features/user/providers/user.provider.dart';
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
  final mockFormData = {
    'description': '갓 구운 크로와상, 바게트, 식빵 세트입니다. 당일 생산, 당일 판매 원칙을 지킵니다.',
    'originalPrice': 15000,
    'discount': 30,
    'quantity': 5,
    'startTime': DateTime.now().add(const Duration(hours: 1)),
    'endTime': DateTime.now().add(const Duration(hours: 3)),
  };

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(goodsRegisterScreenControllerProvider);
    final controller = ref.read(goodsRegisterScreenControllerProvider.notifier);

    return ReactiveForm(
      formGroup: state.form,
      child: BaseScaffold(
        appBar: BaseAppBar(
          title: const Text('바이트백 등록'),
          // action: TextButton(
          //   onPressed: () => controller.fillWithMockData(mockFormData),
          //   child: const Text('임시완성'),
          // ),
        ),
        body: Column(
          children: [
            Expanded(child: _buildContent()),
            MgButton(
              onPressed: () async {
                final result = await controller.submit();
                if (result && context.mounted) {
                  FocusScope.of(context).unfocus();

                  ref.invalidate(userStateProvider);
                  DefaultRoute().go(context);
                }
              },
              content: Text('등록하기'),
              disabled: state.form.invalid,
            ).primary().margin(horizontal: MgSizes.md, top: MgSizes.md),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Step2TimeInfoView(),
          Divider(thickness: MgSizes.size6).margin(vertical: MgSizes.xxl),
          Step3PriceInfoView(),
          Divider(thickness: MgSizes.size6).margin(vertical: MgSizes.xxl),
          Step4GoodsInfoView(),
        ],
      ).margin(vertical: MgSizes.md),
    );
  }
}
