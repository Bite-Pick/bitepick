// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_detail.dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OrderDetailDTO _$OrderDetailDTOFromJson(Map<String, dynamic> json) {
  return _OrderDetailDTO.fromJson(json);
}

/// @nodoc
mixin _$OrderDetailDTO {
  String get orderId => throw _privateConstructorUsedError;
  String get orderGoodsId => throw _privateConstructorUsedError;
  OrderGuestStatus get orderStatus => throw _privateConstructorUsedError;
  String get storeName => throw _privateConstructorUsedError;
  String get storeAddress => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  int get totalPrice => throw _privateConstructorUsedError;
  String get pickupTime => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get storeId => throw _privateConstructorUsedError;
  String? get payType => throw _privateConstructorUsedError;
  String? get easyPayProvider => throw _privateConstructorUsedError;
  String? get reviewId => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;

  /// Serializes this OrderDetailDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderDetailDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderDetailDTOCopyWith<OrderDetailDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderDetailDTOCopyWith<$Res> {
  factory $OrderDetailDTOCopyWith(
    OrderDetailDTO value,
    $Res Function(OrderDetailDTO) then,
  ) = _$OrderDetailDTOCopyWithImpl<$Res, OrderDetailDTO>;
  @useResult
  $Res call({
    String orderId,
    String orderGoodsId,
    OrderGuestStatus orderStatus,
    String storeName,
    String storeAddress,
    String imageUrl,
    int quantity,
    int totalPrice,
    String pickupTime,
    String createdAt,
    String storeId,
    String? payType,
    String? easyPayProvider,
    String? reviewId,
    String? memo,
  });
}

