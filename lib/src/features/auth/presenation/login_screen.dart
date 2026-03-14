import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  String _lastProvider = '';

  @override
  void initState() {
    super.initState();
    _loadLastLoginProvider();
  }

  Future<void> _loadLastLoginProvider() async {
    final provider = await getLastLoginProvider();
    if (mounted) {
      setState(() => _lastProvider = provider);
    }
  }

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
            _ => '', // TODO: 플레이 스토어 심사로 임시 삭제
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
            Image.asset(R.ASSETS_LOGO_LOGO_LOGIN_PNG, width: 128.w),

            Gaps.h52,
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
                  textColor: MgColorScheme.gray1,
                  isLoading: isLoading,
                  providerKey: 'KAKAO',
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
                  providerKey: 'NAVER',
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
                    providerKey: 'APPLE',
                  ),
                MgButton(
                  onPressed: () => MainRoute().go(context),
                  content: Text("로그인 없이 둘러보기").textGray(),
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
    required String providerKey,
  }) {
    final isLastUsed = _lastProvider == providerKey;
    final button = MgButton(
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

    if (!isLastUsed) return button;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        button,
        Positioned(
          top: -10,
          right: 12,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: MgColorScheme.gray2,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text("최근 로그인").xs().white(),
          ),
        ),
      ],
    );
  }

  void _handleError(String message, {Object? rawError}) {
    talker.error(rawError ?? message);

    final context = GlobalVariable.navigatorKey.currentContext;
    if (context != null && context.mounted && message.isNotEmpty) {
      ToastPresentor.error(context, message);
    }
  }

  Future<String> getLastLoginProvider() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('lastLoginProvider') ?? '';
    // 구버전 한글값 마이그레이션
    return switch (value) {
      '카카오' => 'KAKAO',
      '네이버' => 'NAVER',
      '애플' => 'APPLE',
      _ => value,
    };
  }
}
