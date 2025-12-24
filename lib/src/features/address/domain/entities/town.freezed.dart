// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'town.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Town _$TownFromJson(Map<String, dynamic> json) {
  return _Town.fromJson(json);
}

/// @nodoc
mixin _$Town {
  int get regionId => throw _privateConstructorUsedError;
  String get townName => throw _privateConstructorUsedError;

  /// Serializes this Town to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Town
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TownCopyWith<Town> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TownCopyWith<$Res> {
  factory $TownCopyWith(Town value, $Res Function(Town) then) =
      _$TownCopyWithImpl<$Res, Town>;
  @useResult
  $Res call({int regionId, String townName});
}

/// @nodoc
class _$TownCopyWithImpl<$Res, $Val extends Town>
    implements $TownCopyWith<$Res> {
  _$TownCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Town
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? regionId = null, Object? townName = null}) {
    return _then(
      _value.copyWith(
            regionId: null == regionId
                ? _value.regionId
                : regionId // ignore: cast_nullable_to_non_nullable
                      as int,
            townName: null == townName
                ? _value.townName
                : townName // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TownImplCopyWith<$Res> implements $TownCopyWith<$Res> {
  factory _$$TownImplCopyWith(
    _$TownImpl value,
    $Res Function(_$TownImpl) then,
  ) = __$$TownImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int regionId, String townName});
}

/// @nodoc
class __$$TownImplCopyWithImpl<$Res>
    extends _$TownCopyWithImpl<$Res, _$TownImpl>
    implements _$$TownImplCopyWith<$Res> {
  __$$TownImplCopyWithImpl(_$TownImpl _value, $Res Function(_$TownImpl) _then)
    : super(_value, _then);

  /// Create a copy of Town
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? regionId = null, Object? townName = null}) {
    return _then(
      _$TownImpl(
        regionId: null == regionId
            ? _value.regionId
            : regionId // ignore: cast_nullable_to_non_nullable
                  as int,
        townName: null == townName
            ? _value.townName
            : townName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TownImpl implements _Town {
  const _$TownImpl({required this.regionId, required this.townName});

  factory _$TownImpl.fromJson(Map<String, dynamic> json) =>
      _$$TownImplFromJson(json);

  @override
  final int regionId;
  @override
  final String townName;

  @override
  String toString() {
    return 'Town(regionId: $regionId, townName: $townName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TownImpl &&
            (identical(other.regionId, regionId) ||
                other.regionId == regionId) &&
            (identical(other.townName, townName) ||
                other.townName == townName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, regionId, townName);

  /// Create a copy of Town
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TownImplCopyWith<_$TownImpl> get copyWith =>
      __$$TownImplCopyWithImpl<_$TownImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TownImplToJson(this);
  }
}

abstract class _Town implements Town {
  const factory _Town({
    required final int regionId,
    required final String townName,
  }) = _$TownImpl;

  factory _Town.fromJson(Map<String, dynamic> json) = _$TownImpl.fromJson;

  @override
  int get regionId;
  @override
  String get townName;

  /// Create a copy of Town
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TownImplCopyWith<_$TownImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
