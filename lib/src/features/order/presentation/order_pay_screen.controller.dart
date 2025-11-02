import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_pay_screen.controller.g.dart';

class OrderInfo {
  final String goodsId;
  final int quantity;
  final int totalPrice;

  OrderInfo({
    required this.goodsId,
    required this.quantity,
    required this.totalPrice,
  });

  OrderInfo copyWith({
    String? goodsId,
    int? quantity,
    int? totalPrice,
  }) {
    return OrderInfo(
      goodsId: goodsId ?? this.goodsId,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}

@riverpod
class OrderPayScreenController extends _$OrderPayScreenController {
  @override
  OrderInfo build() {
    return OrderInfo(
      goodsId: '',
      quantity: 0,
      totalPrice: 0,
    );
  }

  void setOrderInfo({
    required String goodsId,
    required int quantity,
    required int totalPrice,
  }) {
    state = OrderInfo(
      goodsId: goodsId,
      quantity: quantity,
      totalPrice: totalPrice,
    );
  }

  void updateQuantity(int quantity, int pricePerItem) {
    state = state.copyWith(
      quantity: quantity,
      totalPrice: pricePerItem * quantity,
    );
  }
}
