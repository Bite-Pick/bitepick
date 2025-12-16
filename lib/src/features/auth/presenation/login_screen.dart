import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/network/api_exception.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/auth/domain/entities/social_auth_result.dart';
import 'package:magambell/src/features/auth/presenation/join_basic_info_screen.controller.dart';
import 'package:magambell/src/features/auth/presenation/login_screen.controller.dart';
import 'package:magambell/src/features/auth/presenation/select_user_type_screen.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    // Controller state 감지
    ref.listen<AsyncValue<SocialAuthResult?>>(loginScreenControllerProvider, (
      previous,
      next,
    ) {
      // 초기 상태(previous == null)는 무시
      if (previous == null) return;

      next.when(
        loading: () {},
        data: (authResult) {
          if (authResult == null) {
            // 기존 회원 - 로그인 성공 → DefaultRoute의 redirect 로직을 타도록
            DefaultRoute().go(context);
          } else {
            // 신규 회원 - 회원가입 화면으로 이동
            ref
                .read(joinBasicInfoScreenControllerProvider.notifier)
                .setSocialLoginInfo(
                  providerType: authResult.providerType,
                  socialToken: authResult.authCode,
                );

            SelectUserTypeRoute().push(context);
          }
        },
        error: (error, stack) {
          // TODO: 로직 필요없는지 다시 확인하고 지우기
          final message = switch (error) {
            DuplicateNicknameException(message: final msg) => msg,
            AuthenticationException(message: final msg) => msg,
            _ => '오류가 발생했습니다. 문의해주세요',
          };

          _handleError(message, rawError: error);
        },
      );
    });

    final loginState = ref.watch(loginScreenControllerProvider);
    final isLoading = loginState.isLoading;

    return BaseScaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BaseSvgIcon.homeLogo(size: MgSizes.xxxxl),
            Gaps.h24,
            if (isLoading) ...[const CircularProgressIndicator(), Gaps.h24],
            // MgButton(
            //   content: Text("dd"),
            //   onPressed: () {
            //     SelectUserTypeRoute().go(context);
            //   },
            // ).gray(),
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
                  textColor: MgColorScheme.gray1,
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
                if (Platform.isIOS)
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
    // return MgTooltip(
    //   disabled: true, // TODO: 최근 로그인 툴팁 활성화
    //   item: Text("최근에 로그인했어요").xs().white(),
    //   offset: Offset(100.w, 0),
    //   defaultVisible: true,
    //   child:
    // );
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

  void _handleError(String message, {Object? rawError}) {
    talker.error(rawError ?? message);

    final context = GlobalVariable.navigatorKey.currentContext;
    if (context != null && context.mounted) {
      ToastPresentor.error(context, message);
    }
  }

  // TODO: 최근 로그인 툴팁 활성화
  Future<String> getLastLoginProvider() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('lastLoginProvider') ?? '';
  }
}
