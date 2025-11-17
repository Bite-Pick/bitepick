// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoreListResponseImpl _$$StoreListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$StoreListResponseImpl(
  storeId: json['storeId'] as String,
  storeName: json['storeName'] as String,
  imageUrl: (json['ImageUrl'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  address: json['address'] as String,
  goodsName: json['goodsName'] as String?,
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
  originPrice: (json['originPrice'] as num).toInt(),
  discount: (json['discount'] as num).toInt(),
  salePrice: (json['salePrice'] as num).toInt(),
  quantity: (json['quantity'] as num).toInt(),
  distance: (json['distance'] as num).toDouble(),
  saleStatus: json['saleStatus'] as String,
);

Map<String, dynamic> _$$StoreListResponseImplToJson(
  _$StoreListResponseImpl instance,
) => <String, dynamic>{
  'storeId': instance.storeId,
  'storeName': instance.storeName,
  'ImageUrl': instance.imageUrl,
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
