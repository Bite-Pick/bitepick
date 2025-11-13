import 'package:magambell/src/core/utils/visual_logger_visibility_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'visual_logger_provider.g.dart';

@riverpod
class VisualLoggerVisibility extends _$VisualLoggerVisibility {
  final _manager = VisualLoggerVisibilityManager();

  @override
  Future<bool> build() async {
    return await _manager.isVisible();
  }

  Future<void> setVisible(bool visible) async {
    await _manager.setVisible(visible);
    state = AsyncValue.data(visible);
  }

  Future<void> toggle() async {
    final current = state.value ?? false;
    await setVisible(!current);
  }
}
