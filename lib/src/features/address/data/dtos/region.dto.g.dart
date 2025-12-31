// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegionDtoImpl _$$RegionDtoImplFromJson(Map<String, dynamic> json) =>
    _$RegionDtoImpl(
      regionId: (json['regionId'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$RegionDtoImplToJson(_$RegionDtoImpl instance) =>
    <String, dynamic>{'regionId': instance.regionId, 'name': instance.name};
