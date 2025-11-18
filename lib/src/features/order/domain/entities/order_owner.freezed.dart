// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_owner.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OrderOwner _$OrderOwnerFromJson(Map<String, dynamic> json) {
  return _OrderOwner.fromJson(json);
}

/// @nodoc
mixin _$OrderOwner {
  String get orderId => throw _privateConstructorUsedError;
  OrderOwnerStatus get orderStatus => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get pickupTime => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  int get totalPrice => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String? get goodsName => throw _privateConstructorUsedError;

  /// Serializes this OrderOwner to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderOwner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderOwnerCopyWith<OrderOwner> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderOwnerCopyWith<$Res> {
  factory $OrderOwnerCopyWith(
    OrderOwner value,
    $Res Function(OrderOwner) then,
  ) = _$OrderOwnerCopyWithImpl<$Res, OrderOwner>;
  @useResult
  $Res call({
    String orderId,
    OrderOwnerStatus orderStatus,
    DateTime createdAt,
    DateTime pickupTime,
    String? memo,
    int quantity,
    int totalPrice,
    String phoneNumber,
    String? goodsName,
  });
}

/// @nodoc
class _$OrderOwnerCopyWithImpl<$Res, $Val extends OrderOwner>
    implements $OrderOwnerCopyWith<$Res> {
  _$OrderOwnerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderOwner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? orderStatus = null,
    Object? createdAt = null,
    Object? pickupTime = null,
    Object? memo = freezed,
    Object? quantity = null,
    Object? totalPrice = null,
    Object? phoneNumber = null,
    Object? goodsName = freezed,
  }) {
    return _then(
      _value.copyWith(
            orderId: null == orderId
                ? _value.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                      as String,
            orderStatus: null == orderStatus
                ? _value.orderStatus
                : orderStatus // ignore: cast_nullable_to_non_nullable
                      as OrderOwnerStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            pickupTime: null == pickupTime
                ? _value.pickupTime
                : pickupTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            memo: freezed == memo
                ? _value.memo
                : memo // ignore: cast_nullable_to_non_nullable
                      as String?,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPrice: null == totalPrice
                ? _value.totalPrice
                : totalPrice // ignore: cast_nullable_to_non_nullable
                      as int,
            phoneNumber: null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            goodsName: freezed == goodsName
                ? _value.goodsName
                : goodsName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderOwnerImplCopyWith<$Res>
    implements $OrderOwnerCopyWith<$Res> {
  factory _$$OrderOwnerImplCopyWith(
    _$OrderOwnerImpl value,
    $Res Function(_$OrderOwnerImpl) then,
  ) = __$$OrderOwnerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String orderId,
    OrderOwnerStatus orderStatus,
    DateTime createdAt,
    DateTime pickupTime,
    String? memo,
    int quantity,
    int totalPrice,
    String phoneNumber,
    String? goodsName,
  });
}

/// @nodoc
class __$$OrderOwnerImplCopyWithImpl<$Res>
    extends _$OrderOwnerCopyWithImpl<$Res, _$OrderOwnerImpl>
    implements _$$OrderOwnerImplCopyWith<$Res> {
  __$$OrderOwnerImplCopyWithImpl(
    _$OrderOwnerImpl _value,
    $Res Function(_$OrderOwnerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderOwner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? orderStatus = null,
    Object? createdAt = null,
    Object? pickupTime = null,
    Object? memo = freezed,
    Object? quantity = null,
    Object? totalPrice = null,
    Object? phoneNumber = null,
    Object? goodsName = freezed,
  }) {
    return _then(
      _$OrderOwnerImpl(
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        orderStatus: null == orderStatus
            ? _value.orderStatus
            : orderStatus // ignore: cast_nullable_to_non_nullable
                  as OrderOwnerStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        pickupTime: null == pickupTime
            ? _value.pickupTime
            : pickupTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        memo: freezed == memo
            ? _value.memo
            : memo // ignore: cast_nullable_to_non_nullable
                  as String?,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPrice: null == totalPrice
            ? _value.totalPrice
            : totalPrice // ignore: cast_nullable_to_non_nullable
                  as int,
        phoneNumber: null == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        goodsName: freezed == goodsName
            ? _value.goodsName
            : goodsName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderOwnerImpl implements _OrderOwner {
  const _$OrderOwnerImpl({
    required this.orderId,
    required this.orderStatus,
    required this.createdAt,
    required this.pickupTime,
    this.memo,
    required this.quantity,
    required this.totalPrice,
    required this.phoneNumber,
    this.goodsName,
  });

  factory _$OrderOwnerImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderOwnerImplFromJson(json);

  @override
  final String orderId;
  @override
  final OrderOwnerStatus orderStatus;
  @override
  final DateTime createdAt;
  @override
  final DateTime pickupTime;
  @override
  final String? memo;
  @override
  final int quantity;
  @override
  final int totalPrice;
  @override
  final String phoneNumber;
  @override
  final String? goodsName;

  @override
  String toString() {
    return 'OrderOwner(orderId: $orderId, orderStatus: $orderStatus, createdAt: $createdAt, pickupTime: $pickupTime, memo: $memo, quantity: $quantity, totalPrice: $totalPrice, phoneNumber: $phoneNumber, goodsName: $goodsName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderOwnerImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.orderStatus, orderStatus) ||
                other.orderStatus == orderStatus) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.pickupTime, pickupTime) ||
                other.pickupTime == pickupTime) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.goodsName, goodsName) ||
                other.goodsName == goodsName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    orderId,
    orderStatus,
    createdAt,
    pickupTime,
    memo,
    quantity,
    totalPrice,
    phoneNumber,
    goodsName,
  );

  /// Create a copy of OrderOwner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderOwnerImplCopyWith<_$OrderOwnerImpl> get copyWith =>
      __$$OrderOwnerImplCopyWithImpl<_$OrderOwnerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderOwnerImplToJson(this);
  }
}

abstract class _OrderOwner implements OrderOwner {
  const factory _OrderOwner({
    required final String orderId,
    required final OrderOwnerStatus orderStatus,
    required final DateTime createdAt,
    required final DateTime pickupTime,
    final String? memo,
    required final int quantity,
    required final int totalPrice,
    required final String phoneNumber,
    final String? goodsName,
  }) = _$OrderOwnerImpl;

  factory _OrderOwner.fromJson(Map<String, dynamic> json) =
      _$OrderOwnerImpl.fromJson;

  @override
  String get orderId;
  @override
  OrderOwnerStatus get orderStatus;
  @override
  DateTime get createdAt;
  @override
  DateTime get pickupTime;
  @override
  String? get memo;
  @override
  int get quantity;
  @override
  int get totalPrice;
  @override
  String get phoneNumber;
  @override
  String? get goodsName;

  /// Create a copy of OrderOwner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderOwnerImplCopyWith<_$OrderOwnerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
