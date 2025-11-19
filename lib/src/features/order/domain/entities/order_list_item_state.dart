import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/features/order/domain/entities/order_guest_status.dart';

part "order_list_item_state.freezed.dart";

@freezed
class OrderListItemState with _$OrderListItemState {
  const factory OrderListItemState({
    required String orderId,
    required OrderGuestStatus orderStatus,
    required String createdAt,
    required String storeId,
    required List<String> imageUrls,
    required int quantity,
    required int salePrice,
    required String storeName,
    String? goodsName,
    String? memo,
    double? latitude,
    double? longitude,
    int? discount,
    String? address,
  }) = _OrderListItemState;
}

final mockOrderListItemStates = [
  OrderListItemState(
    orderId: 'order-001',
    orderStatus: OrderGuestStatus.accepted,
    createdAt: DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
    storeId: 'store-abc',
    imageUrls: ['https://picsum.photos/id/10/200/300'],
    quantity: 2,
    salePrice: 10000,
    storeName: '맛있는 빵집',
    goodsName: '크루아상 세트',
    address: '서울시 강남구',
  ),
  OrderListItemState(
    orderId: 'order-002',
    orderStatus: OrderGuestStatus.completed,
    createdAt: DateTime.now().subtract(const Duration(days: 3)).toIso8601String(),
    storeId: 'store-def',
    imageUrls: ['https://picsum.photos/id/20/200/300'],
    quantity: 1,
    salePrice: 15000,
    storeName: '신선한 샐러드',
    goodsName: '오늘의 샐러드',
    memo: '문 앞에 놓아주세요',
    address: '서울시 서초구',
  ),
  OrderListItemState(
    orderId: 'order-003',
    orderStatus: OrderGuestStatus.failed,
    createdAt: DateTime.now().subtract(const Duration(hours: 5)).toIso8601String(),
    storeId: 'store-ghi',
    imageUrls: ['https://picsum.photos/id/30/200/300'],
    quantity: 3,
    salePrice: 5000,
    storeName: '달콤한 디저트',
    goodsName: '마카롱 팩',
    address: '서울시 송파구',
  ),
];
