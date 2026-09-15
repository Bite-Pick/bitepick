import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/auth/domain/entities/signup_referral_source.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_bottomsheet.dart';
import 'package:magambell/src/widgets/mg_textfield.dart';

/// 가입 기본정보 화면의 "가입 경로" 선택 필드.
/// [MgSelect]와 동일한 형태(바텀시트 단일 선택)를 따르되, 이 화면이
/// reactive_forms를 쓰지 않아 plain callback 기반으로 구현한다.
class JoinReferralSourceField extends StatelessWidget {
  const JoinReferralSourceField({
    super.key,
    required this.value,
    required this.onChanged,
    this.error,
    this.otherController,
    this.otherError,
  });

  final SignupReferralSource? value;
  final ValueChanged<SignupReferralSource> onChanged;
  final String? error;
  final TextEditingController? otherController;
  final String? otherError;

  @override
  Widget build(BuildContext context) {
    final hasError = error != null && error!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('가입 경로').bold().md().padding(bottom: MgSizes.size8),
        GestureDetector(
          onTap: () => _showBottomSheet(context),
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: MgSizes.sm),
            decoration: BoxDecoration(
              color: MgColorScheme.gray11,
              borderRadius: BorderRadius.circular(MgSizes.size10),
              border: Border.all(
                color: hasError ? MgColorScheme.systemError : MgColorScheme.gray7,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(value?.label ?? '가입 경로 선택').md().textColor(
                    value != null ? MgColorScheme.gray1 : MgColorScheme.gray4,
                  ),
                ),
                BaseSvgIcon.down(size: 20),
              ],
            ),
          ),
        ),
        if (hasError) ...[Gaps.h8, Text(error!).sm().red()],
        if (value == SignupReferralSource.etc) ...[
          Gaps.h12,
          MgTextField(
            controller: otherController,
            hintText: '직접 입력',
            prefixIcon: const SizedBox.shrink(),
            error: otherError,
            reserveErrorSpace: false,
          ),
        ],
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    MgBottomsheet.show(context, (context, bottomState) {
      return MgBottomsheet(
        SizedBox(
          height: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '가입 경로를 선택해주세요',
              ).lg().bold().margin(vertical: MgSizes.md, horizontal: MgSizes.md),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: SignupReferralSource.values
                        .map(
                          (option) => _buildItem(
                            context,
                            option,
                            isSelected: value == option,
                          ),
                        )
                        .toList(),
                  ).margin(horizontal: MgSizes.md, bottom: MgSizes.md),
                ),
              ),
            ],
          ),
        ),
      );
    }, height: 400);
  }

  Widget _buildItem(
    BuildContext context,
    SignupReferralSource option, {
    bool isSelected = false,
  }) {
    return GestureDetector(
      onTap: () {
        onChanged(option);
        Navigator.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.all(MgSizes.md),
        margin: const EdgeInsets.only(bottom: MgSizes.xs),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MgRadius.md),
          border: isSelected
              ? Border.all(color: MgColorScheme.gray4, width: 1)
              : null,
          color: isSelected ? MgColorScheme.gray10 : null,
        ),
        child: Row(
          children: [
            Expanded(child: Text(option.label).md()),
            if (isSelected) BaseSvgIcon.check(size: 20),
          ],
        ),
      ),
    );
  }
}
