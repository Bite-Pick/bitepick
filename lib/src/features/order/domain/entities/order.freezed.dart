// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
mixin _$Order {
  String get orderId => throw _privateConstructorUsedError;
  OrderStatus get orderStatus => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;
  String get storeId => throw _privateConstructorUsedError;
  String get storeName => throw _privateConstructorUsedError;
  List<String> get imageUrls => throw _privateConstructorUsedError;
  List<OrderGoods> get goodsList => throw _privateConstructorUsedError;
  List<String> get reviewIds => throw _privateConstructorUsedError;
  String get payType => throw _privateConstructorUsedError;
  String? get easyPayProvider => throw _privateConstructorUsedError;

  /// Serializes this Order to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call({
    String orderId,
    OrderStatus orderStatus,
    DateTime createdAt,
    String? memo,
    String storeId,
    String storeName,
    List<String> imageUrls,
    List<OrderGoods> goodsList,
    List<String> reviewIds,
    String payType,
    String? easyPayProvider,
  });
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? orderStatus = null,
    Object? createdAt = null,
    Object? memo = freezed,
    Object? storeId = null,
    Object? storeName = null,
    Object? imageUrls = null,
    Object? goodsList = null,
    Object? reviewIds = null,
    Object? payType = null,
    Object? easyPayProvider = freezed,
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
                      as OrderStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            memo: freezed == memo
                ? _value.memo
                : memo // ignore: cast_nullable_to_non_nullable
                      as String?,
            storeId: null == storeId
                ? _value.storeId
                : storeId // ignore: cast_nullable_to_non_nullable
                      as String,
            storeName: null == storeName
                ? _value.storeName
                : storeName // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrls: null == imageUrls
                ? _value.imageUrls
                : imageUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            goodsList: null == goodsList
                ? _value.goodsList
                : goodsList // ignore: cast_nullable_to_non_nullable
                      as List<OrderGoods>,
            reviewIds: null == reviewIds
                ? _value.reviewIds
                : reviewIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            payType: null == payType
                ? _value.payType
                : payType // ignore: cast_nullable_to_non_nullable
                      as String,
            easyPayProvider: freezed == easyPayProvider
                ? _value.easyPayProvider
                : easyPayProvider // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderImplCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$OrderImplCopyWith(
    _$OrderImpl value,
    $Res Function(_$OrderImpl) then,
  ) = __$$OrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String orderId,
    OrderStatus orderStatus,
    DateTime createdAt,
    String? memo,
    String storeId,
    String storeName,
    List<String> imageUrls,
    List<OrderGoods> goodsList,
    List<String> reviewIds,
    String payType,
    String? easyPayProvider,
  });
}

