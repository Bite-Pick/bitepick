import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_response.freezed.dart';
part 'order_response.g.dart';

/// 주문 생성 응답
@freezed
class OrderResponse with _$OrderResponse {
  const factory OrderResponse({
    required String merchantUid,
  }) = _OrderResponse;

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);
}

/// 결제 완료 요청
@freezed
class PaymentCompleteRequest with _$PaymentCompleteRequest {
  const factory PaymentCompleteRequest({
    required String impUid,
    required String merchantUid,
  }) = _PaymentCompleteRequest;

  factory PaymentCompleteRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentCompleteRequestFromJson(json);
}

/// 결제 완료 응답
@freezed
class PaymentCompleteResponse with _$PaymentCompleteResponse {
  const factory PaymentCompleteResponse({
    required bool success,
    String? message,
  }) = _PaymentCompleteResponse;

  factory PaymentCompleteResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentCompleteResponseFromJson(json);
}
