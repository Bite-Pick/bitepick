import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/core/utils/shared_preference_store.dart';
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

  Future<List<RegionDto>> getRegionCity() async {
    final res = await _dio.get('/v1/store/region/city');
    if (res.data['status'] != 'OK') return [];
    final cities = res.data['data']['cityList'] as List?;
    if (cities == null) return [];
    return cities
        .map((json) => RegionDto.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<RegionDto>> getRegionDistrict(String city) async {
    final res = await _dio.get(
      '/v1/store/region/district',
      queryParameters: {'city': city},
    );
    if (res.data['status'] != 'OK') return [];
    final districts = res.data['data']['districtList'] as List?;
    if (districts == null) return [];
    return districts
        .map((json) => RegionDto.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<RegionDto>> getRegionTown({
    required String city,
    required String district,
  }) async {
    final res = await _dio.get(
      '/v1/store/region/town',
      queryParameters: {'city': city, 'district': district},
    );
    if (res.data['status'] != 'OK') return [];
    final towns = res.data['data']['townList'] as List?;
    if (towns == null) return [];
    return towns
        .map((json) => RegionDto.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<bool> requestOpenRegion({required int regionId}) async {
    final res = await _dio.post(
      "/v1/store/region",
      data: {"regionId": regionId},
    );

    // API 공통 응답 형태 기준
    if (res.data['status'] != 'OK') return false;

    final data = res.data['data'];
    if (data == null) return false;

    // 성공 시 SharedPreferences에 지역 저장
    await SharedPreferenceStore().setRequestedRegion(regionId);

    return true;
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
