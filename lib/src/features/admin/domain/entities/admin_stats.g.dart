// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminStatsImpl _$$AdminStatsImplFromJson(Map<String, dynamic> json) =>
    _$AdminStatsImpl(
      totalUserCount: (json['totalUserCount'] as num).toInt(),
      totalStoreCount: (json['totalStoreCount'] as num).toInt(),
    );

Map<String, dynamic> _$$AdminStatsImplToJson(_$AdminStatsImpl instance) =>
    <String, dynamic>{
      'totalUserCount': instance.totalUserCount,
      'totalStoreCount': instance.totalStoreCount,
    };
