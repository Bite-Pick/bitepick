// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registered_store.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegisteredStoreDtoImpl _$$RegisteredStoreDtoImplFromJson(
  Map<String, dynamic> json,
) => _$RegisteredStoreDtoImpl(
  storeId: json['storeId'] as String,
  storeName: json['storeName'] as String,
  imageUrl:
      (json['ImageUrl'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  goodsImages:
      (json['GoodImageUrl'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  goodsName: json['goodsName'] as String?,
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
  originPrice: (json['originPrice'] as num).toInt(),
  discount: (json['discount'] as num).toInt(),
  salePrice: (json['salePrice'] as num).toInt(),
  quantity: (json['quantity'] as num).toInt(),
  distance: (json['distance'] as num?)?.toDouble(),
  saleStatus: json['saleStatus'] as String,
  longitude: (json['longitude'] as num).toDouble(),
  latitude: (json['latitude'] as num).toDouble(),
  address: json['address'] as String,
  ownerName: json['ownerName'] as String,
  ownerPhone: json['ownerPhone'] as String,
  businessNumber: json['businessNumber'] as String,
  bankName: json['bankName'] as String,
  bankAccount: json['bankAccount'] as String,
);

Map<String, dynamic> _$$RegisteredStoreDtoImplToJson(
  _$RegisteredStoreDtoImpl instance,
) => <String, dynamic>{
  'storeId': instance.storeId,
  'storeName': instance.storeName,
  'ImageUrl': instance.imageUrl,
  'GoodImageUrl': instance.goodsImages,
  'goodsName': instance.goodsName,
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'originPrice': instance.originPrice,
  'discount': instance.discount,
  'salePrice': instance.salePrice,
  'quantity': instance.quantity,
  'distance': instance.distance,
  'saleStatus': instance.saleStatus,
  'longitude': instance.longitude,
  'latitude': instance.latitude,
  'address': instance.address,
  'ownerName': instance.ownerName,
  'ownerPhone': instance.ownerPhone,
  'businessNumber': instance.businessNumber,
  'bankName': instance.bankName,
  'bankAccount': instance.bankAccount,
};
