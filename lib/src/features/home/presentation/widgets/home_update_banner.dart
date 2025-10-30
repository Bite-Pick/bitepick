import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/utils/app_restart.dart';
import 'package:magambell/src/core/utils/shorebird_manager.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

/// 홈 화면 업데이트 배너
class HomeUpdateBanner extends StatefulWidget {
  const HomeUpdateBanner({super.key});

  @override
  State<HomeUpdateBanner> createState() => _HomeUpdateBannerState();
}

class _HomeUpdateBannerState extends State<HomeUpdateBanner> {
  UpdateStatus? _updateStatus;
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();
    _checkForUpdate();
  }

  Future<void> _checkForUpdate() async {
    if (!ShorebirdManager.isAvailable) return;

    final status = await ShorebirdManager.checkForUpdate();
    if (mounted) {
      setState(() {
        _updateStatus = status;
      });
    }
  }

  Future<void> _downloadAndRestart() async {
    setState(() {
      _isDownloading = true;
    });

    try {
      final success = await ShorebirdManager.downloadUpdate();
      if (success && mounted) {
        // 다운로드 성공 후 재시작
        await AppRestart.restart();
      }
    } catch (e) {
      print('업데이트 실패: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 업데이트가 없거나 이미 최신 버전이면 배너를 표시하지 않음
    if (_updateStatus != UpdateStatus.outdated) {
      return const SizedBox.shrink();
    }

    final Widget container = Container(
      decoration: BoxDecoration(
        color: MgColorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                Icons.update,
                color: MgColorScheme.primary,
                size: 24,
              ),
              Gaps.w8,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('새로운 업데이트').md().bold(),
                    Gaps.h4,
                    Text('더 나은 서비스를 위해 업데이트가 준비되었습니다.')
                        .sm()
                        .textGray(),
                  ],
                ),
              ),
            ],
          ),
          Gaps.h12,
          MgButton(
            content: _isDownloading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                      Gaps.w8,
                      Text('다운로드 중...').sm().white(),
                    ],
                  )
                : Text('지금 업데이트').sm().white(),
            onPressed: _downloadAndRestart,
            disabled: _isDownloading,
          ),
        ],
      ).margin(all: MgSizes.md),
    );

    return container.margin(horizontal: MgSizes.md, bottom: MgSizes.md);
  }
}
