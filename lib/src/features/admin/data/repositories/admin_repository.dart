import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/features/admin/data/dtos/pending_store.dto.dart';
import 'package:magambell/src/features/admin/data/dtos/registered_store.dto.dart';
import 'package:magambell/src/features/admin/domain/entities/admin_stats.dart';
import 'package:magambell/src/features/banner/domain/entities/banner_image.dart';
import 'package:magambell/src/features/image/domain/entities/image_upload_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_repository.g.dart';

class AdminRepository {
  final Ref ref;
  late final Dio _dio;

  AdminRepository(this.ref) {
    _dio = ref.read(apiClientProvider);
  }

  /// 승인 대기 매장 목록 조회
  Future<List<PendingStoreDto>> getPendingStoreList({
    int page = 1,
    int size = 20,
  }) async {
    final response = await _dio.get(
      '/v1/store/waiting',
      queryParameters: {'page': page, 'size': size},
    );

    if (response.data['status'] != 'OK') return [];

    final data = response.data['data'];
    if (data == null) return [];

    final list = data['storeAdminListDTOs'] as List? ?? [];

    return list
        .map((json) => PendingStoreDto.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// 매장 승인
  Future<bool> approveStore(String storeId) async {
    final response = await _dio.patch(
      '/v1/store/approve',
      data: {'id': storeId},
    );

    if (response.data['status'] != 'OK') {
      // throw Exception('매장 승인에 실패했습니다.');
      return false;
    }
    return true;
  }

  /// 매장 이미지 수정 (Presigned URL 방식)
  ///
  /// 1. 이 메서드로 Presigned URL 목록을 받습니다.
  /// 2. 각 URL로 실제 이미지 파일을 PUT 요청으로 업로드합니다.
  Future<List<PresignedUrlImage>> updateStoreImages({
    required String storeId,
    required List<Map<String, dynamic>> images,
  }) async {
    final response = await _dio.patch(
      '/v1/store',
      data: {'storeId': storeId, 'storeImagesRegisters': images},
    );

    if (response.data['status'] != 'OK') {
      throw Exception('매장 이미지 수정에 실패했습니다.');
    }

    final data = response.data['data'];
    if (data == null) return [];

    final presignedUrls = data['storePreSignedUrlImages'] as List? ?? [];

    return presignedUrls
        .map((json) => PresignedUrlImage.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// 승입 완료된 매장 목록 조회 
  Future<List<RegisteredStoreDto>> getRegisteredStoreList() async {
    final response = await _dio.get('/v1/admin/stores');

    if (response.data['status'] != 'OK') return [];

    final data = response.data['data'];
    if (data == null) return [];

    final list = data['storeAdminListDTOs'] as List? ?? [];

    return list
        .map((json) => RegisteredStoreDto.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// 입점 매장 관리 (정보 수정)
  /// 반환값: (storeUrls, goodsUrls) - url != null인 항목만 S3 업로드 필요
  Future<({List<PresignedUrlImage> storeUrls, List<PresignedUrlImage> goodsUrls})?> manageStore(int storeId, {
    required String storeName,
    required String address,
    required double latitude,
    required double longitude,
    required String ownerName,
    required String ownerPhone,
    required String businessNumber,
    required String bankName,
    required String bankAccount,
    required String description,
    required String parkingDescription,
    required List<Map<String, dynamic>> storeImages,
    required String startTime,
    required String endTime,
    required int originalPrice,
    required int salePrice,
    required int discount,
    required int quantity,
    required String saleStatus,
    required List<Map<String, dynamic>> goodsImages,
  }) async {
    final response = await _dio.put(
      '/v1/admin/stores/$storeId',
      data: {
        'storeName': storeName,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'ownerName': ownerName,
        'ownerPhone': ownerPhone,
        'businessNumber': businessNumber,
        'bankName': bankName,
        'bankAccount': bankAccount,
        'description': description,
        'parkingDescription': parkingDescription,
        'storeImages': storeImages,
        'startTime': startTime,
        'endTime': endTime,
        'originalPrice': originalPrice,
        'salePrice': salePrice,
        'discount': discount,
        'quantity': quantity,
        'saleStatus': saleStatus,
        'goodsImages': goodsImages,
      },
    );
    if (response.data['status'] != 'OK') return null;

    final data = response.data['data'];
    if (data == null) return (storeUrls: <PresignedUrlImage>[], goodsUrls: <PresignedUrlImage>[]);

    final storeUrls = (data['storePreSignedUrlImages'] as List? ?? [])
        .map((json) => PresignedUrlImage.fromJson(json as Map<String, dynamic>))
        .toList();
    final goodsUrls = (data['goodsPreSignedUrlImages'] as List? ?? [])
        .map((json) => PresignedUrlImage.fromJson(json as Map<String, dynamic>))
        .toList();

    return (storeUrls: storeUrls, goodsUrls: goodsUrls);
  }

  /// 배너 리스트 조회
  // TODO: banner 도메인으로 분리
  Future<List<BannerImage>> getBannerImages() async {
    final response = await _dio.get('/v1/banner/images');

    if (response.data['status'] != 'OK') return [];

    final data = response.data['data'];
    if (data == null) return [];

    final list = data['bannerPreSignedUrlImages'] as List? ?? [];

    return list
        .map((json) => BannerImage.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // 배너 등록 /v1/banner
  Future<BannerImage?> registerBanner(int id, String key) async {
    final response = await _dio.post(
      '/v1/banner',
      data: {
        "bannerImagesRegister": {
          "id":
              1, // TODO: 임시하드코딩; id값을 DateTime.milliseconds 값으로 넣으면 HttpRequestMethodNotSupportedException 발생
          "key": key,
        },
      },
    );

    if (response.data['status'] != 'OK') return null;

    final data = response.data['data'];
    if (data == null) return null;

    final bannerPreSignedUrlImages =
        data['bannerPreSignedUrlImage'] as Map<String, dynamic>;

    return BannerImage.fromJson(bannerPreSignedUrlImages);
  }

  // 배너 이미지 교체 /v1/banner
  Future<BannerImage?> editBannerImage({
    required int bannerId,
    required int id,
    required String key,
  }) async {
    final response = await _dio.patch(
      '/v1/banner',
      data: {
        "bannerId": id,
        "bannerImagesRegister": {"id": id, "key": key},
      },
    );

    if (response.data['status'] != 'OK') return null;

    final data = response.data['data'];
    if (data == null) return null;

    final bannerPreSignedUrlImages =
        data['bannerPreSignedUrlImage'] as Map<String, dynamic>;

    return BannerImage.fromJson(bannerPreSignedUrlImages);
  }

  // 배너 삭제
  Future<bool> removeBanner(int bannerId) async {
    final response = await _dio.delete('/v1/banner/$bannerId');

    if (response.data['status'] != 'OK') return false;

    final data = response.data['data'];
    if (data == null) return false;
    return true;
  }
  /// 관리자 통계 조회
  Future<AdminStats?> getAdminStats() async {
    final response = await _dio.get('/v1/admin/stats');

    if (response.data['status'] != 'OK') return null;

    final data = response.data['data'];
    if (data == null) return null;

    return AdminStats.fromJson(data as Map<String, dynamic>);
  }
}

@riverpod
AdminRepository adminRepository(Ref ref) {
  return AdminRepository(ref);
}

@riverpod
Future<List<PendingStoreDto>> pendingStoreList(
  Ref ref, {
  int page = 1,
  int size = 20,
}) async {
  return ref
      .read(adminRepositoryProvider)
      .getPendingStoreList(page: page, size: size);
}

@riverpod
Future<List<RegisteredStoreDto>> registeredStoreList(Ref ref) async {
  return ref.read(adminRepositoryProvider).getRegisteredStoreList();
}

@riverpod
Future<List<BannerImage>> bannerImages(Ref ref) async {
  return ref.read(adminRepositoryProvider).getBannerImages();
}

@riverpod
Future<AdminStats?> adminStats(Ref ref) async {
  return ref.read(adminRepositoryProvider).getAdminStats();
}
