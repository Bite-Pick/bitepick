import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

/// 전체 주소 정보 (도로명주소/지번주소)
@freezed
class Address with _$Address {
  const factory Address({
    required String label, 
    required String name, 
    required double latitude,
    required double longitude,
    @Default(false) bool isDefault,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}
