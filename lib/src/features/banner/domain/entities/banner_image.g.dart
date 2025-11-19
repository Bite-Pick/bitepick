// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BannerImageImpl _$$BannerImageImplFromJson(Map<String, dynamic> json) =>
    _$BannerImageImpl(
      bannerId: (json['bannerId'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
    );

Map<String, dynamic> _$$BannerImageImplToJson(_$BannerImageImpl instance) =>
    <String, dynamic>{
      'bannerId': instance.bannerId,
      'id': instance.id,
      'url': instance.url,
    };
