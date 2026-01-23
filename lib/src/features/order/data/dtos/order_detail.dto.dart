import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/features/order/domain/entities/order_guest_status.dart';

part 'order_detail.dto.freezed.dart';
part 'order_detail.dto.g.dart';

@freezed
class OrderDetailDTO with _$OrderDetailDTO {
  const factory OrderDetailDTO({
    required String orderId,
    required String orderGoodsId,
    required OrderGuestStatus orderStatus,
    required String storeName,
    required String storeAddress,
    required String imageUrl,
    required int quantity,
    required int totalPrice,
    required String pickupTime,
    required String createdAt,
    required String storeId,
    String? payType,
    String? easyPayProvider,
    String? reviewId,
    String? memo,
    // TODO: discount 추가
    // TODO: originPrice 추가
  }) = _OrderDetailDTO;

  factory OrderDetailDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailDTOFromJson(json);
}
