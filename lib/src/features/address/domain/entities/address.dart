import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

/// 전체 주소 정보 (도로명주소/지번주소)
@freezed
class Address with _$Address {
  const factory Address({
    required int id,
    required String label,
    required String name,
    required double latitude,
    required double longitude,
    @Default(false) bool isDefault,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

final mockAddress = Address(
  id: 2,
  label: '경기도 용인시 기흥구 보정동',
  name: '경기도 용인시 기흥구 보정동',
  latitude: 37.320165,
  longitude: 127.112962,
);
