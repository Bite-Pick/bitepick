// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SalesSummaryImpl _$$SalesSummaryImplFromJson(Map<String, dynamic> json) =>
    _$SalesSummaryImpl(
      totalAmount: (json['totalAmount'] as num).toInt(),
      totalOrderCount: (json['totalOrderCount'] as num).toInt(),
      monthlyAmount: (json['monthlyAmount'] as num).toInt(),
      monthlyOrderCount: (json['monthlyOrderCount'] as num).toInt(),
      monthStartDate: DateTime.parse(json['monthStartDate'] as String),
      firstSoldAt: DateTime.parse(json['firstSoldAt'] as String),
      calculatedAt: DateTime.parse(json['calculatedAt'] as String),
    );

Map<String, dynamic> _$$SalesSummaryImplToJson(_$SalesSummaryImpl instance) =>
    <String, dynamic>{
      'totalAmount': instance.totalAmount,
      'totalOrderCount': instance.totalOrderCount,
      'monthlyAmount': instance.monthlyAmount,
      'monthlyOrderCount': instance.monthlyOrderCount,
      'monthStartDate': instance.monthStartDate.toIso8601String(),
      'firstSoldAt': instance.firstSoldAt.toIso8601String(),
      'calculatedAt': instance.calculatedAt.toIso8601String(),
    };
