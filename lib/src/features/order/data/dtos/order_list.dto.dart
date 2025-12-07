import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/features/order/domain/entities/order_guest_status.dart';
import 'package:magambell/src/features/order/domain/entities/order_list_item_state.dart';

part 'order_list.dto.freezed.dart';
part 'order_list.dto.g.dart';

@freezed
class OrderListDTO with _$OrderListDTO {
  const factory OrderListDTO({
    required String orderId,
    required OrderGuestStatus orderStatus,
    required String createdAt,
    required String storeId,
    required String storeName,
    required List<String> imageUrls,
    required List<OrderGoodsDTO> goodsList,
    required List<String> reviewIds,
    required String payType,
    required String easyPayProvider,
    String? pickupTime,
    // NOTE: test 필요
    double? latitude,
    double? longitude,
    // TODO: API 반환값 추가 필요
    String? memo,
    int? discount,
    String? address,
  }) = _OrderListDTO;

  factory OrderListDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderListDTOFromJson(json);
  const OrderListDTO._();

  OrderListItemState toOrderListItemState() {
    final goods = goodsList[0];
    final totalQuantity = goods.quantity;
    final totalSalePrice = goods.salePrice;
    final goodsName = goods.goodsName;

    return OrderListItemState(
      orderId: orderId,
      orderStatus: orderStatus,
      createdAt: createdAt,
      storeId: storeId,
      imageUrls: imageUrls,
      quantity: totalQuantity,
      salePrice: totalSalePrice,
      latitude: latitude,
      longitude: longitude,
      storeName: storeName,
      discount: discount,
      address: address,
      memo: memo,
      goodsName: goodsName,
    );
  }
}

@freezed
class OrderGoodsDTO with _$OrderGoodsDTO {
  const factory OrderGoodsDTO({
    required String orderGoodsId,
    String? goodsName,
    required int quantity,
    required int salePrice,
  }) = _OrderGoodsDTO;

  factory OrderGoodsDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderGoodsDTOFromJson(json);
}
