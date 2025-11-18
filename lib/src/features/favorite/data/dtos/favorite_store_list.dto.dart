import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/features/home/domain/entities/home_goods_item_data.dart';

part 'favorite_store_list.dto.freezed.dart';
part 'favorite_store_list.dto.g.dart';

@freezed
class FavoriteStoreListDTO with _$FavoriteStoreListDTO {
  const factory FavoriteStoreListDTO({
    required String storeId,
    required String storeName,
    required String address,
    @JsonKey(name: 'ImageUrl') required List<String> imageUrl,
    required String startTime,
    required String endTime,
    required int originPrice,
    required int discount,
    required int salePrice,
    required int quantity,
    required String saleStatus,
    String? goodsName,
  }) = _FavoriteStoreListDTO;

  factory FavoriteStoreListDTO.fromJson(Map<String, dynamic> json) =>
      _$FavoriteStoreListDTOFromJson(json);

  const FavoriteStoreListDTO._();

  HomeGoodsItemData toHomeGoodsItem() {
    return HomeGoodsItemData(
      storeId: storeId,
      storeName: storeName,
      imageUrl: imageUrl,
      discount: discount,
      salePrice: salePrice,
      startTime: startTime,
      endTime: endTime,
      distance: 0.0, // Favorite API에서는 distance가 없음 → 기본값 처리
      quantity: quantity,
      saleStatus: saleStatus,
    );
  }
}
