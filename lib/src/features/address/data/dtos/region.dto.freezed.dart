// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'region.dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CityDto _$CityDtoFromJson(Map<String, dynamic> json) {
  return _CityDto.fromJson(json);
}

/// @nodoc
mixin _$CityDto {
  int get regionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'cityName')
  String get name => throw _privateConstructorUsedError;

  /// Serializes this CityDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CityDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CityDtoCopyWith<CityDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CityDtoCopyWith<$Res> {
  factory $CityDtoCopyWith(CityDto value, $Res Function(CityDto) then) =
      _$CityDtoCopyWithImpl<$Res, CityDto>;
  @useResult
  $Res call({int regionId, @JsonKey(name: 'cityName') String name});
}

/// @nodoc
class _$CityDtoCopyWithImpl<$Res, $Val extends CityDto>
    implements $CityDtoCopyWith<$Res> {
  _$CityDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CityDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? regionId = null, Object? name = null}) {
    return _then(
      _value.copyWith(
            regionId: null == regionId
                ? _value.regionId
                : regionId // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CityDtoImplCopyWith<$Res> implements $CityDtoCopyWith<$Res> {
  factory _$$CityDtoImplCopyWith(
    _$CityDtoImpl value,
    $Res Function(_$CityDtoImpl) then,
  ) = __$$CityDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int regionId, @JsonKey(name: 'cityName') String name});
}

