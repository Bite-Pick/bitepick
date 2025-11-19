// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_pay_screen.controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OrderInfo {
  String get storeId => throw _privateConstructorUsedError;
  String get storeAddress => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  int get totalPrice => throw _privateConstructorUsedError;
  int get salePrice => throw _privateConstructorUsedError;
  int get originalPrice => throw _privateConstructorUsedError;
  String get pickUpTime => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  String? get merchantUid => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of OrderInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderInfoCopyWith<OrderInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderInfoCopyWith<$Res> {
  factory $OrderInfoCopyWith(OrderInfo value, $Res Function(OrderInfo) then) =
      _$OrderInfoCopyWithImpl<$Res, OrderInfo>;
  @useResult
  $Res call({
    String storeId,
    String storeAddress,
    int quantity,
    int totalPrice,
    int salePrice,
    int originalPrice,
    String pickUpTime,
    bool isSubmitting,
    String? merchantUid,
    String? error,
  });
}

/// @nodoc
class _$OrderInfoCopyWithImpl<$Res, $Val extends OrderInfo>
    implements $OrderInfoCopyWith<$Res> {
  _$OrderInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? storeAddress = null,
    Object? quantity = null,
    Object? totalPrice = null,
    Object? salePrice = null,
    Object? originalPrice = null,
    Object? pickUpTime = null,
    Object? isSubmitting = null,
    Object? merchantUid = freezed,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            storeId: null == storeId
                ? _value.storeId
                : storeId // ignore: cast_nullable_to_non_nullable
                      as String,
            storeAddress: null == storeAddress
                ? _value.storeAddress
                : storeAddress // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPrice: null == totalPrice
                ? _value.totalPrice
                : totalPrice // ignore: cast_nullable_to_non_nullable
                      as int,
            salePrice: null == salePrice
                ? _value.salePrice
                : salePrice // ignore: cast_nullable_to_non_nullable
                      as int,
            originalPrice: null == originalPrice
                ? _value.originalPrice
                : originalPrice // ignore: cast_nullable_to_non_nullable
                      as int,
            pickUpTime: null == pickUpTime
                ? _value.pickUpTime
                : pickUpTime // ignore: cast_nullable_to_non_nullable
                      as String,
            isSubmitting: null == isSubmitting
                ? _value.isSubmitting
                : isSubmitting // ignore: cast_nullable_to_non_nullable
                      as bool,
            merchantUid: freezed == merchantUid
                ? _value.merchantUid
                : merchantUid // ignore: cast_nullable_to_non_nullable
                      as String?,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderInfoImplCopyWith<$Res>
    implements $OrderInfoCopyWith<$Res> {
  factory _$$OrderInfoImplCopyWith(
    _$OrderInfoImpl value,
    $Res Function(_$OrderInfoImpl) then,
  ) = __$$OrderInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String storeId,
    String storeAddress,
    int quantity,
    int totalPrice,
    int salePrice,
    int originalPrice,
    String pickUpTime,
    bool isSubmitting,
    String? merchantUid,
    String? error,
  });
}

/// @nodoc
class __$$OrderInfoImplCopyWithImpl<$Res>
    extends _$OrderInfoCopyWithImpl<$Res, _$OrderInfoImpl>
    implements _$$OrderInfoImplCopyWith<$Res> {
  __$$OrderInfoImplCopyWithImpl(
    _$OrderInfoImpl _value,
    $Res Function(_$OrderInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? storeAddress = null,
    Object? quantity = null,
    Object? totalPrice = null,
    Object? salePrice = null,
    Object? originalPrice = null,
    Object? pickUpTime = null,
    Object? isSubmitting = null,
    Object? merchantUid = freezed,
    Object? error = freezed,
  }) {
    return _then(
      _$OrderInfoImpl(
        storeId: null == storeId
            ? _value.storeId
            : storeId // ignore: cast_nullable_to_non_nullable
                  as String,
        storeAddress: null == storeAddress
            ? _value.storeAddress
            : storeAddress // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPrice: null == totalPrice
            ? _value.totalPrice
            : totalPrice // ignore: cast_nullable_to_non_nullable
                  as int,
        salePrice: null == salePrice
            ? _value.salePrice
            : salePrice // ignore: cast_nullable_to_non_nullable
                  as int,
        originalPrice: null == originalPrice
            ? _value.originalPrice
            : originalPrice // ignore: cast_nullable_to_non_nullable
                  as int,
        pickUpTime: null == pickUpTime
            ? _value.pickUpTime
            : pickUpTime // ignore: cast_nullable_to_non_nullable
                  as String,
        isSubmitting: null == isSubmitting
            ? _value.isSubmitting
            : isSubmitting // ignore: cast_nullable_to_non_nullable
                  as bool,
        merchantUid: freezed == merchantUid
            ? _value.merchantUid
            : merchantUid // ignore: cast_nullable_to_non_nullable
                  as String?,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$OrderInfoImpl extends _OrderInfo {
  const _$OrderInfoImpl({
    required this.storeId,
    required this.storeAddress,
    required this.quantity,
    required this.totalPrice,
    required this.salePrice,
    required this.originalPrice,
    required this.pickUpTime,
    this.isSubmitting = false,
    this.merchantUid,
    this.error,
  }) : super._();

  @override
  final String storeId;
  @override
  final String storeAddress;
  @override
  final int quantity;
  @override
  final int totalPrice;
  @override
  final int salePrice;
  @override
  final int originalPrice;
  @override
  final String pickUpTime;
  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  final String? merchantUid;
  @override
  final String? error;

  @override
  String toString() {
    return 'OrderInfo(storeId: $storeId, storeAddress: $storeAddress, quantity: $quantity, totalPrice: $totalPrice, salePrice: $salePrice, originalPrice: $originalPrice, pickUpTime: $pickUpTime, isSubmitting: $isSubmitting, merchantUid: $merchantUid, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderInfoImpl &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.storeAddress, storeAddress) ||
                other.storeAddress == storeAddress) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.salePrice, salePrice) ||
                other.salePrice == salePrice) &&
            (identical(other.originalPrice, originalPrice) ||
                other.originalPrice == originalPrice) &&
            (identical(other.pickUpTime, pickUpTime) ||
                other.pickUpTime == pickUpTime) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.merchantUid, merchantUid) ||
                other.merchantUid == merchantUid) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    storeId,
    storeAddress,
    quantity,
    totalPrice,
    salePrice,
    originalPrice,
    pickUpTime,
    isSubmitting,
    merchantUid,
    error,
  );

  /// Create a copy of OrderInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderInfoImplCopyWith<_$OrderInfoImpl> get copyWith =>
      __$$OrderInfoImplCopyWithImpl<_$OrderInfoImpl>(this, _$identity);
}

abstract class _OrderInfo extends OrderInfo {
  const factory _OrderInfo({
    required final String storeId,
    required final String storeAddress,
    required final int quantity,
    required final int totalPrice,
    required final int salePrice,
    required final int originalPrice,
    required final String pickUpTime,
    final bool isSubmitting,
    final String? merchantUid,
    final String? error,
  }) = _$OrderInfoImpl;
  const _OrderInfo._() : super._();

  @override
  String get storeId;
  @override
  String get storeAddress;
  @override
  int get quantity;
  @override
  int get totalPrice;
  @override
  int get salePrice;
  @override
  int get originalPrice;
  @override
  String get pickUpTime;
  @override
  bool get isSubmitting;
  @override
  String? get merchantUid;
  @override
  String? get error;

  /// Create a copy of OrderInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderInfoImplCopyWith<_$OrderInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
