import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/auth/domain/entities/social_auth_result.dart';
import 'package:magambell/src/features/auth/presenation/login_screen.controller.dart';
import 'package:magambell/src/features/auth/presenation/select_user_type_screen.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Controller state 감지
    ref.listen<AsyncValue<SocialAuthResult?>>(loginScreenControllerProvider, (
      previous,
      next,
    ) {
      next.when(
        data: (authResult) {
          // 로그인 성공 시 메인 화면으로 이동
          if (authResult == null) {
            MainRoute().go(context);
          } else {
            // 신규 회원 - 회원가입 화면으로 이동
            SelectUserTypeRoute().push(context);
          }
        },
        error: (error, stack) {
          // 에러 토스트 표시
          context.showErrorBar(content: Text(error.toString()));
        },
        loading: () {},
      );
    });

    final loginState = ref.watch(loginScreenControllerProvider);
    final isLoading = loginState.isLoading;

    return BaseScaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("BITE PICK").xxl().bold(), // TODO: 로고 추가
            Gaps.h24,
            if (isLoading) ...[const CircularProgressIndicator(), Gaps.h24],
            Column(
              spacing: MgSizes.sm,
              children: [
                _buildSocialLoginButton(
                  onPressed: () async {
                    await ref
                        .read(loginScreenControllerProvider.notifier)
                        .signInWithKakao();
                  },
                  text: "카카오톡으로 로그인",
                  imagePath: R.ASSETS_IMAGES_KAKAO_LOGIN_PNG,
                  backgroundColor: MgColorScheme.primary,
                  textColor: MgColorScheme.text,
                  isLoading: isLoading,
                ),
                _buildSocialLoginButton(
                  onPressed: () async => await ref
                      .read(loginScreenControllerProvider.notifier)
                      .signInWithNaver(),
                  text: "네이버로 로그인",
                  imagePath: R.ASSETS_IMAGES_NAVER_LOGIN_PNG,
                  backgroundColor: const Color(0xFF36AE3C),
                  textColor: MgColorScheme.gray11,
                  isLoading: isLoading,
                ),
                _buildSocialLoginButton(
                  onPressed: () async => await ref
                      .read(loginScreenControllerProvider.notifier)
                      .signInWithApple(),
                  text: "Apple로 로그인",
                  imagePath: R.ASSETS_IMAGES_APPLE_LOGIN_PNG,
                  backgroundColor: MgColorScheme.gray1,
                  textColor: MgColorScheme.gray11,
                  isLoading: isLoading,
                ),
              ],
            ),
          ],
        ).margin(horizontal: MgSizes.size48),
      ),
    );
  }

  Widget _buildSocialLoginButton({
    required VoidCallback onPressed,
    required String text,
    required String imagePath,
    required Color backgroundColor,
    required Color textColor,
    required bool isLoading,
  }) {
    return MgButton(
      onPressed: isLoading ? null : onPressed,
      backgroundColor: backgroundColor,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: MgSizes.xl),
          Gaps.w6,
          Text(text).textColor(textColor).sm(),
        ],
      ),
    );
  }
}
