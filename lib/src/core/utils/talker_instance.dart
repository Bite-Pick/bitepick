
import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';

class MgTalker {
  MgTalker._();

  static late Talker _instance;
  static Talker get instance => _instance;

  static void init() {
    _instance = TalkerFlutter.init(
      settings: TalkerSettings(
        useConsoleLogs: false, // Console 로그는 중복이므로 비활성화
      ),
    );

    // debugPrint를 Talker로 리다이렉트
    debugPrint = (String? message, {int? wrapWidth}) {
      _instance.debug(message ?? '');
    };

    // developer.log를 Talker로 리다이렉트
    // Note: 이미 사용 중인 log 호출들을 위해
  }
}

/// Global Talker instance for logging
Talker get talker => MgTalker.instance;
