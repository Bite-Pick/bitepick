import 'package:dio/dio.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/features/home/domain/entity/goods.dart';
import 'package:magambell/src/features/store/domain/sort_type.dart';

class StoreRepository {
  final Dio _dio = ApiClient().dio;

  Future<List<Goods>> getStoreGoods({
    required double latitude,
    required double longitude,
    String? keyword,
    SortType sortType = SortType.recentDesc,
    bool onlyAvailable = true,
    int page = 1,
    int size = 10,
  }) async {
    final res = await _dio.get(
      '/api/v1/store',
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
    if (res.data['status'] != 'OK') return [];

    final data = res.data['data'] as Map<String, dynamic>?;
    final list = data?['storeListDTOResponses'] as List? ?? [];

    return list
        .map((json) => Goods.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<Goods?> getStoreGoodsById(String id) async {
    final res = await _dio.get('/api/v1/store/$id');

    if (res.data['status'] != 'OK') return null;

    final data = res.data['data'];
    return Goods.fromJson(data as Map<String, dynamic>);
  }
}
