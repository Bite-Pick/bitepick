import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';

class GlobalErrorHandler {
  factory GlobalErrorHandler() => _instance;
  GlobalErrorHandler._();
  static final GlobalErrorHandler _instance = GlobalErrorHandler._();

  Future<void> initialize({
    required FutureOr<void> Function() appRunner,
  }) async {
    await appRunner();
  }

  void onErrorDetails(FlutterErrorDetails details) {
    if (!kReleaseMode) {
      // 로컬 모드에서는 단순히 콘솔에 출력합니다.
      FlutterError.dumpErrorToConsole(details);
    }

    // Talker에 에러 기록
    talker.error(
      details.exception,
      details,
      details.stack ?? StackTrace.current,
    );
  }

  Future<void> onError(Object error, StackTrace stack) async {
    talker.error('GLOBAL ERROR CATCH', error, stack);
  }
}