/// @nodoc
class _$OrderDetailDTOCopyWithImpl<$Res, $Val extends OrderDetailDTO>
    implements $OrderDetailDTOCopyWith<$Res> {
  _$OrderDetailDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderDetailDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? orderGoodsId = null,
    Object? orderStatus = null,
    Object? storeName = null,
    Object? storeAddress = null,
    Object? imageUrl = null,
    Object? quantity = null,
    Object? totalPrice = null,
    Object? pickupTime = null,
    Object? createdAt = null,
    Object? storeId = null,
    Object? payType = freezed,
    Object? easyPayProvider = freezed,
    Object? reviewId = freezed,
    Object? memo = freezed,
  }) {
    return _then(
      _value.copyWith(
            orderId: null == orderId
                ? _value.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                      as String,
            orderGoodsId: null == orderGoodsId
                ? _value.orderGoodsId
                : orderGoodsId // ignore: cast_nullable_to_non_nullable
                      as String,
            orderStatus: null == orderStatus
                ? _value.orderStatus
                : orderStatus // ignore: cast_nullable_to_non_nullable
                      as OrderGuestStatus,
            storeName: null == storeName
                ? _value.storeName
                : storeName // ignore: cast_nullable_to_non_nullable
                      as String,
            storeAddress: null == storeAddress
                ? _value.storeAddress
                : storeAddress // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPrice: null == totalPrice
                ? _value.totalPrice
                : totalPrice // ignore: cast_nullable_to_non_nullable
                      as int,
            pickupTime: null == pickupTime
                ? _value.pickupTime
                : pickupTime // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            storeId: null == storeId
                ? _value.storeId
                : storeId // ignore: cast_nullable_to_non_nullable
                      as String,
            payType: freezed == payType
                ? _value.payType
                : payType // ignore: cast_nullable_to_non_nullable
                      as String?,
            easyPayProvider: freezed == easyPayProvider
                ? _value.easyPayProvider
                : easyPayProvider // ignore: cast_nullable_to_non_nullable
                      as String?,
            reviewId: freezed == reviewId
                ? _value.reviewId
                : reviewId // ignore: cast_nullable_to_non_nullable
                      as String?,
            memo: freezed == memo
                ? _value.memo
                : memo // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderDetailDTOImplCopyWith<$Res>
    implements $OrderDetailDTOCopyWith<$Res> {
  factory _$$OrderDetailDTOImplCopyWith(
    _$OrderDetailDTOImpl value,
    $Res Function(_$OrderDetailDTOImpl) then,
  ) = __$$OrderDetailDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String orderId,
    String orderGoodsId,
    OrderGuestStatus orderStatus,
    String storeName,
    String storeAddress,
    String imageUrl,
    int quantity,
    int totalPrice,
    String pickupTime,
    String createdAt,
    String storeId,
    String? payType,
    String? easyPayProvider,
    String? reviewId,
    String? memo,
  });
}

/// @nodoc
class __$$OrderDetailDTOImplCopyWithImpl<$Res>
    extends _$OrderDetailDTOCopyWithImpl<$Res, _$OrderDetailDTOImpl>
    implements _$$OrderDetailDTOImplCopyWith<$Res> {
  __$$OrderDetailDTOImplCopyWithImpl(
    _$OrderDetailDTOImpl _value,
    $Res Function(_$OrderDetailDTOImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderDetailDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? orderGoodsId = null,
    Object? orderStatus = null,
    Object? storeName = null,
    Object? storeAddress = null,
    Object? imageUrl = null,
    Object? quantity = null,
    Object? totalPrice = null,
    Object? pickupTime = null,
    Object? createdAt = null,
    Object? storeId = null,
    Object? payType = freezed,
    Object? easyPayProvider = freezed,
    Object? reviewId = freezed,
    Object? memo = freezed,
  }) {
    return _then(
      _$OrderDetailDTOImpl(
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        orderGoodsId: null == orderGoodsId
            ? _value.orderGoodsId
            : orderGoodsId // ignore: cast_nullable_to_non_nullable
                  as String,
        orderStatus: null == orderStatus
            ? _value.orderStatus
            : orderStatus // ignore: cast_nullable_to_non_nullable
                  as OrderGuestStatus,
        storeName: null == storeName
            ? _value.storeName
            : storeName // ignore: cast_nullable_to_non_nullable
                  as String,
        storeAddress: null == storeAddress
            ? _value.storeAddress
            : storeAddress // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPrice: null == totalPrice
            ? _value.totalPrice
            : totalPrice // ignore: cast_nullable_to_non_nullable
                  as int,
        pickupTime: null == pickupTime
            ? _value.pickupTime
            : pickupTime // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        storeId: null == storeId
            ? _value.storeId
            : storeId // ignore: cast_nullable_to_non_nullable
                  as String,
        payType: freezed == payType
            ? _value.payType
            : payType // ignore: cast_nullable_to_non_nullable
                  as String?,
        easyPayProvider: freezed == easyPayProvider
            ? _value.easyPayProvider
            : easyPayProvider // ignore: cast_nullable_to_non_nullable
                  as String?,
        reviewId: freezed == reviewId
            ? _value.reviewId
            : reviewId // ignore: cast_nullable_to_non_nullable
                  as String?,
        memo: freezed == memo
            ? _value.memo
            : memo // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderDetailDTOImpl implements _OrderDetailDTO {
  const _$OrderDetailDTOImpl({
    required this.orderId,
    required this.orderGoodsId,
    required this.orderStatus,
    required this.storeName,
    required this.storeAddress,
    required this.imageUrl,
    required this.quantity,
    required this.totalPrice,
    required this.pickupTime,
    required this.createdAt,
    required this.storeId,
    this.payType,
    this.easyPayProvider,
    this.reviewId,
    this.memo,
  });

  factory _$OrderDetailDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderDetailDTOImplFromJson(json);

  @override
  final String orderId;
  @override
  final String orderGoodsId;
  @override
  final OrderGuestStatus orderStatus;
  @override
  final String storeName;
  @override
  final String storeAddress;
  @override
  final String imageUrl;
  @override
  final int quantity;
  @override
  final int totalPrice;
  @override
  final String pickupTime;
  @override
  final String createdAt;
  @override
  final String storeId;
  @override
  final String? payType;
  @override
  final String? easyPayProvider;
  @override
  final String? reviewId;
  @override
  final String? memo;

  @override
  String toString() {
    return 'OrderDetailDTO(orderId: $orderId, orderGoodsId: $orderGoodsId, orderStatus: $orderStatus, storeName: $storeName, storeAddress: $storeAddress, imageUrl: $imageUrl, quantity: $quantity, totalPrice: $totalPrice, pickupTime: $pickupTime, createdAt: $createdAt, storeId: $storeId, payType: $payType, easyPayProvider: $easyPayProvider, reviewId: $reviewId, memo: $memo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderDetailDTOImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.orderGoodsId, orderGoodsId) ||
                other.orderGoodsId == orderGoodsId) &&
            (identical(other.orderStatus, orderStatus) ||
                other.orderStatus == orderStatus) &&
            (identical(other.storeName, storeName) ||
                other.storeName == storeName) &&
            (identical(other.storeAddress, storeAddress) ||
                other.storeAddress == storeAddress) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.pickupTime, pickupTime) ||
                other.pickupTime == pickupTime) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.payType, payType) || other.payType == payType) &&
            (identical(other.easyPayProvider, easyPayProvider) ||
                other.easyPayProvider == easyPayProvider) &&
            (identical(other.reviewId, reviewId) ||
                other.reviewId == reviewId) &&
            (identical(other.memo, memo) || other.memo == memo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    orderId,
    orderGoodsId,
    orderStatus,
    storeName,
    storeAddress,
    imageUrl,
    quantity,
    totalPrice,
    pickupTime,
    createdAt,
    storeId,
    payType,
    easyPayProvider,
    reviewId,
    memo,
  );

  /// Create a copy of OrderDetailDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderDetailDTOImplCopyWith<_$OrderDetailDTOImpl> get copyWith =>
      __$$OrderDetailDTOImplCopyWithImpl<_$OrderDetailDTOImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderDetailDTOImplToJson(this);
  }
}

abstract class _OrderDetailDTO implements OrderDetailDTO {
  const factory _OrderDetailDTO({
    required final String orderId,
    required final String orderGoodsId,
    required final OrderGuestStatus orderStatus,
    required final String storeName,
    required final String storeAddress,
    required final String imageUrl,
    required final int quantity,
    required final int totalPrice,
    required final String pickupTime,
    required final String createdAt,
    required final String storeId,
    final String? payType,
    final String? easyPayProvider,
    final String? reviewId,
    final String? memo,
  }) = _$OrderDetailDTOImpl;

  factory _OrderDetailDTO.fromJson(Map<String, dynamic> json) =
      _$OrderDetailDTOImpl.fromJson;

  @override
  String get orderId;
  @override
  String get orderGoodsId;
  @override
  OrderGuestStatus get orderStatus;
  @override
  String get storeName;
  @override
  String get storeAddress;
  @override
  String get imageUrl;
  @override
  int get quantity;
  @override
  int get totalPrice;
  @override
  String get pickupTime;
  @override
  String get createdAt;
  @override
  String get storeId;
  @override
  String? get payType;
  @override
  String? get easyPayProvider;
  @override
  String? get reviewId;
  @override
  String? get memo;

  /// Create a copy of OrderDetailDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderDetailDTOImplCopyWith<_$OrderDetailDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
