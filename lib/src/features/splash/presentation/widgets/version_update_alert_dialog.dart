import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/constants.dart';
import 'package:magambell/src/features/splash/data/repositories/app_version_policy_repository.dart';
import 'package:magambell/src/features/splash/domain/entities/app_version_policy.dart';
import 'package:magambell/src/widgets/mg_alert_dialog.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';
import 'package:url_launcher/url_launcher.dart';

class VersionUpdateAlertDialog extends ConsumerStatefulWidget {
  const VersionUpdateAlertDialog({super.key});

  @override
  ConsumerState<VersionUpdateAlertDialog> createState() => _VersionUpdateAlertDialogState();
}

class _VersionUpdateAlertDialogState extends ConsumerState<VersionUpdateAlertDialog> {
  @override
  void initState() {
   
    super.initState();

    // TODO: api 값 기반으로 최소버전과 현재버전(local)을 비교하여 dialog 띄울지 말지 비교 로직
  }
  @override
  Widget build(BuildContext context) {
    final versionInfo = AppVersionPolicy(
      version: '1.0.0',
      releaseNotes: 'test',
    );
        
    return MgAlertDialog(
      title: "버전 업데이트 안내",
      content: Column(
        children: [
          if (versionInfo.releaseNotes != null) Text(versionInfo.releaseNotes!),
        ],
      ),
      onConfirm: () async {
        final storeUrl = Platform.isAndroid ? androidStoreUrl : iosStoreUrl;
        final uri = Uri.parse(storeUrl);
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      },
    );
  }
}
