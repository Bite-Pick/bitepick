import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_stats.freezed.dart';
part 'admin_stats.g.dart';

@freezed
class AdminStats with _$AdminStats {
  const factory AdminStats({
    required int totalUserCount,
    required int totalStoreCount,
  }) = _AdminStats;

  factory AdminStats.fromJson(Map<String, dynamic> json) =>
      _$AdminStatsFromJson(json);
}
