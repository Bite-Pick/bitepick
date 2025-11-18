// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GoodsImpl _$$GoodsImplFromJson(Map<String, dynamic> json) => _$GoodsImpl(
  goodsId: json['goodsId'] as String?,
  storeId: json['storeId'] as String?,
  storeName: json['storeName'] as String?,
  goodsName: json['goodsName'] as String?,
  ImageUrl: (json['ImageUrl'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  distance: (json['distance'] as num?)?.toDouble(),
  address: json['address'] as String?,
  description: json['description'] as String?,
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
  originPrice: (json['originPrice'] as num).toInt(),
  discount: (json['discount'] as num).toInt(),
  salePrice: (json['salePrice'] as num).toInt(),
  stockQuantity: (json['stockQuantity'] as num).toInt(),
  saleStatus: json['saleStatus'] as String,
);

Map<String, dynamic> _$$GoodsImplToJson(_$GoodsImpl instance) =>
    <String, dynamic>{
      'goodsId': instance.goodsId,
      'storeId': instance.storeId,
      'storeName': instance.storeName,
      'goodsName': instance.goodsName,
      'ImageUrl': instance.ImageUrl,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'distance': instance.distance,
      'address': instance.address,
      'description': instance.description,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'originPrice': instance.originPrice,
      'discount': instance.discount,
      'salePrice': instance.salePrice,
      'stockQuantity': instance.stockQuantity,
      'saleStatus': instance.saleStatus,
    };

_$GoodsImagesListImpl _$$GoodsImagesListImplFromJson(
  Map<String, dynamic> json,
) => _$GoodsImagesListImpl(
  goodsImageId: (json['goodsImageId'] as num).toInt(),
  goodsName: json['goodsName'] as String,
  imageUrl: json['imageUrl'] as String,
);

Map<String, dynamic> _$$GoodsImagesListImplToJson(
  _$GoodsImagesListImpl instance,
) => <String, dynamic>{
  'goodsImageId': instance.goodsImageId,
  'goodsName': instance.goodsName,
  'imageUrl': instance.imageUrl,
};
