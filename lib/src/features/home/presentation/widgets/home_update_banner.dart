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
    // outdated 상태는 main.dart에서 백그라운드 다운로드 중 — 다음 실행 시 restartRequired로 처리됨
    if (status == UpdateStatus.restartRequired) {
      if (mounted) _showUpdateDialog(status!);
    }
  }

  void _showUpdateDialog(UpdateStatus status) {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => MgAlertDialog.basic(
        title: '업데이트 준비 완료',
        content: const Text(
          '새 버전이 준비됐어요.\n지금 앱을 종료한 후 다시 열어주세요.',
          textAlign: TextAlign.center,
        ),
        confirmText: '지금 종료',
        cancelText: '나중에',
        hasCancel: true,
        onConfirm: () => AppRestart.restart(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
