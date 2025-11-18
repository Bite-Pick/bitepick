// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_detail.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GoodsDetailDtoImpl _$$GoodsDetailDtoImplFromJson(Map<String, dynamic> json) =>
    _$GoodsDetailDtoImpl(
      storeId: json['storeId'] as String,
      goodsId: json['goodsId'] as String,
      storeName: json['storeName'] as String,
      address: json['address'] as String,
      images: (json['images'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      originalPrice: (json['originalPrice'] as num).toInt(),
      salePrice: (json['salePrice'] as num).toInt(),
      discount: (json['discount'] as num).toInt(),
      description: json['description'] as String,
      quantity: (json['quantity'] as num).toInt(),
      saleStatus: json['saleStatus'] as String,
      reviewCount: (json['reviewCount'] as num).toInt(),
      averageRating: (json['averageRating'] as num).toDouble(),
      parkingDescription: json['parkingDescription'] as String?,
    );

Map<String, dynamic> _$$GoodsDetailDtoImplToJson(
  _$GoodsDetailDtoImpl instance,
) => <String, dynamic>{
  'storeId': instance.storeId,
  'goodsId': instance.goodsId,
  'storeName': instance.storeName,
  'address': instance.address,
  'images': instance.images,
  'startTime': instance.startTime.toIso8601String(),
  'endTime': instance.endTime.toIso8601String(),
  'originalPrice': instance.originalPrice,
  'salePrice': instance.salePrice,
  'discount': instance.discount,
  'description': instance.description,
  'quantity': instance.quantity,
  'saleStatus': instance.saleStatus,
  'reviewCount': instance.reviewCount,
  'averageRating': instance.averageRating,
  'parkingDescription': instance.parkingDescription,
};
