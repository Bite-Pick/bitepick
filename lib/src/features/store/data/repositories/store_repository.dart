import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/core/utils/shared_preference_store.dart';
import 'package:magambell/src/features/goods/data/dtos/goods_detail.dto.dart';
import 'package:magambell/src/features/goods/data/dtos/store_list.dto.dart';
import 'package:magambell/src/features/image/domain/entities/image_upload_response.dart';
import 'package:magambell/src/features/store/domain/entities/store.dart';
import 'package:magambell/src/features/store/domain/sort_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'store_repository.g.dart';

class StoreRepository {
  final Ref ref;
  late final Dio _dio;

  StoreRepository(this.ref) {
    _dio = ref.read(apiClientProvider);
  }

  Future<List<StoreListDTO>> getStoreGoodsList({
    required double latitude,
    required double longitude,
    String? keyword,
    SortType sortType = SortType.recentDesc,
    bool onlyAvailable = true,
    int page = 1,
    int size = 10,
  }) async {
    final res = await _dio.get(
      '/v1/store',
      queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
        if (keyword != null) 'keyword': keyword,
        'sortType': sortType.value,
        'onlyAvailable': onlyAvailable,
        'page': page,
        'size': size,
      },
    );

    final data = res.data['data'] as Map<String, dynamic>?;
    if (res.data['status'] != 'OK' || data == null) return [];

    final list = data['storeListDTOResponses'] as List? ?? [];

    return list
        .map((json) => StoreListDTO.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<GoodsDetailDto?> getStoreGoodsDetail(String storeId) async {
    final res = await _dio.get('/v1/store/$storeId');

    if (res.data['status'] != 'OK') return null;

    final data = res.data['data'];
    return GoodsDetailDto.fromJson(data as Map<String, dynamic>);
  }

  Future<List<PresignedUrlImage>> createStore({
    required String name,
    required String address,
    required double latitude,
    required double longitude,
    required String ownerName,
    required String ownerPhone,
    required String businessNumber,
    required String bankName,
    required String bankAccount,
    required String parkingDescription,
    required List<Map<String, dynamic>> storeImagesRegisters,
  }) async {
    final res = await _dio.post(
      '/v1/store',
      data: {
        'name': name,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'ownerName': ownerName,
        'ownerPhone': ownerPhone,
        'businessNumber': businessNumber,
        'bankName': bankName,
        'bankAccount': bankAccount,
        'storeImagesRegisters': storeImagesRegisters,
        'parkingDescription': parkingDescription,
      },
    );
    if (res.data['status'] != 'OK') return [];

    final presignedImagesData =
        res.data['data']['storePreSignedUrlImages'] as List?;
    if ((presignedImagesData ?? []).isEmpty) return [];

    return presignedImagesData!
        .map((json) => PresignedUrlImage.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<Store?> getOwnerStore() async {
    final res = await _dio.get('/v1/store/owner');

    if (res.data['status'] != 'OK') return null;

    final data = res.data['data']['data'];
    if (data == null) return null;

    return Store.fromJson(data as Map<String, dynamic>);
  }

  Future<bool> requestOpenRegion({required String region}) async {
    final res = await _dio.post("/v1/store/region", data: {"region": region});

    // API 공통 응답 형태 기준
    if (res.data['status'] != 'OK') return false;

    final data = res.data['data'];
    if (data == null) return false;

    // 성공 시 SharedPreferences에 지역 저장
    await SharedPreferenceStore().setRequestedRegion(region);

    return true;
  }
  
}

@riverpod
StoreRepository storeRepository(Ref ref) {
  return StoreRepository(ref);
}

@riverpod
Future<List<StoreListDTO>> storeGoodsList(
  Ref ref, {
  required double latitude,
  required double longitude,
  String? keyword,
  SortType sortType = SortType.recentDesc,
  bool onlyAvailable = true,
  int page = 1,
  int size = 10,
}) async {
  return ref
      .read(storeRepositoryProvider)
      .getStoreGoodsList(
        latitude: latitude,
        longitude: longitude,
        keyword: keyword,
        sortType: sortType,
        onlyAvailable: onlyAvailable,
        page: page,
        size: size,
      );
}

@riverpod
Future<GoodsDetailDto?> storeGoodsDetail(Ref ref, String id) async {
  return ref.read(storeRepositoryProvider).getStoreGoodsDetail(id);
}

@riverpod
Future<Store?> ownerStore(Ref ref) async {
  return ref.read(storeRepositoryProvider).getOwnerStore();
}
