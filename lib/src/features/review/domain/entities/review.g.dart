// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) => _$ReviewImpl(
  reviewId: json['reviewId'] as String,
  rating: (json['rating'] as num).toInt(),
  satisfactionReasons: (json['satisfactionReasons'] as List<dynamic>)
      .map((e) => $enumDecode(_$SatisfactionTypeEnumMap, e))
      .toList(),
  description: json['description'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  imageUrls: (json['imageUrls'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  nickName: json['nickName'] as String,
  goodsId: json['goodsId'] as String,
  storeId: json['storeId'] as String,
  storeName: json['storeName'] as String,
);

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'reviewId': instance.reviewId,
      'rating': instance.rating,
      'satisfactionReasons': instance.satisfactionReasons
          .map((e) => _$SatisfactionTypeEnumMap[e]!)
          .toList(),
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'imageUrls': instance.imageUrls,
      'nickName': instance.nickName,
      'goodsId': instance.goodsId,
      'storeId': instance.storeId,
      'storeName': instance.storeName,
    };

const _$SatisfactionTypeEnumMap = {
  SatisfactionType.variety: 'VARIETY',
  SatisfactionType.affordable: 'AFFORDABLE',
  SatisfactionType.friendly: 'FRIENDLY',
  SatisfactionType.zero: 'ZERO',
};
