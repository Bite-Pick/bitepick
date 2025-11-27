import 'package:freezed_annotation/freezed_annotation.dart';

part 'pending_store.dto.freezed.dart';
part 'pending_store.dto.g.dart';

/// 승인 대기 매장 DTO
@freezed
class PendingStoreDto with _$PendingStoreDto {
  const factory PendingStoreDto({
    required String storeId,
    required String storeName,
    @JsonKey(name: 'ImageUrl') required List<String> imageUrl,
    String? goodsName,
    required String startTime,
    required String endTime,
    required int originPrice,
    required int discount,
    required int salePrice,
    required int quantity,
    double? distance,
    required String saleStatus,
    required double longitude,
    required double latitude,
    required String address,
  }) = _PendingStoreDto;

  factory PendingStoreDto.fromJson(Map<String, dynamic> json) =>
      _$PendingStoreDtoFromJson(json);
}
