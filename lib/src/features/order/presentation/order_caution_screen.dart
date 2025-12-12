import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/order/presentation/order_pay_screen.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class OrderCautionRoute extends GoRouteData {
  const OrderCautionRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const OrderCautionScreen();
  }
}

class OrderCautionScreen extends StatelessWidget {
  const OrderCautionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(),
      body: Column(
        children: [
          // Title
          Text('결제 전 확인해주세요').lg().bold(),
          Gaps.h20,
          // Content cards
          _buildCautionCard(
            number: '01',
            title: '바이트백은 랜덤으로 구성되어있어요',
            subtitle: '랜덤하게 드리는 특별한 선물을 기대해보세요',
            imagePath: R.ASSETS_IMAGES_ORDER_CAUTION_1_PNG,
          ),
          Gaps.h20,
          _buildCautionCard(
            number: '02',
            title: '픽업시간을 지켜주세요',
            subtitle: '픽업시간은 사장님과의 약속이에요',
            imagePath: R.ASSETS_IMAGES_ORDER_CAUTION_2_PNG,
          ),
          Spacer(),
          // Bottom button
          MgButton(
            onPressed: () async {
              await const OrderPayRoute().push(context);
            },
            content: Text('결제하기'),
          ).primary().margin(horizontal: MgSizes.md, bottom: MgSizes.xxl),
        ],
      ),
    );
  }

  Widget _buildCautionCard({
    required String number,
    required String title,
    required String subtitle,
    required String imagePath,
  }) {
    return Column(
          children: [
            Text(number)
                .textColor(MgColorScheme.white)
                .bold()
                .margin(horizontal: MgSizes.md, vertical: MgSizes.xs)
                .decorated(
                  color: MgColorScheme.green,
                  borderRadius: BorderRadius.circular(1000),
                ),
            Gaps.h8,
            Text(title).md().bold(),
            Gaps.h4,
            Text(subtitle).sm().textGray(),
            Gaps.h20,
            Image.asset(imagePath).constrained(height: 130.h),
          ],
        )
        .margin(top: MgSizes.lg)
        .decorated(
          color: MgColorScheme.gray9,
          borderRadius: BorderRadius.circular(MgRadius.lg),
        )
        .constrained(width: double.infinity)
        .margin(horizontal: MgSizes.xxl);
  }
}
