import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/features/admin/data/dtos/pending_store.dto.dart';
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

    if (response.data['status'] != 'SUCCESS') {
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

    if (response.data['status'] != 'SUCCESS') {
      throw Exception('매장 이미지 수정에 실패했습니다.');
    }

    final data = response.data['data'];
    if (data == null) return [];

    final presignedUrls = data['storePreSignedUrlImages'] as List? ?? [];

    return presignedUrls
        .map((json) => PresignedUrlImage.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // TODO: 배너 등록 /v1/banner

  // TODO: 신고하기 v1/review/report
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
