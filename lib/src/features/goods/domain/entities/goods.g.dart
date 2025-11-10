// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GoodsImpl _$$GoodsImplFromJson(Map<String, dynamic> json) => _$GoodsImpl(
  goodsId: json['goodsId'] as String,
  storeId: json['storeId'] as String,
  storeName: json['storeName'] as String,
  ImageUrl: (json['ImageUrl'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  address: json['address'] as String,
  goodsName: json['goodsName'] as String?,
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
  originPrice: (json['originPrice'] as num).toInt(),
  discount: (json['discount'] as num).toDouble(),
  salePrice: (json['salePrice'] as num).toDouble(),
  quantity: (json['quantity'] as num).toDouble(),
  distance: (json['distance'] as num).toDouble(),
  saleStatus: json['saleStatus'] as String,
);

Map<String, dynamic> _$$GoodsImplToJson(_$GoodsImpl instance) =>
    <String, dynamic>{
      'goodsId': instance.goodsId,
      'storeId': instance.storeId,
      'storeName': instance.storeName,
      'ImageUrl': instance.ImageUrl,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'goodsName': instance.goodsName,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'originPrice': instance.originPrice,
      'discount': instance.discount,
      'salePrice': instance.salePrice,
      'quantity': instance.quantity,
      'distance': instance.distance,
      'saleStatus': instance.saleStatus,
    };
