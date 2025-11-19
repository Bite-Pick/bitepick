// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderFormImpl _$$OrderFormImplFromJson(Map<String, dynamic> json) =>
    _$OrderFormImpl(
      count: (json['count'] as num).toInt(),
      storeId: json['storeId'] as String,
      paymentMethod: $enumDecode(_$PaymentMethodEnumMap, json['paymentMethod']),
      paymentsCompany: $enumDecode(
        _$PaymentCompanyEnumMap,
        json['paymentsCompany'],
      ),
      pickUpTime: json['pickUpTime'] as String,
      request: json['request'] as String?,
      totalPrice: (json['totalPrice'] as num?)?.toInt(),
      merchantUid: json['merchantUid'] as String?,
    );

Map<String, dynamic> _$$OrderFormImplToJson(_$OrderFormImpl instance) =>
    <String, dynamic>{
      'count': instance.count,
      'storeId': instance.storeId,
      'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod]!,
      'paymentsCompany': _$PaymentCompanyEnumMap[instance.paymentsCompany]!,
      'pickUpTime': instance.pickUpTime,
      'request': instance.request,
      'totalPrice': instance.totalPrice,
      'merchantUid': instance.merchantUid,
    };

const _$PaymentMethodEnumMap = {
  PaymentMethod.easyPay: 'easyPay',
  PaymentMethod.card: 'card',
};

const _$PaymentCompanyEnumMap = {
  PaymentCompany.naver: 'naver',
  PaymentCompany.kakao: 'kakao',
  PaymentCompany.toss: 'toss',
};
