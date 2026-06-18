import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/auth/domain/entities/user_role.dart';
import 'package:magambell/src/features/user/providers/user.provider.dart';
import 'package:magambell/src/features/auth/presenation/join_basic_info_screen.controller.dart';
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
    final joinState = ref.watch(joinBasicInfoScreenControllerProvider);
    final userRole = joinState.userRole;

    return BaseScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          // 성공 아이콘 또는 이미지
          Lottie.asset(R.ASSETS_LOTTIE_SUCCESS_JSON, repeat: false),
          Text("회원가입이 완료되었어요!").xl().bold(),
          userRole == UserRole.owner
              ? Text("이제 매장등록을 시작할게요").xl().bold()
              : Text("지역 설정이후에 서비스를 이용할 수 있어요"),
          Spacer(),
          MgButton(
            onPressed: () async {
              await ref.read(userStateProvider.notifier).refresh();
              if (!context.mounted) return;
              // Owner인 경우 매장 정보 입력 화면으로, 아니면 온보딩으로
              if (userRole == UserRole.owner) {
                OwnerJoinInfoRoute().go(context);
              } else {
                OnboardingRoute().go(context);
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
