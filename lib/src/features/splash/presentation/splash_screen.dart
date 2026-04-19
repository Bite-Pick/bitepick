import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/splash/data/repositories/app_version_policy_repository.dart';
import 'package:magambell/src/features/splash/domain/entities/app_version_policy.dart';
import 'package:magambell/src/features/notification/domain/push_notification.dart';
import 'package:magambell/src/features/splash/presentation/widgets/version_update_alert_dialog.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final results = await Future.wait([
        checkAppVersion(),
        Future.delayed(const Duration(seconds: 1)),
      ]);
      if (!mounted) return;
      if (results[0] as bool) {
        DefaultRoute().go(context);
        PushNotification.navigatePendingMessage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
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
      ),
    );
  }

  Future<bool> checkAppVersion() async {
    final AppVersionPolicy? appVersion;
    try {
      appVersion = await ref.read(appVersionPolicyProvider.future);
    } catch (_) {
      // 버전 체크 실패 시 앱 진입 허용 (공개 API 오류로 앱이 멈추면 안 됨)
      return true;
    }
    if (appVersion == null) return true;
    final policy = appVersion;

    final isSupportedVersion = await _isUpdateRequired(policy.version);
    if (!isSupportedVersion) {
      if (!mounted) return false;
      await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return VersionUpdateAlertDialog(policy);
        },
      );
      return false;
    }

    return true;
  }

  Future<bool> _isUpdateRequired(String appVersion) async {
    List<int> parseVersion(String target) {
      final targets = target.split('.');
      return targets.map((e) => int.parse(e)).toList();
    }

    final currentAppVersion = (await PackageInfo.fromPlatform()).version;
    final currentAppVersionParts = parseVersion(currentAppVersion);
    final minimumAppVersionParts = parseVersion(appVersion);

    for (var i = 0; i < 3; i++) {
      if (currentAppVersionParts[i] < minimumAppVersionParts[i]) return false;
      if (currentAppVersionParts[i] > minimumAppVersionParts[i]) return true;
    }
    return true;
  }
}
