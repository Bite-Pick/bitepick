// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AreaImpl _$$AreaImplFromJson(Map<String, dynamic> json) => _$AreaImpl(
  displayName: json['displayName'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  region1: json['region1'] as String?,
  region2: json['region2'] as String?,
  region3: json['region3'] as String?,
  region4: json['region4'] as String?,
);

Map<String, dynamic> _$$AreaImplToJson(_$AreaImpl instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'region1': instance.region1,
      'region2': instance.region2,
      'region3': instance.region3,
      'region4': instance.region4,
    };
