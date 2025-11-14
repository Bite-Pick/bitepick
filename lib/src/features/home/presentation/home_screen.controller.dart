import 'package:magambell/src/features/store/domain/sort_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_screen.controller.g.dart';

class HomeScreenState {
  final bool onlyAvailable;
  final SortType sortType;

  const HomeScreenState({
    this.onlyAvailable = true,
    this.sortType = SortType.recentDesc,
  });

  HomeScreenState copyWith({
    bool? onlyAvailable,
    SortType? sortType,
  }) {
    return HomeScreenState(
      onlyAvailable: onlyAvailable ?? this.onlyAvailable,
      sortType: sortType ?? this.sortType,
    );
  }
}

@riverpod
class HomeScreenController extends _$HomeScreenController {
  @override
  HomeScreenState build() {
    return const HomeScreenState();
  }

  void toggleOnlyAvailable() {
    state = state.copyWith(onlyAvailable: !state.onlyAvailable);
  }

  void setSortType(SortType sortType) {
    state = state.copyWith(sortType: sortType);
  }
}
