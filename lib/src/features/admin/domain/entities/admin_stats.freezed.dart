// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AdminStats _$AdminStatsFromJson(Map<String, dynamic> json) {
  return _AdminStats.fromJson(json);
}

/// @nodoc
mixin _$AdminStats {
  int get totalUserCount => throw _privateConstructorUsedError;
  int get totalStoreCount => throw _privateConstructorUsedError;

  /// Serializes this AdminStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminStatsCopyWith<AdminStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminStatsCopyWith<$Res> {
  factory $AdminStatsCopyWith(
    AdminStats value,
    $Res Function(AdminStats) then,
  ) = _$AdminStatsCopyWithImpl<$Res, AdminStats>;
  @useResult
  $Res call({int totalUserCount, int totalStoreCount});
}

/// @nodoc
class _$AdminStatsCopyWithImpl<$Res, $Val extends AdminStats>
    implements $AdminStatsCopyWith<$Res> {
  _$AdminStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? totalUserCount = null, Object? totalStoreCount = null}) {
    return _then(
      _value.copyWith(
            totalUserCount: null == totalUserCount
                ? _value.totalUserCount
                : totalUserCount // ignore: cast_nullable_to_non_nullable
                      as int,
            totalStoreCount: null == totalStoreCount
                ? _value.totalStoreCount
                : totalStoreCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AdminStatsImplCopyWith<$Res>
    implements $AdminStatsCopyWith<$Res> {
  factory _$$AdminStatsImplCopyWith(
    _$AdminStatsImpl value,
    $Res Function(_$AdminStatsImpl) then,
  ) = __$$AdminStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int totalUserCount, int totalStoreCount});
}

/// @nodoc
class __$$AdminStatsImplCopyWithImpl<$Res>
    extends _$AdminStatsCopyWithImpl<$Res, _$AdminStatsImpl>
    implements _$$AdminStatsImplCopyWith<$Res> {
  __$$AdminStatsImplCopyWithImpl(
    _$AdminStatsImpl _value,
    $Res Function(_$AdminStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? totalUserCount = null, Object? totalStoreCount = null}) {
    return _then(
      _$AdminStatsImpl(
        totalUserCount: null == totalUserCount
            ? _value.totalUserCount
            : totalUserCount // ignore: cast_nullable_to_non_nullable
                  as int,
        totalStoreCount: null == totalStoreCount
            ? _value.totalStoreCount
            : totalStoreCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminStatsImpl implements _AdminStats {
  const _$AdminStatsImpl({
    required this.totalUserCount,
    required this.totalStoreCount,
  });

  factory _$AdminStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminStatsImplFromJson(json);

  @override
  final int totalUserCount;
  @override
  final int totalStoreCount;

  @override
  String toString() {
    return 'AdminStats(totalUserCount: $totalUserCount, totalStoreCount: $totalStoreCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminStatsImpl &&
            (identical(other.totalUserCount, totalUserCount) ||
                other.totalUserCount == totalUserCount) &&
            (identical(other.totalStoreCount, totalStoreCount) ||
                other.totalStoreCount == totalStoreCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalUserCount, totalStoreCount);

  /// Create a copy of AdminStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminStatsImplCopyWith<_$AdminStatsImpl> get copyWith =>
      __$$AdminStatsImplCopyWithImpl<_$AdminStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminStatsImplToJson(this);
  }
}

abstract class _AdminStats implements AdminStats {
  const factory _AdminStats({
    required final int totalUserCount,
    required final int totalStoreCount,
  }) = _$AdminStatsImpl;

  factory _AdminStats.fromJson(Map<String, dynamic> json) =
      _$AdminStatsImpl.fromJson;

  @override
  int get totalUserCount;
  @override
  int get totalStoreCount;

  /// Create a copy of AdminStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminStatsImplCopyWith<_$AdminStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
