import 'package:freezed_annotation/freezed_annotation.dart';

part 'registered_store.dto.freezed.dart';
part 'registered_store.dto.g.dart';

@freezed
class GoodsImageItemDto with _$GoodsImageItemDto {
  const factory GoodsImageItemDto({
    required String goodsImageId,
    String? imageUrl,
    @Default('') String key,
    String? goodsName,
  }) = _GoodsImageItemDto;

  factory GoodsImageItemDto.fromJson(Map<String, dynamic> json) =>
      _$GoodsImageItemDtoFromJson(json);
}

/// 입점 매장 전체 조회 및 수정 DTO
@freezed
class RegisteredStoreDto with _$RegisteredStoreDto {
  const factory RegisteredStoreDto({
    required String storeId,
    required String storeName,
    @Default([]) List<String> storeImages,
    @Default([]) List<GoodsImageItemDto> goodsImageList,
    String? goodsName,
    String? description,
    String? parkingDescription,
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
    required String ownerName,
    required String ownerPhone,
    required String businessNumber,
    required String bankName,
    required String bankAccount,
  }) = _RegisteredStoreDto;

  factory RegisteredStoreDto.fromJson(Map<String, dynamic> json) =>
      _$RegisteredStoreDtoFromJson(json);
}
