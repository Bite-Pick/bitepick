// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderDetailDTOImpl _$$OrderDetailDTOImplFromJson(Map<String, dynamic> json) =>
    _$OrderDetailDTOImpl(
      orderId: json['orderId'] as String,
      orderGoodsId: json['orderGoodsId'] as String,
      orderStatus: $enumDecode(_$OrderGuestStatusEnumMap, json['orderStatus']),
      storeName: json['storeName'] as String,
      storeAddress: json['storeAddress'] as String,
      imageUrl: json['imageUrl'] as String,
      quantity: (json['quantity'] as num).toInt(),
      totalPrice: (json['totalPrice'] as num).toInt(),
      pickupTime: json['pickupTime'] as String,
      createdAt: json['createdAt'] as String,
      storeId: json['storeId'] as String,
      payType: json['payType'] as String,
      easyPayProvider: json['easyPayProvider'] as String,
      reviewId: json['reviewId'] as String?,
      memo: json['memo'] as String?,
    );

Map<String, dynamic> _$$OrderDetailDTOImplToJson(
  _$OrderDetailDTOImpl instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'orderGoodsId': instance.orderGoodsId,
  'orderStatus': _$OrderGuestStatusEnumMap[instance.orderStatus]!,
  'storeName': instance.storeName,
  'storeAddress': instance.storeAddress,
  'imageUrl': instance.imageUrl,
  'quantity': instance.quantity,
  'totalPrice': instance.totalPrice,
  'pickupTime': instance.pickupTime,
  'createdAt': instance.createdAt,
  'storeId': instance.storeId,
  'payType': instance.payType,
  'easyPayProvider': instance.easyPayProvider,
  'reviewId': instance.reviewId,
  'memo': instance.memo,
};

const _$OrderGuestStatusEnumMap = {
  OrderGuestStatus.pending: 'PENDING',
  OrderGuestStatus.paid: 'PAID',
  OrderGuestStatus.accepted: 'ACCEPTED',
  OrderGuestStatus.rejected: 'REJECTED',
  OrderGuestStatus.completed: 'COMPLETED',
  OrderGuestStatus.canceled: 'CANCELED',
  OrderGuestStatus.failed: 'FAILED',
};
