import 'dart:developer' show log;

import 'package:dio/dio.dart';
import '../../../../core/config/environment.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/area.dart';

class NaverGeocodingRepository {
  late final Dio _dio;

  NaverGeocodingRepository() {
    _dio = ApiClient().createCustomDio(
      baseUrl: Environment.geocodingApiUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'x-ncp-apigw-api-key-id': Environment.ncpApiKeyId,
        'x-ncp-apigw-api-key': Environment.ncpApiKey,
      },
    );
  }

  /// ====== 동(Dong) 키워드 검색 ======
  /// 동 수준까지만 검색 (건물번호, 지번 등 제외)
  Future<List<Area>> searchArea(String keyword) async {
    final response = await _dio.get(
      '/map-geocode/v2/geocode',
      queryParameters: {'query': keyword, 'page': 1, 'count': 10},
    );

    log('🔍 searchArea response: ${response.data}');

    if (response.data == null || response.data['addresses'] == null) return [];

    final List addresses = response.data['addresses'] as List;
    final Map<String, Area> deduplicatedMap = {};

    for (final address in addresses) {
      log('📍 Processing address: $address');

      final addressElements = address['addressElements'] as List? ?? [];
      final regions = _extractRegions(addressElements);

      log('🗺️ Extracted regions: $regions');

      if (regions['sido'] == null || regions['sigungu'] == null) continue;

      // Build display name
      final displayNameParts = [
        regions['sido']!,
        regions['sigungu']!,
        if (regions['dong'] != null) regions['dong']!,
      ];
      final displayName = displayNameParts.join(' ');

      // Extract coordinates
      final x = double.tryParse(address['x']?.toString() ?? '');
      final y = double.tryParse(address['y']?.toString() ?? '');

      if (x == null || y == null) continue;

      // Use display name as deduplication key
      deduplicatedMap[displayName] = Area(
        displayName: displayName,
        latitude: y,
        longitude: x,
        region1: regions['sido'],
        region2: regions['sigungu'],
        region3: regions['dong'],
        region4: regions['ri'],
      );
    }

    log('✅ Final areas: ${deduplicatedMap.values.length} items');
    return deduplicatedMap.values.toList();
  }

  /// addressElements에서 지역 정보 추출
  Map<String, String?> _extractRegions(List addressElements) {
    String? sido;
    String? sigungu;
    String? dong;
    String? ri;

    for (final element in addressElements) {
      final types = element['types'] as List? ?? [];
      final longName = element['longName'] as String? ?? '';

      if (types.contains('SIDO')) {
        sido = longName;
      } else if (types.contains('SIGUGUN')) {
        sigungu = longName;
      } else if (types.contains('DONGMYUN')) {
        dong = longName;
      } else if (types.contains('RI')) {
        ri = longName;
      }
    }

    return {'sido': sido, 'sigungu': sigungu, 'dong': dong, 'ri': ri};
  }

  /// ====== 3. Reverse Geocoding (좌표 → 동 주소) ======
  /// 위경도를 동 수준 주소로 변환
  Future<Area?> reverseGeocode(double lat, double lng) async {
    final response = await _dio.get(
      '/map-reversegeocode/v2/gc',
      queryParameters: {
        'request': 'coordsToaddr',
        'coords': '$lng,$lat',
        'sourcecrs': 'epsg:4326',
        'output': 'json',
        'orders': 'addr',
      },
    );

    if (response.data == null || response.data['results'] == null) {
      return null;
    }

    final List results = response.data['results'] as List;
    if (results.isEmpty) {
      return null;
    }

    // Get the first result (addr type)
    final result = results.first;
    final region = result['region'];

    if (region == null) {
      return null;
    }

    // Extract area names
    final area1 = region['area1']?['name'] as String? ?? '';
    final area2 = region['area2']?['name'] as String? ?? '';
    final area3 = region['area3']?['name'] as String? ?? '';

    // Combine area names
    final displayNameParts = <String>[];
    if (area1.isNotEmpty) displayNameParts.add(area1);
    if (area2.isNotEmpty) displayNameParts.add(area2);
    if (area3.isNotEmpty) displayNameParts.add(area3);

    final displayName = displayNameParts.join(' ');

    return Area(
      displayName: displayName,
      latitude: lat,
      longitude: lng,
      region1: area1.isNotEmpty ? area1 : null,
      region2: area2.isNotEmpty ? area2 : null,
      region3: area3.isNotEmpty ? area3 : null,
    );
  }

  //   /// ====== 1. 일반 주소 검색 (도로명/지번) ======
  // /// * 전체 주소 검색 (도로명주소, 지번주소 등)
  // Future<List<Address>> geocode(String query) async {
  //   final response = await _dio.get(
  //     '/map-geocode/v2/geocode',
  //     queryParameters: {'query': query, 'page': 1, 'count': 10},
  //   );

  //   final data = response.data is String
  //       ? jsonDecode(response.data)
  //       : response.data;
  //   final List addresses = (data['addresses'] as List?) ?? [];

  //   if (addresses.isEmpty) return [];

  //   final results = <Address>[];
  //   for (final a in addresses) {
  //     final label = (a['roadAddress'] as String?)?.trim();
  //     final jibun = (a['jibunAddress'] as String?)?.trim();
  //     final y = (a['y'] as String?) ?? a['y']?.toString();
  //     final x = (a['x'] as String?) ?? a['x']?.toString();

  //     if (y == null || x == null) continue;

  //     results.add(
  //       Address(
  //         label: label?.isNotEmpty == true ? label! : (jibun ?? ''),
  //         address: label?.isNotEmpty == true ? label! : (jibun ?? ''),
  //         latitude: double.tryParse(y) ?? 0,
  //         longitude: double.tryParse(x) ?? 0,
  //       ),
  //     );
  //   }

  //   return results;
  // }
}
