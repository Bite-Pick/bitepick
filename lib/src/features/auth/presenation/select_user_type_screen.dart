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
import 'package:magambell/src/features/auth/presenation/join_basic_info_screen.dart';
import 'package:magambell/src/features/auth/presenation/join_basic_info_screen.controller.dart';
import 'package:magambell/src/widgets/agreement_section.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_bottomsheet.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';

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
      canSwipeBack: false,
      appBar: BaseAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "안녕하세요!\n어떤 사용자로 이용하시나요?",
          ).xl().bold().margin(top: MgSizes.size32, bottom: MgSizes.size64),
          Row(
            children: [
              Expanded(
                child: _buildUserTypeButton(
                  imagePath: R.ASSETS_IMAGES_CHARACTER_USER_PNG,
                  userRole: UserRole.customer,
                  isSelected: selectedUserRole == UserRole.customer,
                  onPressed: () {
                    setState(() => selectedUserRole = UserRole.customer);
                  },
                ),
              ),
              Gaps.w(11),
              Expanded(
                child: _buildUserTypeButton(
                  imagePath: R.ASSETS_IMAGES_CHARACTER_OWNER_PNG,
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
                ToastPresentor.error(context, "사용자 유형을 선택해 주세요.");
                return;
              }
              _showAgreementBottomSheet();
            },
            content: const Text("다음"),
            disabled: selectedUserRole == null,
          ).primary(),
          Gaps.h16,
        ],
      ).margin(horizontal: MgSizes.md),
    );
  }

  void _showAgreementBottomSheet() {
    MgBottomsheet.show(context, (context, bottomState) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("이용 약관").md().bold().margin(bottom: MgSizes.md),
          JoinAgreementSection(
            allAgreeText: '약관 전체 동의',
            items: [
              AgreementItem(text: '(필수) 개인정보 처리방침', link: PRIAVCY_POLICY),
              selectedUserRole == UserRole.customer
                  ? AgreementItem(
                      text: '(필수) 서비스 이용약관 (사용자용)',
                      link: GUEST_SERVICE_TERM,
                    )
                  : AgreementItem(
                      text: '(필수) 서비스 이용약관 (공급자용)',
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
                ToastPresentor.error(context, "모든 약관에 동의해 주세요.");
                return;
              }

              // UserRole 저장
              ref
                  .read(joinBasicInfoScreenControllerProvider.notifier)
                  .setUserRole(selectedUserRole!);

              context.pop();

              JoinBasicInfoRoute().push(context);
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
                  Image.asset(imagePath),
                  Gaps.h(28),
                  Text(userRole.label).md().bold(),
                ],
              )
              .padding(horizontal: MgSizes.size28, top: 42, bottom: 21)
              .decorated(
                borderRadius: BorderRadius.circular(MgRadius.md),
                color: isSelected
                    ? MgColorScheme.primaryLightest
                    : MgColorScheme.gray10,
                border: isSelected
                    ? Border.all(color: MgColorScheme.primary, width: 1)
                    : null,
              ),
    );
  }
}
