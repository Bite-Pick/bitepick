import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/features/auth/data/constant/financial_institution.dart';
import 'package:magambell/src/features/auth/presenation/owner/widgets/bank_list_bottomsheet.dart';
import 'package:magambell/src/widgets/mg_bottomsheet.dart';
import 'package:magambell/src/widgets/mg_reactive_phone_textfield.dart';
import 'package:magambell/src/widgets/mg_reactive_textfield.dart';
import 'package:magambell/src/widgets/mg_select.dart';
import 'package:magambell/src/widgets/mixins/form_section_builder_mixin.dart';
import 'package:reactive_forms/reactive_forms.dart';

class OwnerInfoSection extends StatefulWidget {
  final bool enabled;

  const OwnerInfoSection({
    super.key,
    this.enabled = true,
  });

  @override
  State<OwnerInfoSection> createState() => _OwnerInfoSectionState();
}

class _OwnerInfoSectionState extends State<OwnerInfoSection>
    with FormSectionBuilderMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 3. 대표자 정보
        buildSectionTitle('대표자 정보'),
        MgReactiveTextField(
          formControlName: 'representativeName',
          hintText: '대표자 성함 ',
          enabled: widget.enabled,
        ),
        MgReactivePhoneTextField(
          formControlName: 'representativePhone',
          hintText: '전화번호',
          enabled: widget.enabled,
        ),

        // 4. 사업자 등록 번호
        buildSectionTitle('사업자 등록 번호'),
        MgReactiveTextField(
          formControlName: 'businessNumber',
          hintText: '"-" 제외한 10자리 숫자 ',
          keyboardType: TextInputType.phone,
          enabled: widget.enabled,
        ),

        // 5. 계좌 등록
        buildSectionTitle('계좌 등록'),
        MgSelect<String?>(
          formControlName: 'bankName',
          hintText: '은행 선택',
          bottomSheetTitle: '은행 선택해주세요',
          options: financialInstitutions.values
              .map((e) => MgSelectOption(value: e.shortName, label: e.name))
              .toList(),
          customBottomSheet: _showBankBottomSheet,
          enabled: widget.enabled,
        ),
        Gaps.h8,
        MgReactiveTextField(
          formControlName: 'accountNumber',
          hintText: '"-" 제외한 계좌번호 ',
          keyboardType: TextInputType.phone,
          enabled: widget.enabled,
        ),
      ],
    );
  }

  void _showBankBottomSheet(
    BuildContext context,
    ReactiveFormFieldState<String?, String?> field,
    List<MgSelectOption<String?>> options,
  ) {
    MgBottomsheet.show(context, (context, bottomState) {
      return BankListBottomsheet(field: field);
    }, height: 300);
  }
}
