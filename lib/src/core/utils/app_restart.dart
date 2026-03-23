import 'dart:io';

/// 앱 종료 유틸리티 (Shorebird 패치 적용을 위해 프로세스를 완전히 종료)
class AppRestart {
  /// 앱 프로세스를 종료합니다.
  /// 사용자가 앱 아이콘으로 재오픈하면 새 프로세스가 시작되어 Shorebird 패치가 적용됩니다.
  static void restart() {
    exit(0);
  }
}
