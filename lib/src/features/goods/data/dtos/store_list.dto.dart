import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/features/goods/domain/entities/goods.dart';
import 'package:magambell/src/features/home/domain/entities/home_goods_item_data.dart';

part 'store_list.dto.freezed.dart';

/// 매장 리스트 응답 DTO
@freezed
class StoreListDTO with _$StoreListDTO {
  const factory StoreListDTO({
    required String storeId,
    required String storeName,
    @Default([]) List<String> imageUrl,
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

  factory StoreListDTO.fromJson(Map<String, dynamic> json) {
    // prod 서버는 'ImageUrl'(대문자), dev 서버는 'imageUrl'(소문자)로 내려옴
    final rawImages = json['ImageUrl'] ?? json['imageUrl'];
    final images = rawImages is List
        ? rawImages.map((e) => e as String).toList()
        : <String>[];
    return StoreListDTO(
      storeId: json['storeId'] as String,
      storeName: json['storeName'] as String,
      imageUrl: images,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String,
      goodsName: json['goodsName'] as String?,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      originPrice: json['originPrice'] as int,
      discount: json['discount'] as int,
      salePrice: json['salePrice'] as int,
      quantity: json['quantity'] as int,
      distance: (json['distance'] as num).toDouble(),
      saleStatus: json['saleStatus'] as String,
    );
  }

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
