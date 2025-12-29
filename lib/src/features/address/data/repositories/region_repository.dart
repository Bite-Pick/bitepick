import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/features/address/data/dtos/region.dto.dart';
import 'package:magambell/src/features/address/domain/entities/address.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'region_repository.g.dart';

class RegionRepository {
  final Ref ref;
  late final Dio _dio;

  RegionRepository(this.ref) {
    _dio = ref.read(apiClientProvider);
  }

  Future<List<Address>> getServiceAddresses() async {
    final res = await _dio.get('/v1/service-areas');
    // talker.debug('Service Areas Response: ${res.data}');
    if (res.data['status'] != 'OK') return [];
    final serviceAddressesData = res.data['data'] as List?;
    if (serviceAddressesData == null) return [];
    return serviceAddressesData
        .map((json) => Address.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<CityDto>> getRegionCity() async {
    final res = await _dio.get('/v1/store/region/city');
    if (res.data['status'] != 'OK') return [];
    final cities = res.data['data']['sidoList'] as List?;
    if (cities == null) return [];
    return cities
        .map((json) => CityDto.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<DistrictDto>> getRegionDistrict(String city) async {
    final res = await _dio.get(
      '/v1/store/region/district',
      queryParameters: {'sido': city},
    );
    if (res.data['status'] != 'OK') return [];
    final districts = res.data['data']['sigunguList'] as List?;
    if (districts == null) return [];
    return districts
        .map((json) => DistrictDto.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<TownDto>> getRegionTown({
    required String city,
    required String district,
  }) async {
    final res = await _dio.get(
      '/v1/store/region/town',
      queryParameters: {'sido': city, 'sigungu': district},
    );
    if (res.data['status'] != 'OK') return [];
    final towns = res.data['data']['eupmyeondongList'] as List?;
    if (towns == null) return [];
    return towns
        .map((json) => TownDto.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

@riverpod
RegionRepository regionRepository(Ref ref) {
  return RegionRepository(ref);
}

@riverpod
Future<List<Address>> serviceAddresses(Ref ref) {
  return ref.watch(regionRepositoryProvider).getServiceAddresses();
}

@riverpod
Future<List<CityDto>> regionCities(Ref ref) {
  return ref.watch(regionRepositoryProvider).getRegionCity();
}
