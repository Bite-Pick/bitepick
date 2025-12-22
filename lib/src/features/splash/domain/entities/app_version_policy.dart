import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_version_policy.freezed.dart';
part 'app_version_policy.g.dart';

@freezed
class AppVersionPolicy with _$AppVersionPolicy {
  const factory AppVersionPolicy({
    @JsonKey(name: 'minSupportedVersion') required String version,
    String? releaseNotes,
  }) = _AppVersionPolicy;

  factory AppVersionPolicy.fromJson(Map<String, dynamic> json) =>
      _$AppVersionPolicyFromJson(json);
}
