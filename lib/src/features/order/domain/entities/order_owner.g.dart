// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_owner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderOwnerImpl _$$OrderOwnerImplFromJson(Map<String, dynamic> json) =>
    _$OrderOwnerImpl(
      orderId: json['orderId'] as String,
      orderStatus: $enumDecode(_$OrderOwnerStatusEnumMap, json['orderStatus']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      pickupTime: DateTime.parse(json['pickupTime'] as String),
      memo: json['memo'] as String?,
      quantity: (json['quantity'] as num).toInt(),
      totalPrice: (json['totalPrice'] as num).toInt(),
      phoneNumber: json['phoneNumber'] as String,
      goodsName: json['goodsName'] as String?,
    );

Map<String, dynamic> _$$OrderOwnerImplToJson(_$OrderOwnerImpl instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'orderStatus': _$OrderOwnerStatusEnumMap[instance.orderStatus]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'pickupTime': instance.pickupTime.toIso8601String(),
      'memo': instance.memo,
      'quantity': instance.quantity,
      'totalPrice': instance.totalPrice,
      'phoneNumber': instance.phoneNumber,
      'goodsName': instance.goodsName,
    };

const _$OrderOwnerStatusEnumMap = {
  OrderOwnerStatus.PAID: 'PAID',
  OrderOwnerStatus.ACCEPTED: 'ACCEPTED',
  OrderOwnerStatus.COMPLETED: 'COMPLETED',
  OrderOwnerStatus.CANCELED: 'CANCELED',
  OrderOwnerStatus.REJECTED: 'REJECTED',
};
