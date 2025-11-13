import 'package:magambell/src/core/utils/shared_preference_store.dart';

/// Visual Logger 표시 여부를 관리하는 Singleton 클래스
class VisualLoggerVisibilityManager {
  factory VisualLoggerVisibilityManager() => _instance;

  VisualLoggerVisibilityManager._private();

  static final VisualLoggerVisibilityManager _instance =
      VisualLoggerVisibilityManager._private();

  final _store = SharedPreferenceStore();

  /// Visual Logger가 표시되는지 확인
  Future<bool> isVisible() async {
    return await _store.getShowVisualLogger();
  }

  /// Visual Logger 표시 여부 설정
  Future<void> setVisible(bool visible) async {
    await _store.setShowVisualLogger(visible);
  }

  /// Visual Logger 표시 상태 토글
  Future<void> toggle() async {
    final current = await isVisible();
    await setVisible(!current);
  }
}
