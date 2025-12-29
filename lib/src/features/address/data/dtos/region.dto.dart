import 'package:freezed_annotation/freezed_annotation.dart';

part 'region.dto.freezed.dart';
part 'region.dto.g.dart';

@freezed
class CityDto with _$CityDto {
  const factory CityDto({
    required int regionId,
    @JsonKey(name: 'cityName') required String name,
  }) = _CityDto;

  factory CityDto.fromJson(Map<String, dynamic> json) =>
      _$CityDtoFromJson(json);
}

@freezed
class DistrictDto with _$DistrictDto {
  const factory DistrictDto({
    required int regionId,
    @JsonKey(name: 'districtName') required String name,
  }) = _DistrictDto;

  factory DistrictDto.fromJson(Map<String, dynamic> json) =>
      _$DistrictDtoFromJson(json);
}

@freezed
class TownDto with _$TownDto {
  const factory TownDto({
    required int regionId,
    @JsonKey(name: 'townName') required String name,
  }) = _TownDto;

  factory TownDto.fromJson(Map<String, dynamic> json) =>
      _$TownDtoFromJson(json);
}
