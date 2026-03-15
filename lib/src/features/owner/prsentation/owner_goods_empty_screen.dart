import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/goods/presentation/goods_register_screen.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class OwnerGoodsEmptyRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return OwnerGoodsEmptyScreen();
  }
}

class OwnerGoodsEmptyScreen extends ConsumerWidget {
  const OwnerGoodsEmptyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseScaffold(
      canSwipeBack: false,
      appBar: BaseAppBar(leading: SizedBox.shrink()),
      body: Column(
        children: [
          _buildStepIndicator().margin(top: MgSizes.xl, horizontal: MgSizes.xl),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  R.ASSETS_IMAGES_CHARACTER_EMPTY_PNG,
                ).constrained(height: 160.h),
                Gaps.h24,
                Text("마지막 단계예요!").xl().bold(),
                Gaps.h8,
                Text(
                  "바이트백을 등록해야\n매장 심사가 시작됩니다.",
                ).md().textGray().center(),
              ],
            ),
          ),
          MgButton(
            content: const Text("바이트백 등록하기"),
            onPressed: () => GoodsRegisterRoute().go(context),
          ).primary().margin(horizontal: MgSizes.md, bottom: MgSizes.xxl),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      children: [
        _buildStep(number: "1", label: "매장 등록"),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MgSizes.xs),
            child: Container(
              height: 2,
              color: MgColorScheme.primary,
            ),
          ),
        ),
        _buildStep(number: "2", label: "바이트백 등록"),
      ],
    );
  }

  Widget _buildStep({required String number, required String label}) {
    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: MgColorScheme.primary,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(number).xs().bold(),
        ),
        Gaps.h4,
        Text(label).xs(),
      ],
    );
  }
}
