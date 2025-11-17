import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/features/store/domain/entities/store_info_ui_data.dart';

part 'goods_detail.dto.freezed.dart';
part 'goods_detail.dto.g.dart';

@freezed
class GoodsDetailDto with _$GoodsDetailDto {
  const factory GoodsDetailDto({
    required String storeId,
    required String goodsId,
    required String storeName,
    required String address,
    required List<String> images,
    required DateTime startTime,
    required DateTime endTime,
    required int originalPrice,
    required int salePrice,
    required int discount,
    required String description,
    required int quantity,
    required String saleStatus,
    required int reviewCount,
    required double averageRating,
  }) = _GoodsDetailDto;

  factory GoodsDetailDto.fromJson(Map<String, dynamic> json) =>
      _$GoodsDetailDtoFromJson(json);
  const GoodsDetailDto._();

  StoreInfoUiData toStoreInfoData() {
    return StoreInfoUiData(
      storeId: storeId,
      storeName: storeName,
      address: address,
      imageUrls: images,
      latitude: 0,
      longitude: 0,
      stockQuantity: quantity,
      saleStatus: saleStatus,
      discount: discount,
      salePrice: salePrice,
      originPrice: originalPrice,
      startTime: startTime.toIso8601String(),
      endTime: endTime.toIso8601String(),
      description: description,
    );
  }
}
