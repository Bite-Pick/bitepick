// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_version_policy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppVersionPolicy _$AppVersionPolicyFromJson(Map<String, dynamic> json) {
  return _AppVersionPolicy.fromJson(json);
}

/// @nodoc
mixin _$AppVersionPolicy {
  String get version => throw _privateConstructorUsedError;
  String? get releaseNotes => throw _privateConstructorUsedError;

  /// Serializes this AppVersionPolicy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppVersionPolicy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppVersionPolicyCopyWith<AppVersionPolicy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppVersionPolicyCopyWith<$Res> {
  factory $AppVersionPolicyCopyWith(
    AppVersionPolicy value,
    $Res Function(AppVersionPolicy) then,
  ) = _$AppVersionPolicyCopyWithImpl<$Res, AppVersionPolicy>;
  @useResult
  $Res call({String version, String? releaseNotes});
}

/// @nodoc
class _$AppVersionPolicyCopyWithImpl<$Res, $Val extends AppVersionPolicy>
    implements $AppVersionPolicyCopyWith<$Res> {
  _$AppVersionPolicyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppVersionPolicy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? version = null, Object? releaseNotes = freezed}) {
    return _then(
      _value.copyWith(
            version: null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as String,
            releaseNotes: freezed == releaseNotes
                ? _value.releaseNotes
                : releaseNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppVersionPolicyImplCopyWith<$Res>
    implements $AppVersionPolicyCopyWith<$Res> {
  factory _$$AppVersionPolicyImplCopyWith(
    _$AppVersionPolicyImpl value,
    $Res Function(_$AppVersionPolicyImpl) then,
  ) = __$$AppVersionPolicyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String version, String? releaseNotes});
}

/// @nodoc
class __$$AppVersionPolicyImplCopyWithImpl<$Res>
    extends _$AppVersionPolicyCopyWithImpl<$Res, _$AppVersionPolicyImpl>
    implements _$$AppVersionPolicyImplCopyWith<$Res> {
  __$$AppVersionPolicyImplCopyWithImpl(
    _$AppVersionPolicyImpl _value,
    $Res Function(_$AppVersionPolicyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppVersionPolicy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? version = null, Object? releaseNotes = freezed}) {
    return _then(
      _$AppVersionPolicyImpl(
        version: null == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as String,
        releaseNotes: freezed == releaseNotes
            ? _value.releaseNotes
            : releaseNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppVersionPolicyImpl implements _AppVersionPolicy {
  const _$AppVersionPolicyImpl({required this.version, this.releaseNotes});

  factory _$AppVersionPolicyImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppVersionPolicyImplFromJson(json);

  @override
  final String version;
  @override
  final String? releaseNotes;

  @override
  String toString() {
    return 'AppVersionPolicy(version: $version, releaseNotes: $releaseNotes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppVersionPolicyImpl &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.releaseNotes, releaseNotes) ||
                other.releaseNotes == releaseNotes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, version, releaseNotes);

  /// Create a copy of AppVersionPolicy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppVersionPolicyImplCopyWith<_$AppVersionPolicyImpl> get copyWith =>
      __$$AppVersionPolicyImplCopyWithImpl<_$AppVersionPolicyImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AppVersionPolicyImplToJson(this);
  }
}

abstract class _AppVersionPolicy implements AppVersionPolicy {
  const factory _AppVersionPolicy({
    required final String version,
    final String? releaseNotes,
  }) = _$AppVersionPolicyImpl;

  factory _AppVersionPolicy.fromJson(Map<String, dynamic> json) =
      _$AppVersionPolicyImpl.fromJson;

  @override
  String get version;
  @override
  String? get releaseNotes;

  /// Create a copy of AppVersionPolicy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppVersionPolicyImplCopyWith<_$AppVersionPolicyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
