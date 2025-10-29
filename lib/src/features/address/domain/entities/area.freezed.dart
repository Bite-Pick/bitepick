// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'area.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Area _$AreaFromJson(Map<String, dynamic> json) {
  return _Area.fromJson(json);
}

/// @nodoc
mixin _$Area {
  String get displayName =>
      throw _privateConstructorUsedError; // "서울특별시 강남구 역삼동"
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String? get region1 => throw _privateConstructorUsedError; // 시도 (서울특별시)
  String? get region2 => throw _privateConstructorUsedError; // 시군구 (강남구)
  String? get region3 => throw _privateConstructorUsedError; // 읍면동 (역삼동)
  String? get region4 => throw _privateConstructorUsedError;

  /// Serializes this Area to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Area
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AreaCopyWith<Area> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AreaCopyWith<$Res> {
  factory $AreaCopyWith(Area value, $Res Function(Area) then) =
      _$AreaCopyWithImpl<$Res, Area>;
  @useResult
  $Res call({
    String displayName,
    double latitude,
    double longitude,
    String? region1,
    String? region2,
    String? region3,
    String? region4,
  });
}

/// @nodoc
class _$AreaCopyWithImpl<$Res, $Val extends Area>
    implements $AreaCopyWith<$Res> {
  _$AreaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Area
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? region1 = freezed,
    Object? region2 = freezed,
    Object? region3 = freezed,
    Object? region4 = freezed,
  }) {
    return _then(
      _value.copyWith(
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            region1: freezed == region1
                ? _value.region1
                : region1 // ignore: cast_nullable_to_non_nullable
                      as String?,
            region2: freezed == region2
                ? _value.region2
                : region2 // ignore: cast_nullable_to_non_nullable
                      as String?,
            region3: freezed == region3
                ? _value.region3
                : region3 // ignore: cast_nullable_to_non_nullable
                      as String?,
            region4: freezed == region4
                ? _value.region4
                : region4 // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AreaImplCopyWith<$Res> implements $AreaCopyWith<$Res> {
  factory _$$AreaImplCopyWith(
    _$AreaImpl value,
    $Res Function(_$AreaImpl) then,
  ) = __$$AreaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String displayName,
    double latitude,
    double longitude,
    String? region1,
    String? region2,
    String? region3,
    String? region4,
  });
}

/// @nodoc
class __$$AreaImplCopyWithImpl<$Res>
    extends _$AreaCopyWithImpl<$Res, _$AreaImpl>
    implements _$$AreaImplCopyWith<$Res> {
  __$$AreaImplCopyWithImpl(_$AreaImpl _value, $Res Function(_$AreaImpl) _then)
    : super(_value, _then);

  /// Create a copy of Area
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? region1 = freezed,
    Object? region2 = freezed,
    Object? region3 = freezed,
    Object? region4 = freezed,
  }) {
    return _then(
      _$AreaImpl(
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        region1: freezed == region1
            ? _value.region1
            : region1 // ignore: cast_nullable_to_non_nullable
                  as String?,
        region2: freezed == region2
            ? _value.region2
            : region2 // ignore: cast_nullable_to_non_nullable
                  as String?,
        region3: freezed == region3
            ? _value.region3
            : region3 // ignore: cast_nullable_to_non_nullable
                  as String?,
        region4: freezed == region4
            ? _value.region4
            : region4 // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AreaImpl implements _Area {
  const _$AreaImpl({
    required this.displayName,
    required this.latitude,
    required this.longitude,
    this.region1,
    this.region2,
    this.region3,
    this.region4,
  });

  factory _$AreaImpl.fromJson(Map<String, dynamic> json) =>
      _$$AreaImplFromJson(json);

  @override
  final String displayName;
  // "서울특별시 강남구 역삼동"
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String? region1;
  // 시도 (서울특별시)
  @override
  final String? region2;
  // 시군구 (강남구)
  @override
  final String? region3;
  // 읍면동 (역삼동)
  @override
  final String? region4;

  @override
  String toString() {
    return 'Area(displayName: $displayName, latitude: $latitude, longitude: $longitude, region1: $region1, region2: $region2, region3: $region3, region4: $region4)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AreaImpl &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.region1, region1) || other.region1 == region1) &&
            (identical(other.region2, region2) || other.region2 == region2) &&
            (identical(other.region3, region3) || other.region3 == region3) &&
            (identical(other.region4, region4) || other.region4 == region4));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    displayName,
    latitude,
    longitude,
    region1,
    region2,
    region3,
    region4,
  );

  /// Create a copy of Area
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AreaImplCopyWith<_$AreaImpl> get copyWith =>
      __$$AreaImplCopyWithImpl<_$AreaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AreaImplToJson(this);
  }
}

abstract class _Area implements Area {
  const factory _Area({
    required final String displayName,
    required final double latitude,
    required final double longitude,
    final String? region1,
    final String? region2,
    final String? region3,
    final String? region4,
  }) = _$AreaImpl;

  factory _Area.fromJson(Map<String, dynamic> json) = _$AreaImpl.fromJson;

  @override
  String get displayName; // "서울특별시 강남구 역삼동"
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String? get region1; // 시도 (서울특별시)
  @override
  String? get region2; // 시군구 (강남구)
  @override
  String? get region3; // 읍면동 (역삼동)
  @override
  String? get region4;

  /// Create a copy of Area
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AreaImplCopyWith<_$AreaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
