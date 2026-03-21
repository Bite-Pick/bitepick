// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registered_store.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GoodsImageItemDtoImpl _$$GoodsImageItemDtoImplFromJson(
  Map<String, dynamic> json,
) => _$GoodsImageItemDtoImpl(
  goodsImageId: json['goodsImageId'] as String,
  imageUrl: json['imageUrl'] as String?,
  key: json['key'] as String? ?? '',
  goodsName: json['goodsName'] as String?,
);

Map<String, dynamic> _$$GoodsImageItemDtoImplToJson(
  _$GoodsImageItemDtoImpl instance,
) => <String, dynamic>{
  'goodsImageId': instance.goodsImageId,
  'imageUrl': instance.imageUrl,
  'key': instance.key,
  'goodsName': instance.goodsName,
};

_$RegisteredStoreDtoImpl _$$RegisteredStoreDtoImplFromJson(
  Map<String, dynamic> json,
) => _$RegisteredStoreDtoImpl(
  storeId: json['storeId'] as String,
  storeName: json['storeName'] as String,
  storeImages:
      (json['storeImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  goodsImageList:
      (json['goodsImageList'] as List<dynamic>?)
          ?.map((e) => GoodsImageItemDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  goodsName: json['goodsName'] as String?,
  description: json['description'] as String?,
  parkingDescription: json['parkingDescription'] as String?,
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
  'storeImages': instance.storeImages,
  'goodsImageList': instance.goodsImageList,
  'goodsName': instance.goodsName,
  'description': instance.description,
  'parkingDescription': instance.parkingDescription,
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
