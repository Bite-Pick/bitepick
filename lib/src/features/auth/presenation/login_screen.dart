import 'package:flutter/material.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("BITE PICK").xxl().bold(),
            Gaps.h24,
            Column(
              spacing: MgSizes.sm,
              children: [
                _buildSocialLoginButton(
                  onPressed: () {},
                  text: "카카오톡으로 로그인",
                  imagePath: R.ASSETS_IMAGES_KAKAO_LOGIN_PNG,
                  backgroundColor: MgColorScheme.primary,
                  textColor: MgColorScheme.text,
                ),
                _buildSocialLoginButton(
                  onPressed: () {},
                  text: "네이버로 로그인",
                  imagePath: R.ASSETS_IMAGES_NAVER_LOGIN_PNG,
                  backgroundColor: const Color(0xFF36AE3C),
                  textColor: MgColorScheme.gray11,
                ),
                _buildSocialLoginButton(
                  onPressed: () {},
                  text: "Apple로 로그인",
                  imagePath: R.ASSETS_IMAGES_APPLE_LOGIN_PNG,
                  backgroundColor: MgColorScheme.gray1,
                  textColor: MgColorScheme.gray11,
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
  }) {
    return MgButton(
      onPressed: onPressed,
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
