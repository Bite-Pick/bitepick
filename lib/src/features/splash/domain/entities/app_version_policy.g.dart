// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_policy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppVersionPolicyImpl _$$AppVersionPolicyImplFromJson(
  Map<String, dynamic> json,
) => _$AppVersionPolicyImpl(
  version: json['minSupportedVersion'] as String,
  releaseNotes: json['releaseNotes'] as String?,
);

Map<String, dynamic> _$$AppVersionPolicyImplToJson(
  _$AppVersionPolicyImpl instance,
) => <String, dynamic>{
  'minSupportedVersion': instance.version,
  'releaseNotes': instance.releaseNotes,
};
