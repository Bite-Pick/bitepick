import 'package:freezed_annotation/freezed_annotation.dart';

part 'region.freezed.dart';

@freezed
class Region with _$Region {
  const Region._();

  const factory Region({
    required int id,
    required String name,
  }) = _Region;

  String get displayName {
    return name.replaceAllMapped(
      RegExp(r'(시)([^ ])'),
      (match) => '${match.group(1)} ${match.group(2)}',
    );
  }
}