/// @nodoc
class __$$CityDtoImplCopyWithImpl<$Res>
    extends _$CityDtoCopyWithImpl<$Res, _$CityDtoImpl>
    implements _$$CityDtoImplCopyWith<$Res> {
  __$$CityDtoImplCopyWithImpl(
    _$CityDtoImpl _value,
    $Res Function(_$CityDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CityDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? regionId = null, Object? name = null}) {
    return _then(
      _$CityDtoImpl(
        regionId: null == regionId
            ? _value.regionId
            : regionId // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CityDtoImpl implements _CityDto {
  const _$CityDtoImpl({
    required this.regionId,
    @JsonKey(name: 'cityName') required this.name,
  });

  factory _$CityDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CityDtoImplFromJson(json);

  @override
  final int regionId;
  @override
  @JsonKey(name: 'cityName')
  final String name;

  @override
  String toString() {
    return 'CityDto(regionId: $regionId, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CityDtoImpl &&
            (identical(other.regionId, regionId) ||
                other.regionId == regionId) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, regionId, name);

  /// Create a copy of CityDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CityDtoImplCopyWith<_$CityDtoImpl> get copyWith =>
      __$$CityDtoImplCopyWithImpl<_$CityDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CityDtoImplToJson(this);
  }
}

abstract class _CityDto implements CityDto {
  const factory _CityDto({
    required final int regionId,
    @JsonKey(name: 'cityName') required final String name,
  }) = _$CityDtoImpl;

  factory _CityDto.fromJson(Map<String, dynamic> json) = _$CityDtoImpl.fromJson;

  @override
  int get regionId;
  @override
  @JsonKey(name: 'cityName')
  String get name;

  /// Create a copy of CityDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CityDtoImplCopyWith<_$CityDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DistrictDto _$DistrictDtoFromJson(Map<String, dynamic> json) {
  return _DistrictDto.fromJson(json);
}

/// @nodoc
mixin _$DistrictDto {
  int get regionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'districtName')
  String get name => throw _privateConstructorUsedError;

  /// Serializes this DistrictDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DistrictDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DistrictDtoCopyWith<DistrictDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DistrictDtoCopyWith<$Res> {
  factory $DistrictDtoCopyWith(
    DistrictDto value,
    $Res Function(DistrictDto) then,
  ) = _$DistrictDtoCopyWithImpl<$Res, DistrictDto>;
  @useResult
  $Res call({int regionId, @JsonKey(name: 'districtName') String name});
}

/// @nodoc
class _$DistrictDtoCopyWithImpl<$Res, $Val extends DistrictDto>
    implements $DistrictDtoCopyWith<$Res> {
  _$DistrictDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DistrictDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? regionId = null, Object? name = null}) {
    return _then(
      _value.copyWith(
            regionId: null == regionId
                ? _value.regionId
                : regionId // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DistrictDtoImplCopyWith<$Res>
    implements $DistrictDtoCopyWith<$Res> {
  factory _$$DistrictDtoImplCopyWith(
    _$DistrictDtoImpl value,
    $Res Function(_$DistrictDtoImpl) then,
  ) = __$$DistrictDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int regionId, @JsonKey(name: 'districtName') String name});
}

/// @nodoc
class __$$DistrictDtoImplCopyWithImpl<$Res>
    extends _$DistrictDtoCopyWithImpl<$Res, _$DistrictDtoImpl>
    implements _$$DistrictDtoImplCopyWith<$Res> {
  __$$DistrictDtoImplCopyWithImpl(
    _$DistrictDtoImpl _value,
    $Res Function(_$DistrictDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DistrictDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? regionId = null, Object? name = null}) {
    return _then(
      _$DistrictDtoImpl(
        regionId: null == regionId
            ? _value.regionId
            : regionId // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DistrictDtoImpl implements _DistrictDto {
  const _$DistrictDtoImpl({
    required this.regionId,
    @JsonKey(name: 'districtName') required this.name,
  });

  factory _$DistrictDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DistrictDtoImplFromJson(json);

  @override
  final int regionId;
  @override
  @JsonKey(name: 'districtName')
  final String name;

  @override
  String toString() {
    return 'DistrictDto(regionId: $regionId, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DistrictDtoImpl &&
            (identical(other.regionId, regionId) ||
                other.regionId == regionId) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, regionId, name);

  /// Create a copy of DistrictDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DistrictDtoImplCopyWith<_$DistrictDtoImpl> get copyWith =>
      __$$DistrictDtoImplCopyWithImpl<_$DistrictDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DistrictDtoImplToJson(this);
  }
}

abstract class _DistrictDto implements DistrictDto {
  const factory _DistrictDto({
    required final int regionId,
    @JsonKey(name: 'districtName') required final String name,
  }) = _$DistrictDtoImpl;

  factory _DistrictDto.fromJson(Map<String, dynamic> json) =
      _$DistrictDtoImpl.fromJson;

  @override
  int get regionId;
  @override
  @JsonKey(name: 'districtName')
  String get name;

  /// Create a copy of DistrictDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DistrictDtoImplCopyWith<_$DistrictDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TownDto _$TownDtoFromJson(Map<String, dynamic> json) {
  return _TownDto.fromJson(json);
}

/// @nodoc
mixin _$TownDto {
  int get regionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'townName')
  String get name => throw _privateConstructorUsedError;

  /// Serializes this TownDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TownDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TownDtoCopyWith<TownDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TownDtoCopyWith<$Res> {
  factory $TownDtoCopyWith(TownDto value, $Res Function(TownDto) then) =
      _$TownDtoCopyWithImpl<$Res, TownDto>;
  @useResult
  $Res call({int regionId, @JsonKey(name: 'townName') String name});
}

/// @nodoc
class _$TownDtoCopyWithImpl<$Res, $Val extends TownDto>
    implements $TownDtoCopyWith<$Res> {
  _$TownDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TownDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? regionId = null, Object? name = null}) {
    return _then(
      _value.copyWith(
            regionId: null == regionId
                ? _value.regionId
                : regionId // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TownDtoImplCopyWith<$Res> implements $TownDtoCopyWith<$Res> {
  factory _$$TownDtoImplCopyWith(
    _$TownDtoImpl value,
    $Res Function(_$TownDtoImpl) then,
  ) = __$$TownDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int regionId, @JsonKey(name: 'townName') String name});
}

/// @nodoc
class __$$TownDtoImplCopyWithImpl<$Res>
    extends _$TownDtoCopyWithImpl<$Res, _$TownDtoImpl>
    implements _$$TownDtoImplCopyWith<$Res> {
  __$$TownDtoImplCopyWithImpl(
    _$TownDtoImpl _value,
    $Res Function(_$TownDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TownDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? regionId = null, Object? name = null}) {
    return _then(
      _$TownDtoImpl(
        regionId: null == regionId
            ? _value.regionId
            : regionId // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TownDtoImpl implements _TownDto {
  const _$TownDtoImpl({
    required this.regionId,
    @JsonKey(name: 'townName') required this.name,
  });

  factory _$TownDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TownDtoImplFromJson(json);

  @override
  final int regionId;
  @override
  @JsonKey(name: 'townName')
  final String name;

  @override
  String toString() {
    return 'TownDto(regionId: $regionId, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TownDtoImpl &&
            (identical(other.regionId, regionId) ||
                other.regionId == regionId) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, regionId, name);

  /// Create a copy of TownDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TownDtoImplCopyWith<_$TownDtoImpl> get copyWith =>
      __$$TownDtoImplCopyWithImpl<_$TownDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TownDtoImplToJson(this);
  }
}

abstract class _TownDto implements TownDto {
  const factory _TownDto({
    required final int regionId,
    @JsonKey(name: 'townName') required final String name,
  }) = _$TownDtoImpl;

  factory _TownDto.fromJson(Map<String, dynamic> json) = _$TownDtoImpl.fromJson;

  @override
  int get regionId;
  @override
  @JsonKey(name: 'townName')
  String get name;

  /// Create a copy of TownDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TownDtoImplCopyWith<_$TownDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
