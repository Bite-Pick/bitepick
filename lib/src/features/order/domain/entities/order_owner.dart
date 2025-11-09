import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/features/order/domain/entities/order_status.dart';

part 'order_owner.freezed.dart';
part 'order_owner.g.dart';

@freezed
class OrderOwner with _$OrderOwner {
  const factory OrderOwner({
    required String orderId,
    required OrderStatus orderStatus,
    required DateTime createdAt,
    required DateTime pickupTime,
    String? memo,
    required int quantity,
    required int totalPrice,
    required String phoneNumber,
    required String goodsName,
  }) = _OrderOwner;

  factory OrderOwner.fromJson(Map<String, dynamic> json) =>
      _$OrderOwnerFromJson(json);
}
