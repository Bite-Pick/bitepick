import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/features/goods/domain/entities/goods.dart';
import 'package:magambell/src/features/store/domain/sort_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'store_repository.g.dart';

class StoreRepository {
  final Dio _dio = ApiClient().dio;

  Future<List<Goods>> getStoreGoodsList({
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
        .map((json) => Goods.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<Goods?> getStoreGoodsDetail(String id) async {
    final res = await _dio.get('/v1/store/$id');

    if (res.data['status'] != 'OK') return null;

    final data = res.data['data'];
    return Goods.fromJson(data as Map<String, dynamic>);
  }

  Future<void> createStore({
    required String name,
    required String address,
    required double latitude,
    required double longitude,
    required String ownerName,
    required String ownerPhone,
    required String businessNumber,
    required String bankName,
    required String bankAccount,
    List<Map<String, dynamic>>? storeImagesRegisters,
  }) async {
    await _dio.post(
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
        if (storeImagesRegisters != null && storeImagesRegisters.isNotEmpty)
          'storeImagesRegisters': storeImagesRegisters,
      },
    );
  }
}

@riverpod
StoreRepository storeRepository(Ref ref) {
  return StoreRepository();
}

@riverpod
Future<List<Goods>> storeGoodsList(
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
Future<Goods?> storeGoodsDetail(Ref ref, String id) async {
  return ref.read(storeRepositoryProvider).getStoreGoodsDetail(id);
}
