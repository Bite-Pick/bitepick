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

final List<OrderOwner> mockOrderOwners = [
  OrderOwner(
    orderId: 'ORD-20231107-001',
    orderStatus: OrderStatus.pending,
    createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
    pickupTime: DateTime.now().add(const Duration(hours: 1)),
    memo: '문 앞에 놓아주세요',
    quantity: 2,
    totalPrice: 15000,
    phoneNumber: '010-1234-5678',
    goodsName: '맛있는 빵 세트',
  ),
  OrderOwner(
    orderId: 'ORD-20231107-002',
    orderStatus: OrderStatus.accepted,
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    pickupTime: DateTime.now().add(const Duration(minutes: 30)),
    memo: '빨리 부탁드립니다!',
    quantity: 1,
    totalPrice: 12000,
    phoneNumber: '010-9876-5432',
    goodsName: '샌드위치와 커피',
  ),
  OrderOwner(
    orderId: 'ORD-20231107-003',
    orderStatus: OrderStatus.canceled,
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    pickupTime: DateTime.now().add(const Duration(hours: 2)),
    memo: '고객 요청으로 취소',
    quantity: 3,
    totalPrice: 9000,
    phoneNumber: '010-1111-2222',
    goodsName: '샐러드 세트',
  ),
  OrderOwner(
    orderId: 'ORD-20231107-004',
    orderStatus: OrderStatus.failed,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    pickupTime: DateTime.now().add(const Duration(hours: 3)),
    memo: '결제 실패',
    quantity: 1,
    totalPrice: 7000,
    phoneNumber: '010-3333-4444',
    goodsName: '케이크 한 조각',
  ),
];