/// @nodoc
class __$$OrderImplCopyWithImpl<$Res>
    extends _$OrderCopyWithImpl<$Res, _$OrderImpl>
    implements _$$OrderImplCopyWith<$Res> {
  __$$OrderImplCopyWithImpl(
    _$OrderImpl _value,
    $Res Function(_$OrderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? orderStatus = null,
    Object? createdAt = null,
    Object? memo = freezed,
    Object? storeId = null,
    Object? storeName = null,
    Object? imageUrls = null,
    Object? goodsList = null,
    Object? reviewIds = null,
    Object? payType = null,
    Object? easyPayProvider = freezed,
  }) {
    return _then(
      _$OrderImpl(
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        orderStatus: null == orderStatus
            ? _value.orderStatus
            : orderStatus // ignore: cast_nullable_to_non_nullable
                  as OrderStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        memo: freezed == memo
            ? _value.memo
            : memo // ignore: cast_nullable_to_non_nullable
                  as String?,
        storeId: null == storeId
            ? _value.storeId
            : storeId // ignore: cast_nullable_to_non_nullable
                  as String,
        storeName: null == storeName
            ? _value.storeName
            : storeName // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrls: null == imageUrls
            ? _value._imageUrls
            : imageUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        goodsList: null == goodsList
            ? _value._goodsList
            : goodsList // ignore: cast_nullable_to_non_nullable
                  as List<OrderGoods>,
        reviewIds: null == reviewIds
            ? _value._reviewIds
            : reviewIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        payType: null == payType
            ? _value.payType
            : payType // ignore: cast_nullable_to_non_nullable
                  as String,
        easyPayProvider: freezed == easyPayProvider
            ? _value.easyPayProvider
            : easyPayProvider // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderImpl implements _Order {
  const _$OrderImpl({
    required this.orderId,
    required this.orderStatus,
    required this.createdAt,
    this.memo,
    required this.storeId,
    required this.storeName,
    required final List<String> imageUrls,
    required final List<OrderGoods> goodsList,
    required final List<String> reviewIds,
    required this.payType,
    this.easyPayProvider,
  }) : _imageUrls = imageUrls,
       _goodsList = goodsList,
       _reviewIds = reviewIds;

  factory _$OrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderImplFromJson(json);

  @override
  final String orderId;
  @override
  final OrderStatus orderStatus;
  @override
  final DateTime createdAt;
  @override
  final String? memo;
  @override
  final String storeId;
  @override
  final String storeName;
  final List<String> _imageUrls;
  @override
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  final List<OrderGoods> _goodsList;
  @override
  List<OrderGoods> get goodsList {
    if (_goodsList is EqualUnmodifiableListView) return _goodsList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_goodsList);
  }

  final List<String> _reviewIds;
  @override
  List<String> get reviewIds {
    if (_reviewIds is EqualUnmodifiableListView) return _reviewIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviewIds);
  }

  @override
  final String payType;
  @override
  final String? easyPayProvider;

  @override
  String toString() {
    return 'Order(orderId: $orderId, orderStatus: $orderStatus, createdAt: $createdAt, memo: $memo, storeId: $storeId, storeName: $storeName, imageUrls: $imageUrls, goodsList: $goodsList, reviewIds: $reviewIds, payType: $payType, easyPayProvider: $easyPayProvider)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.orderStatus, orderStatus) ||
                other.orderStatus == orderStatus) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.storeName, storeName) ||
                other.storeName == storeName) &&
            const DeepCollectionEquality().equals(
              other._imageUrls,
              _imageUrls,
            ) &&
            const DeepCollectionEquality().equals(
              other._goodsList,
              _goodsList,
            ) &&
            const DeepCollectionEquality().equals(
              other._reviewIds,
              _reviewIds,
            ) &&
            (identical(other.payType, payType) || other.payType == payType) &&
            (identical(other.easyPayProvider, easyPayProvider) ||
                other.easyPayProvider == easyPayProvider));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    orderId,
    orderStatus,
    createdAt,
    memo,
    storeId,
    storeName,
    const DeepCollectionEquality().hash(_imageUrls),
    const DeepCollectionEquality().hash(_goodsList),
    const DeepCollectionEquality().hash(_reviewIds),
    payType,
    easyPayProvider,
  );

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      __$$OrderImplCopyWithImpl<_$OrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderImplToJson(this);
  }
}

abstract class _Order implements Order {
  const factory _Order({
    required final String orderId,
    required final OrderStatus orderStatus,
    required final DateTime createdAt,
    final String? memo,
    required final String storeId,
    required final String storeName,
    required final List<String> imageUrls,
    required final List<OrderGoods> goodsList,
    required final List<String> reviewIds,
    required final String payType,
    final String? easyPayProvider,
  }) = _$OrderImpl;

  factory _Order.fromJson(Map<String, dynamic> json) = _$OrderImpl.fromJson;

