// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mypage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Mypage _$MypageFromJson(Map<String, dynamic> json) {
  return _Mypage.fromJson(json);
}

/// @nodoc
mixin _$Mypage {
  int get purchaseCount => throw _privateConstructorUsedError;
  int get savedKg => throw _privateConstructorUsedError;
  int get savedPrice => throw _privateConstructorUsedError;

  /// Serializes this Mypage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Mypage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MypageCopyWith<Mypage> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MypageCopyWith<$Res> {
  factory $MypageCopyWith(Mypage value, $Res Function(Mypage) then) =
      _$MypageCopyWithImpl<$Res, Mypage>;
  @useResult
  $Res call({int purchaseCount, int savedKg, int savedPrice});
}

/// @nodoc
class _$MypageCopyWithImpl<$Res, $Val extends Mypage>
    implements $MypageCopyWith<$Res> {
  _$MypageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Mypage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? purchaseCount = null,
    Object? savedKg = null,
    Object? savedPrice = null,
  }) {
    return _then(
      _value.copyWith(
            purchaseCount: null == purchaseCount
                ? _value.purchaseCount
                : purchaseCount // ignore: cast_nullable_to_non_nullable
                      as int,
            savedKg: null == savedKg
                ? _value.savedKg
                : savedKg // ignore: cast_nullable_to_non_nullable
                      as int,
            savedPrice: null == savedPrice
                ? _value.savedPrice
                : savedPrice // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MypageImplCopyWith<$Res> implements $MypageCopyWith<$Res> {
  factory _$$MypageImplCopyWith(
    _$MypageImpl value,
    $Res Function(_$MypageImpl) then,
  ) = __$$MypageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int purchaseCount, int savedKg, int savedPrice});
}

/// @nodoc
class __$$MypageImplCopyWithImpl<$Res>
    extends _$MypageCopyWithImpl<$Res, _$MypageImpl>
    implements _$$MypageImplCopyWith<$Res> {
  __$$MypageImplCopyWithImpl(
    _$MypageImpl _value,
    $Res Function(_$MypageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Mypage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? purchaseCount = null,
    Object? savedKg = null,
    Object? savedPrice = null,
  }) {
    return _then(
      _$MypageImpl(
        purchaseCount: null == purchaseCount
            ? _value.purchaseCount
            : purchaseCount // ignore: cast_nullable_to_non_nullable
                  as int,
        savedKg: null == savedKg
            ? _value.savedKg
            : savedKg // ignore: cast_nullable_to_non_nullable
                  as int,
        savedPrice: null == savedPrice
            ? _value.savedPrice
            : savedPrice // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MypageImpl implements _Mypage {
  const _$MypageImpl({
    required this.purchaseCount,
    required this.savedKg,
    required this.savedPrice,
  });

  factory _$MypageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MypageImplFromJson(json);

  @override
  final int purchaseCount;
  @override
  final int savedKg;
  @override
  final int savedPrice;

  @override
  String toString() {
    return 'Mypage(purchaseCount: $purchaseCount, savedKg: $savedKg, savedPrice: $savedPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MypageImpl &&
            (identical(other.purchaseCount, purchaseCount) ||
                other.purchaseCount == purchaseCount) &&
            (identical(other.savedKg, savedKg) || other.savedKg == savedKg) &&
            (identical(other.savedPrice, savedPrice) ||
                other.savedPrice == savedPrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, purchaseCount, savedKg, savedPrice);

  /// Create a copy of Mypage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MypageImplCopyWith<_$MypageImpl> get copyWith =>
      __$$MypageImplCopyWithImpl<_$MypageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MypageImplToJson(this);
  }
}

abstract class _Mypage implements Mypage {
  const factory _Mypage({
    required final int purchaseCount,
    required final int savedKg,
    required final int savedPrice,
  }) = _$MypageImpl;

  factory _Mypage.fromJson(Map<String, dynamic> json) = _$MypageImpl.fromJson;

  @override
  int get purchaseCount;
  @override
  int get savedKg;
  @override
  int get savedPrice;

  /// Create a copy of Mypage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MypageImplCopyWith<_$MypageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
