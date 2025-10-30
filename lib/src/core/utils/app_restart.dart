import 'package:restart_app/restart_app.dart';

/// 앱 재시작 유틸리티
class AppRestart {
  /// 앱을 재시작합니다
  static Future<void> restart() async {
    await Restart.restartApp();
  }
}
