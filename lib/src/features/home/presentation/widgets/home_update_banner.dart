import 'package:flutter/material.dart';
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
  bool _dialogShown = false;

  @override
  void initState() {
    super.initState();
    if (widget.debugStatus != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showUpdateDialog();
      });
    } else {
      _checkForUpdate();
    }
  }

  Future<void> _checkForUpdate() async {
    if (!ShorebirdManager.isAvailable) return;

    final status = await ShorebirdManager.checkForUpdate();
    if (status == UpdateStatus.restartRequired || status == UpdateStatus.outdated) {
      if (mounted) _showUpdateDialog();
    }
  }

  void _showUpdateDialog() {
    if (!mounted || _dialogShown) return;
    _dialogShown = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: MgAlertDialog(
          title: '업데이트 준비 완료',
          content: const Text(
            '새 버전이 준비됐어요.\n앱을 완전히 닫았다가 다시 열어주세요.',
            textAlign: TextAlign.center,
          ),
          actions: const SizedBox.shrink(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
