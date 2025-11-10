import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/auth/domain/entities/user_role.dart';
import 'package:magambell/src/features/auth/presenation/join_screen.controller.dart';
import 'package:magambell/src/features/auth/presenation/owner/owner_join_info_screen.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class JoinSuccessRoute extends GoRouteData {
  const JoinSuccessRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const JoinSuccessScreen();
  }
}

class JoinSuccessScreen extends ConsumerWidget {
  const JoinSuccessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final joinState = ref.watch(joinControllerProvider);
    final userRole = joinState.userRole;

    return BaseScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          // 성공 아이콘 또는 이미지
          Image.asset(
            R.ASSETS_IMAGES_JOIN_SUCCESS_PNG,
            width: 120,
            height: 120,
          ),
          Gaps.h32,
          Text("회원가입 완료").xxl().bold(),
          Gaps.h16,
          Text("마감벨에 오신 것을 환영합니다\n이제 마감벨의 모든 서비스를 이용하실 수 있어요").md(),
          Spacer(),
          MgButton(
            onPressed: () {
              // Owner인 경우 매장 정보 입력 화면으로, 아니면 홈으로
              if (userRole == UserRole.owner) {
                OwnerJoinInfoRoute().go(context);
              } else {
                context.go('/');
              }
            },
            content: const Text("시작하기"),
          ).primary(),
          Gaps.h32,
        ],
      ).margin(horizontal: MgSizes.xl),
    );
  }
}
