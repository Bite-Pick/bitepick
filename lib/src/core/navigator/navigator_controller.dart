import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigator_controller.freezed.dart';
part 'navigator_controller.g.dart';

@freezed
class MgDefaultNavigatorState with _$MgDefaultNavigatorState {
  const factory MgDefaultNavigatorState({
    @Default(0) int tabIndex,
  }) = _MgDefaultNavigatorState;
}

@riverpod
class NavigatorController extends _$NavigatorController {
  @override
  MgDefaultNavigatorState build() {
    return const MgDefaultNavigatorState();
  }

  void changeTabIndex(int index) {
    state = state.copyWith(tabIndex: index);
  }
}
