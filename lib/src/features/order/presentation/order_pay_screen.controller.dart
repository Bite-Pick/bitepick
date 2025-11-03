import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_pay_screen.controller.g.dart';

class OrderInfo {
  final String goodsId;
  final int quantity;
  final double totalPrice;
  final double salePrice;
  final double originalPrice;

  OrderInfo({
    required this.goodsId,
    required this.quantity,
    required this.totalPrice,
    required this.salePrice,
    required this.originalPrice,
  });

  OrderInfo copyWith({
    String? goodsId,
    int? quantity,
    double? totalPrice,
    double? salePrice,
    double? originalPrice,
  }) {
    return OrderInfo(
      goodsId: goodsId ?? this.goodsId,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      salePrice: salePrice ?? this.salePrice,
      originalPrice: originalPrice ?? this.originalPrice,
    );
  }

  double get discount => originalPrice - salePrice;
}

@Riverpod(keepAlive: true)
class OrderPayScreenController extends _$OrderPayScreenController {
  @override
  OrderInfo build() {
    return OrderInfo(
      goodsId: '',
      quantity: 0,
      totalPrice: 0,
      salePrice: 0,
      originalPrice: 0,
    );
  }

  void setOrderInfo({
    required String goodsId,
    required int quantity,
    required double totalPrice,
    required double salePrice,
    required double originalPrice,
  }) {
    state = OrderInfo(
      goodsId: goodsId,
      quantity: quantity,
      totalPrice: totalPrice,
      salePrice: salePrice,
      originalPrice: originalPrice,
    );
  }

  void updateQuantity(int quantity) {
    state = state.copyWith(
      quantity: quantity,
      totalPrice: state.salePrice * quantity,
    );
  }
}
