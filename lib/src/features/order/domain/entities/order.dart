import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class Order with _$Order {
  const factory Order({
    required String orderId,
    required OrderStatus orderStatus,
    required DateTime createdAt,
    String? memo,
    required String storeId,
    required String storeName,
    required List<String> imageUrls,
    required List<OrderGoods> goodsList,
    required List<String> reviewIds,
    required String payType,
    String? easyPayProvider,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

@freezed
class OrderGoods with _$OrderGoods {
  const factory OrderGoods({
    required String orderGoodsId,
    required String goodsName,
    required int quantity,
    required int salePrice,
  }) = _OrderGoods;

  factory OrderGoods.fromJson(Map<String, dynamic> json) =>
      _$OrderGoodsFromJson(json);
}

enum OrderStatus {
  @JsonValue('PENDING')
  pending,
  @JsonValue('PAID')
  paid,
  @JsonValue('ACCEPTED')
  accepted,
  @JsonValue('REJECTED')
  rejected,
  @JsonValue('COMPLETED')
  completed,
  @JsonValue('CANCELED')
  canceled,
  @JsonValue('FAILED')
  failed,
}

extension OrderStatusExt on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.pending:
        return '수락대기';
      case OrderStatus.paid:
        return '주문 접수';
      case OrderStatus.accepted:
        return '픽업 대기';
      case OrderStatus.rejected:
        return '매장 취소';
      case OrderStatus.completed:
        return '픽업 완료';
      case OrderStatus.canceled:
        return '본인 취소';
      case OrderStatus.failed:
        return '주문 실패';
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.pending:
        return Color(0xffFFE7B3);
      case OrderStatus.paid:
        return Color(0xffCDE3FF);
      case OrderStatus.accepted:
        return Color(0xffD7F3D4);
      case OrderStatus.rejected:
      case OrderStatus.canceled:
      case OrderStatus.failed:
        return Color(0xffEF444D);
      case OrderStatus.completed:
        return Color(0xffE2E2E2);
    }
  }
}

// Mock data for testing
final List<Order> mockOrders = [
  Order(
    orderId: 'order_001',
    orderStatus: OrderStatus.accepted,
    createdAt: DateTime.now().subtract(Duration(hours: 2)),
    memo: '일회용 수저 빼주세요',
    storeId: 'store_001',
    storeName: '행복한 베이커리',
    imageUrls: [
      'https://picsum.photos/seed/bakery1/400/300',
      'https://picsum.photos/seed/bakery2/400/300',
    ],
    goodsList: [
      OrderGoods(
        orderGoodsId: 'goods_001',
        goodsName: '모닝빵 세트',
        quantity: 2,
        salePrice: 8000,
      ),
      OrderGoods(
        orderGoodsId: 'goods_002',
        goodsName: '크루아상 세트',
        quantity: 1,
        salePrice: 6000,
      ),
    ],
    reviewIds: [],
    payType: '간편결제',
    easyPayProvider: '카카오페이',
  ),
  Order(
    orderId: 'order_002',
    orderStatus: OrderStatus.completed,
    createdAt: DateTime.now().subtract(Duration(days: 1)),
    memo: null,
    storeId: 'store_002',
    storeName: '신선한 샐러드바',
    imageUrls: ['https://picsum.photos/seed/salad1/400/300'],
    goodsList: [
      OrderGoods(
        orderGoodsId: 'goods_003',
        goodsName: '시저 샐러드',
        quantity: 1,
        salePrice: 7500,
      ),
    ],
    reviewIds: ['review_001'],
    payType: '간편결제',
    easyPayProvider: '토스페이',
  ),
  Order(
    orderId: 'order_003',
    orderStatus: OrderStatus.paid,
    createdAt: DateTime.now().subtract(Duration(minutes: 30)),
    memo: '픽업 시간 18:00으로 부탁드려요',
    storeId: 'store_003',
    storeName: '맛있는 도시락',
    imageUrls: [
      'https://picsum.photos/seed/lunchbox1/400/300',
      'https://picsum.photos/seed/lunchbox2/400/300',
      'https://picsum.photos/seed/lunchbox3/400/300',
    ],
    goodsList: [
      OrderGoods(
        orderGoodsId: 'goods_004',
        goodsName: '모듬 도시락',
        quantity: 3,
        salePrice: 15000,
      ),
    ],
    reviewIds: [],
    payType: '간편결제',
    easyPayProvider: '네이버페이',
  ),
];
