import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/features/goods/domain/entities/goods.dart';
import 'package:magambell/src/features/goods/presentation/goods_edit_screen.controller.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step2_time_info_view.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step3_price_info_view.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step4_goods_info_view.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:reactive_forms/reactive_forms.dart';

class GoodsEditRoute extends GoRouteData {
  const GoodsEditRoute({this.$extra = const {}});

  /// `extra.goods`: Goods?
  final Map<String, dynamic>? $extra;
  Map<String, dynamic> get extra => $extra ?? {};
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final Goods goods = extra["goods"];
    return GoodsEditScreen(goods);
  }
}

class GoodsEditScreen extends ConsumerWidget {
  const GoodsEditScreen(this.goods, {super.key});
  final Goods goods;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(goodsEditScreenControllerProvider(goods));
    final controller = ref.read(
      goodsEditScreenControllerProvider(goods).notifier,
    );

    return ReactiveForm(
      formGroup: state.form,
      child: BaseScaffold(
        appBar: BaseAppBar(title: const Text('바이트백 수정')),
        body: Column(
          children: [
            Expanded(child: _buildContent()),
            MgButton(
              onPressed: state.isSubmitting
                  ? null
                  : () async {
                      final result = await controller.submit();
                      if (!context.mounted) return;
                      if (result) context.pop(true); // 수정 성공 후 복귀
                    },
              content: Text(state.isSubmitting ? '수정 중...' : '수정하기'),
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
          Step2TimeInfoView(), // startTime / endTime / quantity 공용
          Divider(thickness: MgSizes.size6).margin(vertical: MgSizes.xxl),
          Step3PriceInfoView(), // originalPrice / discount / salePrice 공용
          Divider(thickness: MgSizes.size6).margin(vertical: MgSizes.xxl),
          Step4GoodsInfoView(), // description 등 공용
        ],
      ).margin(vertical: MgSizes.md),
    );
  }
}