  @override
  String get orderId;
  @override
  OrderStatus get orderStatus;
  @override
  DateTime get createdAt;
  @override
  String? get memo;
  @override
  String get storeId;
  @override
  String get storeName;
  @override
  List<String> get imageUrls;
  @override
  List<OrderGoods> get goodsList;
  @override
  List<String> get reviewIds;
  @override
  String get payType;
  @override
  String? get easyPayProvider;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderGoods _$OrderGoodsFromJson(Map<String, dynamic> json) {
  return _OrderGoods.fromJson(json);
}

/// @nodoc
mixin _$OrderGoods {
  String get orderGoodsId => throw _privateConstructorUsedError;
  String get goodsName => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  int get salePrice => throw _privateConstructorUsedError;

  /// Serializes this OrderGoods to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderGoods
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderGoodsCopyWith<OrderGoods> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderGoodsCopyWith<$Res> {
  factory $OrderGoodsCopyWith(
    OrderGoods value,
    $Res Function(OrderGoods) then,
  ) = _$OrderGoodsCopyWithImpl<$Res, OrderGoods>;
  @useResult
  $Res call({
    String orderGoodsId,
    String goodsName,
    int quantity,
    int salePrice,
  });
}

/// @nodoc
class _$OrderGoodsCopyWithImpl<$Res, $Val extends OrderGoods>
    implements $OrderGoodsCopyWith<$Res> {
  _$OrderGoodsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderGoods
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderGoodsId = null,
    Object? goodsName = null,
    Object? quantity = null,
    Object? salePrice = null,
  }) {
    return _then(
      _value.copyWith(
            orderGoodsId: null == orderGoodsId
                ? _value.orderGoodsId
                : orderGoodsId // ignore: cast_nullable_to_non_nullable
                      as String,
            goodsName: null == goodsName
                ? _value.goodsName
                : goodsName // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            salePrice: null == salePrice
                ? _value.salePrice
                : salePrice // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderGoodsImplCopyWith<$Res>
    implements $OrderGoodsCopyWith<$Res> {
  factory _$$OrderGoodsImplCopyWith(
    _$OrderGoodsImpl value,
    $Res Function(_$OrderGoodsImpl) then,
  ) = __$$OrderGoodsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String orderGoodsId,
    String goodsName,
    int quantity,
    int salePrice,
  });
}

/// @nodoc
class __$$OrderGoodsImplCopyWithImpl<$Res>
    extends _$OrderGoodsCopyWithImpl<$Res, _$OrderGoodsImpl>
    implements _$$OrderGoodsImplCopyWith<$Res> {
  __$$OrderGoodsImplCopyWithImpl(
    _$OrderGoodsImpl _value,
    $Res Function(_$OrderGoodsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderGoods
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderGoodsId = null,
    Object? goodsName = null,
    Object? quantity = null,
    Object? salePrice = null,
  }) {
    return _then(
      _$OrderGoodsImpl(
        orderGoodsId: null == orderGoodsId
            ? _value.orderGoodsId
            : orderGoodsId // ignore: cast_nullable_to_non_nullable
                  as String,
        goodsName: null == goodsName
            ? _value.goodsName
            : goodsName // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        salePrice: null == salePrice
            ? _value.salePrice
            : salePrice // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderGoodsImpl implements _OrderGoods {
  const _$OrderGoodsImpl({
    required this.orderGoodsId,
    required this.goodsName,
    required this.quantity,
    required this.salePrice,
  });

  factory _$OrderGoodsImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderGoodsImplFromJson(json);

  @override
  final String orderGoodsId;
  @override
  final String goodsName;
  @override
  final int quantity;
  @override
  final int salePrice;

  @override
  String toString() {
    return 'OrderGoods(orderGoodsId: $orderGoodsId, goodsName: $goodsName, quantity: $quantity, salePrice: $salePrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderGoodsImpl &&
            (identical(other.orderGoodsId, orderGoodsId) ||
                other.orderGoodsId == orderGoodsId) &&
            (identical(other.goodsName, goodsName) ||
                other.goodsName == goodsName) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.salePrice, salePrice) ||
                other.salePrice == salePrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, orderGoodsId, goodsName, quantity, salePrice);

  /// Create a copy of OrderGoods
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderGoodsImplCopyWith<_$OrderGoodsImpl> get copyWith =>
      __$$OrderGoodsImplCopyWithImpl<_$OrderGoodsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderGoodsImplToJson(this);
  }
}

abstract class _OrderGoods implements OrderGoods {
  const factory _OrderGoods({
    required final String orderGoodsId,
    required final String goodsName,
    required final int quantity,
    required final int salePrice,
  }) = _$OrderGoodsImpl;

  factory _OrderGoods.fromJson(Map<String, dynamic> json) =
      _$OrderGoodsImpl.fromJson;

  @override
  String get orderGoodsId;
  @override
  String get goodsName;
  @override
  int get quantity;
  @override
  int get salePrice;

  /// Create a copy of OrderGoods
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderGoodsImplCopyWith<_$OrderGoodsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
