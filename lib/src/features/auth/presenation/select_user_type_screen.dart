import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/constants.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/auth/domain/entities/user_role.dart';
import 'package:magambell/src/features/auth/presenation/owner/owner_join_info_screen.dart';
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
            onPressed: () {
              if (selectedUserRole == null) {
                context.showFlash(
                  duration: const Duration(milliseconds: 2000),
                  builder: (context, controller) {
                    return FlashBar(
                      controller: controller,
                      content: Text("사용자 유형을 선택해 주세요."),
                    );
                  },
                );
                return;
              }
              _showAgreementBottomSheet();
            },
            content: const Text("다음"),
          ).primary(),
        ],
      ).margin(horizontal: MgSizes.xl),
    );
  }

  void _showAgreementBottomSheet() {
    MgBottomsheet.show(context, (context, bottomState) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("이용 약관").md().bold().margin(vertical: MgSizes.md),
          AgreementSection(
            allAgreeText: '전체 동의',
            items: [
              AgreementItem(text: '개인정보 수집 및 이용 동의 (필수)', link: PRIAVCY_POLICY),
              selectedUserRole == UserRole.customer
                  ? AgreementItem(
                      text: '이용약관(일반 회원용)',
                      link: GUEST_SERVICE_TERM,
                    )
                  : AgreementItem(
                      text: '이용약관(공급자 회원용)',
                      link: OWNER_SERVICE_TERM,
                    ),
            ],
            onAllAgreedChanged: (allAgreed) {
              bottomState(() => _allAgreed = allAgreed);
            },
          ),
          Gaps.h32,
          MgButton(
            onPressed: () {
              if (!_allAgreed) {
                // TODO: 컴포넌트 분리
                context.showFlash(
                  duration: const Duration(milliseconds: 1000),
                  builder: (context, controller) {
                    return FlashBar(
                      controller: controller,
                      content: Text("모든 약관에 동의해 주세요."),
                    );
                  },
                );
                return;
              }
              if (selectedUserRole == UserRole.owner) {
                OwnerJoinInfoRoute().push(context);
              }
            },
            content: const Text("확인"),
          ).primary(),
        ],
      ).padding(all: MgSizes.xl);
    }, height: 400.h);
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
