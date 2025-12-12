// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_list.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderListDTOImpl _$$OrderListDTOImplFromJson(Map<String, dynamic> json) =>
    _$OrderListDTOImpl(
      orderId: json['orderId'] as String,
      orderStatus: $enumDecode(_$OrderGuestStatusEnumMap, json['orderStatus']),
      createdAt: json['createdAt'] as String,
      storeId: json['storeId'] as String,
      storeName: json['storeName'] as String,
      imageUrls: (json['imageUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      goodsList: (json['goodsList'] as List<dynamic>)
          .map((e) => OrderGoodsDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviewIds: (json['reviewIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      payType: json['payType'] as String?,
      easyPayProvider: json['easyPayProvider'] as String?,
      pickupTime: json['pickupTime'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      memo: json['memo'] as String?,
      discount: (json['discount'] as num?)?.toInt(),
      address: json['address'] as String?,
      isReviewWritten: json['isReviewWritten'] as bool,
    );

Map<String, dynamic> _$$OrderListDTOImplToJson(_$OrderListDTOImpl instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'orderStatus': _$OrderGuestStatusEnumMap[instance.orderStatus]!,
      'createdAt': instance.createdAt,
      'storeId': instance.storeId,
      'storeName': instance.storeName,
      'imageUrls': instance.imageUrls,
      'goodsList': instance.goodsList,
      'reviewIds': instance.reviewIds,
      'payType': instance.payType,
      'easyPayProvider': instance.easyPayProvider,
      'pickupTime': instance.pickupTime,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'memo': instance.memo,
      'discount': instance.discount,
      'address': instance.address,
      'isReviewWritten': instance.isReviewWritten,
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

_$OrderGoodsDTOImpl _$$OrderGoodsDTOImplFromJson(Map<String, dynamic> json) =>
    _$OrderGoodsDTOImpl(
      orderGoodsId: json['orderGoodsId'] as String,
      goodsName: json['goodsName'] as String?,
      quantity: (json['quantity'] as num).toInt(),
      salePrice: (json['salePrice'] as num).toInt(),
    );

Map<String, dynamic> _$$OrderGoodsDTOImplToJson(_$OrderGoodsDTOImpl instance) =>
    <String, dynamic>{
      'orderGoodsId': instance.orderGoodsId,
      'goodsName': instance.goodsName,
      'quantity': instance.quantity,
      'salePrice': instance.salePrice,
    };
