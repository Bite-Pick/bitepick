// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_store_list.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FavoriteStoreListDTOImpl _$$FavoriteStoreListDTOImplFromJson(
  Map<String, dynamic> json,
) => _$FavoriteStoreListDTOImpl(
  storeId: json['storeId'] as String,
  storeName: json['storeName'] as String,
  address: json['address'] as String,
  imageUrl: (json['ImageUrl'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
  originPrice: (json['originPrice'] as num).toInt(),
  discount: (json['discount'] as num).toInt(),
  salePrice: (json['salePrice'] as num).toInt(),
  quantity: (json['quantity'] as num).toInt(),
  saleStatus: json['saleStatus'] as String,
  goodsName: json['goodsName'] as String?,
);

Map<String, dynamic> _$$FavoriteStoreListDTOImplToJson(
  _$FavoriteStoreListDTOImpl instance,
) => <String, dynamic>{
  'storeId': instance.storeId,
  'storeName': instance.storeName,
  'address': instance.address,
  'ImageUrl': instance.imageUrl,
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'originPrice': instance.originPrice,
  'discount': instance.discount,
  'salePrice': instance.salePrice,
  'quantity': instance.quantity,
  'saleStatus': instance.saleStatus,
  'goodsName': instance.goodsName,
};
