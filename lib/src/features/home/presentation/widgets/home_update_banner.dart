import 'package:flutter/material.dart';
import 'package:magambell/src/core/utils/app_restart.dart';
import 'package:magambell/src/core/utils/shorebird_manager.dart';
import 'package:magambell/src/widgets/mg_alert_dialog.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

/// 홈 화면 업데이트 감지 및 다이얼로그 표시 위젯
class HomeUpdateBanner extends StatefulWidget {
  const HomeUpdateBanner({super.key, this.debugStatus});

  /// 디버그용: 특정 상태를 강제로 주입 (시뮬레이터에서 UI 확인용)
  final UpdateStatus? debugStatus;

  @override
  State<HomeUpdateBanner> createState() => _HomeUpdateBannerState();
}

class _HomeUpdateBannerState extends State<HomeUpdateBanner> {
  @override
  void initState() {
    super.initState();
    if (widget.debugStatus != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showUpdateDialog(widget.debugStatus!);
      });
    } else {
      _checkForUpdate();
    }
  }

  Future<void> _checkForUpdate() async {
    if (!ShorebirdManager.isAvailable) return;

    final status = await ShorebirdManager.checkForUpdate();
    if (status == UpdateStatus.outdated || status == UpdateStatus.restartRequired) {
      if (mounted) _showUpdateDialog(status!);
    }
  }

  void _showUpdateDialog(UpdateStatus status) {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => MgAlertDialog.basic(
        title: '새로운 업데이트',
        content: const Text('앱을 재시작하면 새 버전이 적용됩니다.', textAlign: TextAlign.center),
        confirmText: '지금 재시작',
        hasCancel: false,
        onConfirm: () => AppRestart.restart(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
