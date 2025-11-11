import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/goods/presentation/widgets/goods_register_form_title.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step_view_wrapper.dart';
import 'package:magambell/src/features/goods/presentation/widgets/time_picker_bottomsheet.dart';
import 'package:magambell/src/widgets/mg_form_item.dart';
import 'package:magambell/src/widgets/quantity_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

// TODO: 판매시작 시간 이후로 종료시간을 설정할 수 있도록 수정
class Step2TimeInfoView extends ConsumerWidget {
  const Step2TimeInfoView({super.key});

  String _formatTime(DateTime? time) {
    if (time == null) return '';
    final formatter = DateFormat('a h시 mm분', 'ko_KR');
    return formatter.format(time);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        final quantityControl = form.control('quantity') as FormControl<int>;
        final quantity = quantityControl.value ?? 0;

        final startTimeControl =
            form.control('startTime') as FormControl<DateTime>;
        final endTimeControl = form.control('endTime') as FormControl<DateTime>;

        return StoreRegisterViewWrapper(
          children: [
            GoodsRegisterFormTitle(title: "판매 시작시간"),
            _buildTimeSelector(
              context: context,
              control: startTimeControl,
              placeholder: '판매 시작 시간',
            ),
            Gaps.h32,
            GoodsRegisterFormTitle(title: "판매 종료시간"),
            _buildTimeSelector(
              context: context,
              control: endTimeControl,
              placeholder: '판매 종료 시간',
            ),
            Gaps.h32,
            GoodsRegisterFormTitle(
              title: "판매 개수",
              subtitles: [TextSpan(text: "하루에 판매할 양을 설정해주세요")],
            ),
            MgFormItem(
              name: 'quantity',
              child:
                  QuantityPicker(
                    count: quantity,
                    onCountChanged: (quantity) {
                      form.updateValue({'quantity': quantity});
                    },
                    alignment: MainAxisAlignment.spaceAround,
                    backgroundColor: Colors.transparent,
                  ).decorated(
                    border: Border.all(color: MgColorScheme.gray7, width: 1),
                    borderRadius: BorderRadius.circular(MgRadius.md),
                  ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTimeSelector({
    required BuildContext context,
    required FormControl<DateTime> control,
    required String placeholder,
  }) {
    return GestureDetector(
      onTap: () {
        TimePickerBottomSheet.show(
          context,
          initialTime: control.value,
          onTimeSelected: (time) {
            control.value = time;
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MgSizes.md,
          vertical: MgSizes.sm,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            // TODO: 최초 값 기입전에는 error로 인식하지않도록
            color: control.hasErrors
                ? MgColorScheme.subpointRed
                : MgColorScheme.gray8,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child:
                  Text(
                    control.value != null
                        ? _formatTime(control.value)
                        : placeholder,
                  ).md().textColor(
                    control.value != null
                        ? MgColorScheme.text
                        : MgColorScheme.gray5,
                  ),
            ),
            Icon(Icons.access_time, color: MgColorScheme.gray5, size: 20),
          ],
        ),
      ),
    );
  }
}
