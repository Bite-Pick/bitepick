import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/goods/presentation/widgets/goods_register_form_title.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step_view_wrapper.dart';
import 'package:magambell/src/widgets/mg_reactive_textfield.dart';
import 'package:magambell/src/widgets/mg_select.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Step3PriceInfoView extends ConsumerWidget {
  const Step3PriceInfoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        final salePrice = form.control('salePrice').value as int? ?? 0;

        return StoreRegisterViewWrapper(
          children: [
            GoodsRegisterFormTitle(title: "정가"),
            MgReactiveTextField<int>(
              formControlName: 'originalPrice',
              hintText: '정가를 입력해주세요',
              keyboardType: TextInputType.number,
            ),
            Gaps.h32,
            GoodsRegisterFormTitle(
              title: "할인율 선택",
              subtitles: [
                TextSpan(text: "잉여 음식이 소비되도록 하기 위해 "),
                TextSpan(text: "정가의 50% 가격").bold(),
                TextSpan(text: "으로 고객들에게 판매하기를 권장합니다."),
              ],
            ),
            MgSelect(
              formControlName: 'discount',
              options: [
                MgSelectOption(value: 40, label: "40%"),
                MgSelectOption(value: 50, label: "50%"),
                MgSelectOption(value: 60, label: "60%"),
              ],
              bottomSheetTitle: "할인율 선택",
            ),
            // 판매가 (계산된 값)
            if (salePrice != 0)
              Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('판매가').md(),
                      Text('$salePrice원').xl().bold().red(),
                    ],
                  )
                  .margin(vertical: MgSizes.sm, horizontal: MgSizes.size20)
                  .decorated(
                    color: MgColorScheme.primaryLightest,
                    borderRadius: BorderRadius.circular(MgRadius.md),
                  )
                  .margin(top: MgSizes.xxl),
          ],
        );
      },
    );
  }
}
