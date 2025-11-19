// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderResponseImpl _$$OrderResponseImplFromJson(Map<String, dynamic> json) =>
    _$OrderResponseImpl(
      merchantUid: json['merchantUid'] as String,
      totalAmount: (json['totalAmount'] as num).toInt(),
    );

Map<String, dynamic> _$$OrderResponseImplToJson(_$OrderResponseImpl instance) =>
    <String, dynamic>{
      'merchantUid': instance.merchantUid,
      'totalAmount': instance.totalAmount,
    };

_$PaymentCompleteRequestImpl _$$PaymentCompleteRequestImplFromJson(
  Map<String, dynamic> json,
) => _$PaymentCompleteRequestImpl(
  impUid: json['impUid'] as String,
  merchantUid: json['merchantUid'] as String,
);

Map<String, dynamic> _$$PaymentCompleteRequestImplToJson(
  _$PaymentCompleteRequestImpl instance,
) => <String, dynamic>{
  'impUid': instance.impUid,
  'merchantUid': instance.merchantUid,
};

_$PaymentCompleteResponseImpl _$$PaymentCompleteResponseImplFromJson(
  Map<String, dynamic> json,
) => _$PaymentCompleteResponseImpl(
  success: json['success'] as bool,
  message: json['message'] as String?,
);

Map<String, dynamic> _$$PaymentCompleteResponseImplToJson(
  _$PaymentCompleteResponseImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
};
