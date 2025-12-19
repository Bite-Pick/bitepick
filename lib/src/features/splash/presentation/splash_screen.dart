import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/splash/presentation/widgets/version_update_alert_dialog.dart';
import 'package:magambell/src/widgets/mg_alert_dialog.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 강제업데이트 dialog
    showDialog(
      context: context,
      builder: (context) {
        return VersionUpdateAlertDialog();
      },
    );
    Future.delayed(const Duration(seconds: 2), () {
      DefaultRoute().go(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MgColorScheme.primary,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/logo/logo_text.svg', width: 168.w),
                Gaps.h4,
                Text("오늘의 한 입을 PICK! 하다").medium(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 70,
            right: 48,
            child: Image.asset(R.ASSETS_LOGO_LOGO_SPLASH_PNG, width: 256.w),
          ),
        ],
      ),
    );
  }
}
