import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/address/domain/entities/region.dart';
import 'package:magambell/src/features/address/providers/region.provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select_service_region_screen.controller.freezed.dart';
part 'select_service_region_screen.controller.g.dart';

@freezed
class SelectServiceRegionState with _$SelectServiceRegionState {
  const factory SelectServiceRegionState({
    Region? selectedCity,
    Region? selectedDistrict,
    Region? selectedTown,
    @Default([]) List<Region> districts,
    @Default([]) List<Region> towns,
  }) = _SelectServiceRegionState;
}

@riverpod
class SelectServiceRegionScreenController
    extends _$SelectServiceRegionScreenController {
  @override
  SelectServiceRegionState build() {
    return const SelectServiceRegionState();
  }

  Future<void> selectCity(Region city) async {
    state = state.copyWith(
      selectedCity: city,
      selectedDistrict: null,
      selectedTown: null,
      districts: [],
      towns: [],
    );
    final districts = await ref.read(regionDistrictsProvider(city.name).future);

    state = state.copyWith(districts: districts);
  }

  Future<void> selectDistrict(Region district) async {
    if (state.selectedCity == null) return;

    final city = state.selectedCity!;

    state = state.copyWith(
      selectedDistrict: district,
      selectedTown: null,
      towns: [],
    );

    if (district == state.selectedCity) {
      state = state.copyWith(towns: []);
      return;
    }

    final towns = await ref.read(
      regionTownsProvider(
        cityName: city.name,
        districtName: district.name,
      ).future,
    );

    state = state.copyWith(towns: towns);
  }

  void selectTown(Region town) => state = state.copyWith(selectedTown: town);
}
