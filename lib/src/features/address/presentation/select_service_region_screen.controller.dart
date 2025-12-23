import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/address/data/repositories/address_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select_service_region_screen.controller.freezed.dart';
part 'select_service_region_screen.controller.g.dart';

@freezed
class SelectServiceRegionState with _$SelectServiceRegionState {
  const factory SelectServiceRegionState({
    String? selectedCity,
    String? selectedDistrict,
    String? selectedTown,
    @Default([]) List<String> districts,
    @Default([]) List<String> towns,
  }) = _SelectServiceRegionState;
}

@riverpod
class SelectServiceRegionScreenController
    extends _$SelectServiceRegionScreenController {
  @override
  SelectServiceRegionState build() {
    return const SelectServiceRegionState();
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
    // if(town.contains('전체')) selectedDisctict
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
    // if(town.contains('전체')) selectedTown
    talker.debug('🏡 [selectTown] 시작: $town');
    state = state.copyWith(selectedTown: town);
    talker.debug('🏡 [selectTown] 상태 업데이트 완료: selectedTown=$town');
  }
}
