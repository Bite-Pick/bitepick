import 'package:freezed_annotation/freezed_annotation.dart';

part 'town.freezed.dart';
part 'town.g.dart';

@freezed
class Town with _$Town {
  const factory Town({required int regionId, required String townName}) = _Town;

  factory Town.fromJson(Map<String, dynamic> json) => _$TownFromJson(json);
}
