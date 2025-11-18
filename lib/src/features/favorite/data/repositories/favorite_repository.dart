import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/features/favorite/data/dtos/favorite_store_list.dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_repository.g.dart';

class FavoriteRepository {
  final Ref ref;
  late final Dio _dio;

  FavoriteRepository(this.ref) {
    _dio = ref.read(apiClientProvider);
  }

  Future<bool> addFavorite(String storeId) async {
    final res = await _dio.post('/v1/favorite/$storeId');
    final data = res.data['data'] as String?;
    if (res.data['status'] != 'OK' || data == null) return false;
    return true;
  }

  Future<bool> removeFavorite(String storeId) async {
    final res = await _dio.delete('/v1/favorite/$storeId');
    final data = res.data['data'] as String?;
    if (res.data['status'] != 'OK' || data == null) return false;
    return true;
  }

  Future<bool?> getFavorite(String storeId) async {
    final res = await _dio.get('/v1/favorite/$storeId');
    final data = res.data['data'] as bool?;
    if (res.data['status'] != 'OK' || data == null) return null;
    return data;
  }

  Future<List<FavoriteStoreListDTO>> getMyFavoriteStores() async {
    final res = await _dio.get(
      '/v1/favorite',
      queryParameters: {'page': 1, 'size': 10},
    );
    final list =
        res.data['data']['favoriteStoreListDTOResponseList'] as List<dynamic>?;
    if (res.data['status'] != 'OK' || list == null) {
      return [];
    }
    return list
        .map(
          (json) => FavoriteStoreListDTO.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }
}

@riverpod
FavoriteRepository favoriteRepository(Ref ref) {
  return FavoriteRepository(ref);
}

@riverpod
Future<bool?> favorite(Ref ref, {required String storeId}) async {
  return ref.read(favoriteRepositoryProvider).getFavorite(storeId);
}

@riverpod
Future<List<FavoriteStoreListDTO>> myFavorite(MyFavoriteRef ref) async {
  return ref.read(favoriteRepositoryProvider).getMyFavoriteStores();
}
