import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/features/address/data/repositories/region_repository.dart';
import 'package:magambell/src/features/address/domain/entities/region.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'region.provider.g.dart';

@riverpod
Future<List<Region>> regionCities(Ref ref) async {
  final cities = await ref.watch(regionRepositoryProvider).getRegionCity();
  return cities
      .map((city) => Region(id: city.regionId, name: city.name))
      .toList();
}

@riverpod
Future<List<Region>> regionDistricts(Ref ref, String cityName) async {
  final districts = await ref
      .watch(regionRepositoryProvider)
      .getRegionDistrict(cityName);
  return districts
      .map((district) => Region(id: district.regionId, name: district.name))
      .toList();
}

@riverpod
Future<List<Region>> regionTowns(
  Ref ref, {
  required String cityName,
  required String districtName,
}) async {
  final towns = await ref
      .watch(regionRepositoryProvider)
      .getRegionTown(city: cityName, district: districtName);
  return towns
      .map((town) => Region(id: town.regionId, name: town.name))
      .toList();
}
