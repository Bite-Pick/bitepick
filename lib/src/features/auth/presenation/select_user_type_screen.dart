import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/auth/domain/entities/user_role.dart';
import 'package:magambell/src/widgets/agreement_section.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_bottomsheet.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class SelectUserTypeRoute extends GoRouteData {
  const SelectUserTypeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SelectUserTypeScreen();
  }
}

class SelectUserTypeScreen extends ConsumerStatefulWidget {
  const SelectUserTypeScreen({super.key});

  @override
  ConsumerState<SelectUserTypeScreen> createState() =>
      _SelectUserTypeScreenState();
}

class _SelectUserTypeScreenState extends ConsumerState<SelectUserTypeScreen> {
  UserRole? selectedUserRole;
  bool _allAgreed = false;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "환영해요!\n사용자 유형을 선택해주세요",
          ).xl().bold().margin(top: MgSizes.size32, bottom: MgSizes.size64),
          Row(
            children: [
              Expanded(
                child: _buildUserTypeButton(
                  imagePath: R.ASSETS_IMAGES_USER_PNG,
                  userRole: UserRole.customer,
                  isSelected: selectedUserRole == UserRole.customer,
                  onPressed: () {
                    setState(() => selectedUserRole = UserRole.customer);
                  },
                ),
              ),
              Gaps.w12,
              Expanded(
                child: _buildUserTypeButton(
                  imagePath: R.ASSETS_IMAGES_OWNER_PNG,
                  userRole: UserRole.owner,
                  isSelected: selectedUserRole == UserRole.owner,
                  onPressed: () {
                    setState(() => selectedUserRole = UserRole.owner);
                  },
                ),
              ),
            ],
          ),
          Spacer(),
          MgButton(
            onPressed: selectedUserRole != null
                ? _showAgreementBottomSheet
                : null,
            content: const Text("다음"),
          ).primary(),
        ],
      ).margin(horizontal: MgSizes.xl),
    );
  }

  void _showAgreementBottomSheet() {
    MgBottomsheet.show(context, (context, bottomState) {
      return Padding(
        padding: const EdgeInsets.all(MgSizes.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("약관 동의").lg().bold(),
            Gaps.h24,
            AgreementSection(
              onAllAgreedChanged: (allAgreed) {
                bottomState(() {
                  _allAgreed = allAgreed;
                });
              },
            ),
            Gaps.h24,
            MgButton(
              onPressed: _allAgreed
                  ? () {
                      Navigator.pop(context);
                      // TODO: 회원가입 API 호출
                      print('회원가입: ${selectedUserRole?.value}');
                    }
                  : null,
              content: const Text("동의하고 시작하기"),
            ).primary(),
          ],
        ),
      );
    }, height: 500);
  }

  Widget _buildUserTypeButton({
    required String imagePath,
    required UserRole userRole,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child:
          Column(
                children: [
                  Image.asset(
                    imagePath,
                  ).margin(top: MgSizes.size16, bottom: MgSizes.size20),
                  Text(userRole.label).md().bold(),
                ],
              )
              .padding(horizontal: MgSizes.size28, vertical: MgSizes.md)
              .decorated(
                borderRadius: BorderRadius.circular(MgRadius.md),
                color: isSelected
                    ? MgColorScheme.lightest
                    : MgColorScheme.gray10,
              ),
    );
  }
}
