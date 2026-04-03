import 'dart:io';

import 'package:flutter/material.dart';
import 'package:magambell/src/constants/constants.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/splash/domain/entities/app_version_policy.dart';
import 'package:magambell/src/widgets/mg_alert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class VersionUpdateAlertDialog extends StatelessWidget {
  const VersionUpdateAlertDialog(this.appVersionPolicy, {super.key});
  final AppVersionPolicy appVersionPolicy;

  @override
  Widget build(BuildContext context) {
    return MgAlertDialog.basic(
      title: "업데이트 알림",
      content: Text(
        appVersionPolicy.releaseNotes ??
            "더 빠르고 안정적인 바이트픽 이용을 위해\n새 버전으로 업데이트해 주세요!",
      ).md(),
      hasCancel: false,
      confirmText: '스토어로 이동하기',
      onConfirm: () async {
        final storeUrl = Platform.isAndroid ? androidStoreUrl : iosStoreUrl;
        final uri = Uri.parse(storeUrl);
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      },
    );
  }
}
