import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/address/data/repositories/address_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select_service_area_screen.controller.freezed.dart';
part 'select_service_area_screen.controller.g.dart';

@freezed
class SelectServiceAreaState with _$SelectServiceAreaState {
  const factory SelectServiceAreaState({
    String? selectedCity,
    String? selectedDistrict,
    String? selectedTown,
    @Default([]) List<String> districts,
    @Default([]) List<String> towns,
  }) = _SelectServiceAreaState;
}

@riverpod
class SelectServiceAreaScreenController
    extends _$SelectServiceAreaScreenController {
  @override
  SelectServiceAreaState build() {
    return const SelectServiceAreaState();
  }

  Future<void> selectCity(String city) async {
    state = state.copyWith(
      selectedCity: city,
      selectedDistrict: null,
      selectedTown: null,
      districts: [],
      towns: [],
    );
    final districts = await ref
        .read(addressRepositoryProvider)
        .getRegionDistrict(city);

    state = state.copyWith(districts: districts);
  }

  Future<void> selectDistrict(String district) async {
    if (state.selectedCity == null) return;

    final city = state.selectedCity!;

    state = state.copyWith(
      selectedDistrict: district,
      selectedTown: null,
      towns: [],
    );

    final towns = await ref
        .read(addressRepositoryProvider)
        .getRegionTown(city: city, district: district);

    state = state.copyWith(towns: towns);
  }

  void selectTown(String town) {
    talker.debug('🏡 [selectTown] 시작: $town');
    state = state.copyWith(selectedTown: town);
    talker.debug('🏡 [selectTown] 상태 업데이트 완료: selectedTown=$town');
  }
}
