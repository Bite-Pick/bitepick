// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CityDtoImpl _$$CityDtoImplFromJson(Map<String, dynamic> json) =>
    _$CityDtoImpl(
      regionId: (json['regionId'] as num).toInt(),
      name: json['cityName'] as String,
    );

Map<String, dynamic> _$$CityDtoImplToJson(_$CityDtoImpl instance) =>
    <String, dynamic>{'regionId': instance.regionId, 'cityName': instance.name};

_$DistrictDtoImpl _$$DistrictDtoImplFromJson(Map<String, dynamic> json) =>
    _$DistrictDtoImpl(
      regionId: (json['regionId'] as num).toInt(),
      name: json['districtName'] as String,
    );

Map<String, dynamic> _$$DistrictDtoImplToJson(_$DistrictDtoImpl instance) =>
    <String, dynamic>{
      'regionId': instance.regionId,
      'districtName': instance.name,
    };

_$TownDtoImpl _$$TownDtoImplFromJson(Map<String, dynamic> json) =>
    _$TownDtoImpl(
      regionId: (json['regionId'] as num).toInt(),
      name: json['townName'] as String,
    );

Map<String, dynamic> _$$TownDtoImplToJson(_$TownDtoImpl instance) =>
    <String, dynamic>{'regionId': instance.regionId, 'townName': instance.name};
