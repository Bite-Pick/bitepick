// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_guest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderGuestImpl _$$OrderGuestImplFromJson(Map<String, dynamic> json) =>
    _$OrderGuestImpl(
      orderId: json['orderId'] as String,
      orderStatus: $enumDecode(_$OrderStatusEnumMap, json['orderStatus']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      memo: json['memo'] as String?,
      storeId: json['storeId'] as String,
      storeName: json['storeName'] as String,
      imageUrls: (json['imageUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      goodsList: (json['goodsList'] as List<dynamic>)
          .map((e) => OrderGoods.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviewIds: (json['reviewIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      payType: json['payType'] as String,
      easyPayProvider: json['easyPayProvider'] as String?,
    );

Map<String, dynamic> _$$OrderGuestImplToJson(_$OrderGuestImpl instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'orderStatus': _$OrderStatusEnumMap[instance.orderStatus]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'memo': instance.memo,
      'storeId': instance.storeId,
      'storeName': instance.storeName,
      'imageUrls': instance.imageUrls,
      'goodsList': instance.goodsList,
      'reviewIds': instance.reviewIds,
      'payType': instance.payType,
      'easyPayProvider': instance.easyPayProvider,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'PENDING',
  OrderStatus.paid: 'PAID',
  OrderStatus.accepted: 'ACCEPTED',
  OrderStatus.rejected: 'REJECTED',
  OrderStatus.completed: 'COMPLETED',
  OrderStatus.canceled: 'CANCELED',
  OrderStatus.failed: 'FAILED',
};

_$OrderGoodsImpl _$$OrderGoodsImplFromJson(Map<String, dynamic> json) =>
    _$OrderGoodsImpl(
      orderGoodsId: json['orderGoodsId'] as String,
      goodsName: json['goodsName'] as String,
      quantity: (json['quantity'] as num).toInt(),
      salePrice: (json['salePrice'] as num).toInt(),
    );

Map<String, dynamic> _$$OrderGoodsImplToJson(_$OrderGoodsImpl instance) =>
    <String, dynamic>{
      'orderGoodsId': instance.orderGoodsId,
      'goodsName': instance.goodsName,
      'quantity': instance.quantity,
      'salePrice': instance.salePrice,
    };
