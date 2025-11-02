import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_repository.g.dart';

class FavoriteRepository {
  final Dio _dio = ApiClient().dio;

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
}

@riverpod
FavoriteRepository favoriteRepository(Ref ref) {
  return FavoriteRepository();
}

@riverpod
Future<bool?> favorite(Ref ref, {required String storeId}) async {
  return ref.read(favoriteRepositoryProvider).getFavorite(storeId);
}
