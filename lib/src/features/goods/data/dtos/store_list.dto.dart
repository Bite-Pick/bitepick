import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/features/goods/domain/entities/goods.dart';
import 'package:magambell/src/features/home/domain/entities/home_goods_item_data.dart';

part 'store_list.dto.freezed.dart';
part 'store_list.dto.g.dart';

/// 매장 리스트 응답 DTO
@freezed
class StoreListDTO with _$StoreListDTO {
  const factory StoreListDTO({
    required String storeId,
    required String storeName,
    @JsonKey(name: 'ImageUrl') required List<String> imageUrl,
    required double latitude,
    required double longitude,
    required String address,
    String? goodsName,
    required String startTime,
    required String endTime,
    required int originPrice,
    required int discount,
    required int salePrice,
    required int quantity,
    required double distance,
    required String saleStatus,
  }) = _StoreListDTO;

  const StoreListDTO._();

  factory StoreListDTO.fromJson(Map<String, dynamic> json) =>
      _$StoreListDTOFromJson(json);

  /// DTO를 Goods 엔티티로 변환
  Goods toGoods() {
    return Goods(
      storeId: storeId,
      storeName: storeName,
      ImageUrl: imageUrl,
      latitude: latitude,
      longitude: longitude,
      address: address,
      goodsName: goodsName,
      startTime: startTime,
      endTime: endTime,
      originPrice: originPrice,
      discount: discount,
      salePrice: salePrice,
      stockQuantity: quantity,
      distance: distance,
      saleStatus: saleStatus,
    );
  }

  HomeGoodsItemData toHomeGoodsItem() {
    return HomeGoodsItemData(
      storeId: storeId,
      storeName: storeName,
      imageUrl: imageUrl,
      discount: discount,
      salePrice: salePrice,
      startTime: startTime,
      endTime: endTime,
      distance: distance,
      quantity: quantity,
      saleStatus: saleStatus,
    );
  }
}
