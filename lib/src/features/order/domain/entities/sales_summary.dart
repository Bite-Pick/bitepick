import 'package:freezed_annotation/freezed_annotation.dart';

part 'sales_summary.freezed.dart';
part 'sales_summary.g.dart';

@freezed
class SalesSummary with _$SalesSummary {
  const factory SalesSummary({
    required int totalAmount,
    required int totalOrderCount,
    required int monthlyAmount,
    required int monthlyOrderCount,
    required DateTime monthStartDate,
    required DateTime firstSoldAt,
    required DateTime calculatedAt,
  }) = _SalesSummary;

  factory SalesSummary.fromJson(Map<String, dynamic> json) => 
      _$SalesSummaryFromJson(json);
}