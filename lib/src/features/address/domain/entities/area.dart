import 'package:freezed_annotation/freezed_annotation.dart';

part 'area.freezed.dart';
part 'area.g.dart';

@freezed
class Area with _$Area {
  const factory Area({
    required String displayName, // "서울특별시 강남구 역삼동"
    required double latitude,
    required double longitude,
    String? region1, // 시도 (서울특별시)
    String? region2, // 시군구 (강남구)
    String? region3, // 읍면동 (역삼동)
    String? region4, // 리 (optional)
  }) = _Area;

  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);
}
