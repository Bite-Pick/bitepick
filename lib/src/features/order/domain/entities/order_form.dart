import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/features/order/domain/entities/payment_method.dart';

part 'order_form.freezed.dart';
part 'order_form.g.dart';

/// 주문서 생성 요청
@freezed
class OrderForm with _$OrderForm {
  const factory OrderForm({
    required int count,
    String? storeId,
    required PaymentMethod paymentMethod,
    required PaymentCompany paymentsCompany,
    required String pickUpTime, // HH:mm 형식
    required String request,
    int? totalPrice,
    String? merchantUid,
  }) = _OrderForm;

  factory OrderForm.fromJson(Map<String, dynamic> json) =>
      _$OrderFormFromJson(json);
}
