import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/features/goods/domain/entities/goods.dart';

part 'store_list_response.freezed.dart';
part 'store_list_response.g.dart';

/// 매장 리스트 응답 DTO
@freezed
class StoreListResponse with _$StoreListResponse {
  const factory StoreListResponse({
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
  }) = _StoreListResponse;

  const StoreListResponse._();

  factory StoreListResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreListResponseFromJson(json);

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
}
