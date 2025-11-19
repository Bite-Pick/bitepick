import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/features/banner/domain/entities/banner_image.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'banner_repository.g.dart';

class BannerRepository {
  final Ref ref;
  late final Dio _dio;

  BannerRepository(this.ref) {
    _dio = ref.read(apiClientProvider);
  }
  Future<List<BannerImage>> getBanners() async {
    final res = await _dio.get('/v1/banner/images');
    if (res.data['data'] == null) return [];
    final list = res.data['data']['bannerPreSignedUrlImages'] as List<dynamic>?;
    if (res.data['status'] != 'OK' || list == null) return [];

    return list
        .map((json) => BannerImage.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

@riverpod
BannerRepository bannerRepository(Ref ref) {
  return BannerRepository(ref);
}

@riverpod
Future<List<BannerImage>> bannerImages(Ref ref) {
  return ref.read(bannerRepositoryProvider).getBanners();
}
