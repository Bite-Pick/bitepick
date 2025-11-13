import 'dart:io';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

/// Shorebird 코드 푸시 관리 클래스
class ShorebirdManager {
  static final _updater = ShorebirdUpdater();

  /// Shorebird가 사용 가능한지 확인
  static bool get isAvailable {
    return _updater.isAvailable;
  }

  /// 현재 패치 번호 조회
  static Future<int?> getCurrentPatchNumber() async {
    try {
      final patch = await _updater.readCurrentPatch();
      return patch?.number;
    } catch (e) {
      talker.debug('🐦 [Shorebird] 패치 번호 조회 실패: $e');
      return null;
    }
  }

  /// 업데이트 상태 확인
  static Future<UpdateStatus?> checkForUpdate() async {
    try {
      final status = await _updater.checkForUpdate();
      talker.debug('🐦 [Shorebird] 업데이트 상태: $status');
      return status;
    } catch (e) {
      talker.debug('🐦 [Shorebird] 업데이트 상태 확인 실패: $e');
      return null;
    }
  }

  /// 업데이트 다운로드 및 적용
  static Future<bool> downloadUpdate() async {
    try {
      talker.debug('🐦 [Shorebird] 업데이트 다운로드 시작...');
      await _updater.update();
      talker.debug('🐦 [Shorebird] 업데이트 다운로드 완료');
      return true;
    } catch (e) {
      talker.debug('🐦 [Shorebird] 업데이트 다운로드 실패: $e');
      return false;
    }
  }

  /// 디버그 정보 출력
  static Future<Map<String, dynamic>> getDebugInfo() async {
    final available = isAvailable;
    final currentPatch = await getCurrentPatchNumber();
    final updateStatus = await checkForUpdate();

    return {
      'isAvailable': available,
      'currentPatchNumber': currentPatch,
      'updateStatus': updateStatus?.toString(),
      'platform': Platform.operatingSystem,
    };
  }

  /// 앱 시작 시 자동 업데이트 확인 및 다운로드
  static Future<void> checkAndDownloadUpdate() async {
    try {
      if (!isAvailable) {
        talker.debug('🐦 [Shorebird] Shorebird를 사용할 수 없습니다.');
        return;
      }

      final status = await checkForUpdate();

      if (status == UpdateStatus.outdated) {
        talker.debug('🐦 [Shorebird] 새로운 업데이트가 있습니다. 다운로드를 시작합니다...');
        final success = await downloadUpdate();
        if (success) {
          talker.debug('🐦 [Shorebird] 업데이트가 준비되었습니다. 다음 앱 재시작 시 적용됩니다.');
        }
      } else if (status == UpdateStatus.upToDate) {
        talker.debug('🐦 [Shorebird] 앱이 최신 상태입니다.');
      } else if (status == UpdateStatus.restartRequired) {
        talker.debug('🐦 [Shorebird] 업데이트가 다운로드되었습니다. 앱을 재시작해주세요.');
      }
    } catch (e) {
      talker.debug('🐦 [Shorebird] 자동 업데이트 확인 실패: $e');
    }
  }
}
