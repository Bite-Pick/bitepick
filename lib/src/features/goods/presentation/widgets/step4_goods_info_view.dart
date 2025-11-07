import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step_view_wrapper.dart';
import 'package:magambell/src/widgets/mg_form_item.dart';
import 'package:magambell/src/widgets/quantity_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Step4GoodsInfoView extends ConsumerWidget {
  const Step4GoodsInfoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        
        return StoreRegisterViewWrapper(
          children: [
            // MgFormItem으로 순수한 QuantityPicker를 Form과 연결
           
            Gaps.h24,
            // 안내 메시지
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: MgColorScheme.gray1.withOpacity(0.5),
                borderRadius: BorderRadius.circular(MgRadius.md),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: MgColorScheme.gray6, size: 20),
                  Gaps.w12,
                  Expanded(
                    child: Text(
                      '재고 수량은 나중에도 수정할 수 있습니다',
                    ).sm().textColor(MgColorScheme.gray6),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
