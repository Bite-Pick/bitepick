import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/mg_bottomsheet.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class OrderCompleteBottomSheet extends StatelessWidget {
  const OrderCompleteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return MgBottomsheet(
      Column(
        children: [
          Column(
            children: [
              Text('주문 성공').md().bold().margin(vertical: MgSizes.md),
              Image.asset(R.ASSETS_IMAGES_ORDER_COMPLETE_GREEN_PNG),
              Text("주문이 완료되었어요").md(),
              Gaps.h4,
              Text(
                "이번 주문으로 환경 보호에 동참하셨어요!\n지정된 픽업 시간에 맞춰 방문해 주세요.",
              ).md().textGray(),
              MgButton(onPressed: context.pop, content: Text("확인")).primary(),
            ],
          ).margin(all: MgSizes.md),
        ],
      ),
    );
  }
}
