import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/features/image/domain/entities/image_meta_data.dart';
import 'package:magambell/src/features/image/domain/entities/image_upload_response.dart';
import 'package:magambell/src/features/image/domain/entities/local_image.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'goods_repository.g.dart';

class GoodsRepository {
  final Ref ref;
  late final Dio _dio;

  GoodsRepository(this.ref) {
    _dio = ref.read(apiClientProvider);
  }

  /// Goods 등록 API 호출 (이미지 메타데이터 포함)
  /// 응답에서 goodsPreSignedImages만 파싱하여 반환
  Future<List<PresignedUrlImage>> createGoods({
    required String description,
    required int originalPrice,
    required int discount,
    required int salePrice,
    required int quantity,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final res = await _dio.post(
      '/v1/goods',
      data: {
        'description': description,
        'originalPrice': originalPrice,
        'discount': discount,
        'salePrice': salePrice,
        'quantity': quantity,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
        // 'goodsImagesRegisters': goodsImagesRegisters
        //     .map((e) => e.toJson())
        //     .toList(),
        // TODO: 추후 상세설명 추가 예정
      },
    );

    // data['goodsPreSignedImages']에서 presigned URL 배열만 추출
    // final presignedImagesData =
    //     res.data['data']['goodsPreSignedImages'] as List;
    // return presignedImagesData
    //     .map((json) => PresignedUrlImage.fromJson(json as Map<String, dynamic>))
    //     .toList();
    final data = res.data['data'] as String?;
    if (res.data['status'] != 'OK' || data == null) return [];
    return [];
  }

  // TODO: 백엔드 수정 필요

  Future<List<PresignedUrlImage>> editGoods({
    required String goodsId,
    String? name,
    required String description,
    required int originalPrice,
    required int discount,
    required int salePrice,
    required int quantity,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final res = await _dio.patch(
      '/v1/goods',
      data: {
        'goodsId': goodsId,
        'name': name,
        'description': description,
        'originalPrice': originalPrice,
        'discount': discount,
        'salePrice': salePrice,
        'quantity': quantity,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
        // 'goodsImagesRegisters': goodsImagesRegisters
        //     .map((e) => e.toJson())
        //     .toList(),
        // TODO: 추후 상세설명 추가 예정
      },
    );

    // data['goodsPreSignedImages']에서 presigned URL 배열만 추출
    // final presignedImagesData =
    //     res.data['data']['goodsPreSignedImages'] as List;
    // return presignedImagesData
    //     .map((json) => PresignedUrlImage.fromJson(json as Map<String, dynamic>))
    //     .toList();
    final data = res.data['data'] as String?;
    if (res.data['status'] != 'OK' || data == null) return [];
    return [];
  }

  Future<bool> setGoodsSaleStatus({
    required String id,
    required bool saleStatus,
  }) async {
    final res = await _dio.patch(
      "v1/goods/status",
      data: {"goodsId": id, "saleStatus": saleStatus ? "ON" : "OFF"},
    );
    final data = res.data['data'] as String?;
    if (res.data['status'] != 'OK' || data == null) return false;
    return true;
  }
}

@riverpod
GoodsRepository goodsRepository(Ref ref) {
  return GoodsRepository(ref);
}
