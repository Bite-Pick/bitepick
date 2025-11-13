import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/auth/data/constant/financial_institution.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_bottomsheet.dart';
import 'package:reactive_forms/reactive_forms.dart';

class BankListBottomsheet extends StatelessWidget {
  const BankListBottomsheet({super.key, required this.field});
  final ReactiveFormFieldState<String?, String?> field;
  @override
  Widget build(BuildContext context) {
    return MgBottomsheet(
      Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('은행을 선택해주세요')
                  .lg()
                  .bold()
                  .margin(top: MgSizes.md, bottom: MgSizes.lg)
                  .constrained(width: double.infinity),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: MgSizes.md,
                    runSpacing: MgSizes.md,
                    children: financialInstitutions.entries.map((entry) {
                      final bank = entry.value;
                      final isSelected = field.value == bank.shortName;

                      return GestureDetector(
                        onTap: () {
                          field.didChange(bank.shortName);
                          context.pop();
                        },
                        child: Container(
                          width:
                              (MediaQuery.of(context).size.width -
                                  MgSizes.xl * 2 -
                                  MgSizes.md * 2) /
                              3,
                          padding: const EdgeInsets.all(MgSizes.sm),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(MgRadius.md),
                            border: isSelected
                                ? Border.all(
                                    color: MgColorScheme.primary,
                                    width: 2,
                                  )
                                : Border.all(
                                    color: MgColorScheme.gray8,
                                    width: 1,
                                  ),
                            color: isSelected
                                ? MgColorScheme.lightest
                                : MgColorScheme.white,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // TODO: 은행 아이콘 추가 시 여기에 표시
                              // Icon(Icons.account_balance, size: 32, color: MgColorScheme.gray1),
                              BaseSvgIcon(
                                assetName: 'bank/${bank.icon}.svg',
                                hasColorFilter: false,
                              ),
                              Gaps.h8,
                              Text(
                                bank.name,
                              ).xs().center().textColor(MgColorScheme.gray1),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          )
          .margin(horizontal: MgSizes.xl)
          .constrained(height: MediaQuery.sizeOf(context).height * 1 / 2),
    );
  }
}
