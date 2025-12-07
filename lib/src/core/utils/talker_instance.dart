import 'package:flutter/foundation.dart';
import 'package:magambell/src/core/config/environment.dart';
import 'package:talker_flutter/talker_flutter.dart';

class MgTalker {
  MgTalker._();

  static late Talker _instance;
  static Talker get instance => _instance;

  static void init() {
    // Debug 모드: 무조건 활성화
    // Dev 환경: 항상 활성화
    // Prod 환경: Release 모드가 아닐 때만 활성화
    final shouldEnableLog =
        kDebugMode ||
        Environment.instance.isDev ||
        (Environment.instance.isProd );

    _instance = TalkerFlutter.init(
      settings: TalkerSettings(
        useConsoleLogs: false, // Console 로그는 중복이므로 비활성화
        enabled: shouldEnableLog, // 조건에 따라 로그 활성화/비활성화
      ),
      logger: TalkerLogger(
        settings: TalkerLoggerSettings(enableColors: !kReleaseMode),
      ),
    );

    // debugPrint를 Talker로 리다이렉트 (로그가 활성화된 경우에만)
    if (shouldEnableLog) {
      debugPrint = (String? message, {int? wrapWidth}) {
        _instance.debug(message ?? '');
      };
    }

    // developer.log를 Talker로 리다이렉트
    // Note: 이미 사용 중인 log 호출들을 위해
  }

  /// Talker가 활성화되어 있는지 확인
  static bool get isEnabled {
    return kDebugMode ||
           Environment.instance.isDev ||
           (Environment.instance.isProd);
  }
}

/// Global Talker instance for logging
Talker get talker => MgTalker.instance;
