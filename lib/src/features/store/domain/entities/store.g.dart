// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoreImpl _$$StoreImplFromJson(Map<String, dynamic> json) => _$StoreImpl(
  storeId: json['storeId'] as String,
  storeName: json['storeName'] as String,
  address: json['address'] as String,
  storeImageUrls: (json['storeImageUrls'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  goodsList: (json['goodsList'] as List<dynamic>)
      .map((e) => Goods.fromJson(e as Map<String, dynamic>))
      .toList(),
  parkingDescription: json['parkingDescription'] as String?,
  goodsImageList: (json['goodsImageList'] as List<dynamic>?)
      ?.map((e) => GoodsImagesList.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$StoreImplToJson(_$StoreImpl instance) =>
    <String, dynamic>{
      'storeId': instance.storeId,
      'storeName': instance.storeName,
      'address': instance.address,
      'storeImageUrls': instance.storeImageUrls,
      'goodsList': instance.goodsList,
      'parkingDescription': instance.parkingDescription,
      'goodsImageList': instance.goodsImageList,
    };
