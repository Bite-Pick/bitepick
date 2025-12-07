// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_list.dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OrderListDTO _$OrderListDTOFromJson(Map<String, dynamic> json) {
  return _OrderListDTO.fromJson(json);
}

/// @nodoc
mixin _$OrderListDTO {
  String get orderId => throw _privateConstructorUsedError;
  OrderGuestStatus get orderStatus => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get storeId => throw _privateConstructorUsedError;
  String get storeName => throw _privateConstructorUsedError;
  List<String> get imageUrls => throw _privateConstructorUsedError;
  List<OrderGoodsDTO> get goodsList => throw _privateConstructorUsedError;
  List<String> get reviewIds => throw _privateConstructorUsedError;
  String get payType => throw _privateConstructorUsedError;
  String get easyPayProvider => throw _privateConstructorUsedError;
  String? get pickupTime => throw _privateConstructorUsedError; // NOTE: test 필요
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError; // TODO: API 반환값 추가 필요
  int? get discount => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;

  /// Serializes this OrderListDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderListDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderListDTOCopyWith<OrderListDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderListDTOCopyWith<$Res> {
  factory $OrderListDTOCopyWith(
    OrderListDTO value,
    $Res Function(OrderListDTO) then,
  ) = _$OrderListDTOCopyWithImpl<$Res, OrderListDTO>;
  @useResult
  $Res call({
    String orderId,
    OrderGuestStatus orderStatus,
    String createdAt,
    String storeId,
    String storeName,
    List<String> imageUrls,
    List<OrderGoodsDTO> goodsList,
    List<String> reviewIds,
    String payType,
    String easyPayProvider,
    String? pickupTime,
    double? latitude,
    double? longitude,
    String? memo,
    int? discount,
    String? address,
  });
}

/// @nodoc
class _$OrderListDTOCopyWithImpl<$Res, $Val extends OrderListDTO>
    implements $OrderListDTOCopyWith<$Res> {
  _$OrderListDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderListDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? orderStatus = null,
    Object? createdAt = null,
    Object? storeId = null,
    Object? storeName = null,
    Object? imageUrls = null,
    Object? goodsList = null,
    Object? reviewIds = null,
    Object? payType = null,
    Object? easyPayProvider = null,
    Object? pickupTime = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? memo = freezed,
    Object? discount = freezed,
    Object? address = freezed,
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
                      as OrderGuestStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
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
                      as List<OrderGoodsDTO>,
            reviewIds: null == reviewIds
                ? _value.reviewIds
                : reviewIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            payType: null == payType
                ? _value.payType
                : payType // ignore: cast_nullable_to_non_nullable
                      as String,
            easyPayProvider: null == easyPayProvider
                ? _value.easyPayProvider
                : easyPayProvider // ignore: cast_nullable_to_non_nullable
                      as String,
            pickupTime: freezed == pickupTime
                ? _value.pickupTime
                : pickupTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            memo: freezed == memo
                ? _value.memo
                : memo // ignore: cast_nullable_to_non_nullable
                      as String?,
            discount: freezed == discount
                ? _value.discount
                : discount // ignore: cast_nullable_to_non_nullable
                      as int?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderListDTOImplCopyWith<$Res>
    implements $OrderListDTOCopyWith<$Res> {
  factory _$$OrderListDTOImplCopyWith(
    _$OrderListDTOImpl value,
    $Res Function(_$OrderListDTOImpl) then,
  ) = __$$OrderListDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String orderId,
    OrderGuestStatus orderStatus,
    String createdAt,
    String storeId,
    String storeName,
    List<String> imageUrls,
    List<OrderGoodsDTO> goodsList,
    List<String> reviewIds,
    String payType,
    String easyPayProvider,
    String? pickupTime,
    double? latitude,
    double? longitude,
    String? memo,
    int? discount,
    String? address,
  });
}

/// @nodoc
class __$$OrderListDTOImplCopyWithImpl<$Res>
    extends _$OrderListDTOCopyWithImpl<$Res, _$OrderListDTOImpl>
    implements _$$OrderListDTOImplCopyWith<$Res> {
  __$$OrderListDTOImplCopyWithImpl(
    _$OrderListDTOImpl _value,
    $Res Function(_$OrderListDTOImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderListDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? orderStatus = null,
    Object? createdAt = null,
    Object? storeId = null,
    Object? storeName = null,
    Object? imageUrls = null,
    Object? goodsList = null,
    Object? reviewIds = null,
    Object? payType = null,
    Object? easyPayProvider = null,
    Object? pickupTime = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? memo = freezed,
    Object? discount = freezed,
    Object? address = freezed,
  }) {
    return _then(
      _$OrderListDTOImpl(
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        orderStatus: null == orderStatus
            ? _value.orderStatus
            : orderStatus // ignore: cast_nullable_to_non_nullable
                  as OrderGuestStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
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
                  as List<OrderGoodsDTO>,
        reviewIds: null == reviewIds
            ? _value._reviewIds
            : reviewIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        payType: null == payType
            ? _value.payType
            : payType // ignore: cast_nullable_to_non_nullable
                  as String,
        easyPayProvider: null == easyPayProvider
            ? _value.easyPayProvider
            : easyPayProvider // ignore: cast_nullable_to_non_nullable
                  as String,
        pickupTime: freezed == pickupTime
            ? _value.pickupTime
            : pickupTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        memo: freezed == memo
            ? _value.memo
            : memo // ignore: cast_nullable_to_non_nullable
                  as String?,
        discount: freezed == discount
            ? _value.discount
            : discount // ignore: cast_nullable_to_non_nullable
                  as int?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderListDTOImpl extends _OrderListDTO {
  const _$OrderListDTOImpl({
    required this.orderId,
    required this.orderStatus,
    required this.createdAt,
    required this.storeId,
    required this.storeName,
    required final List<String> imageUrls,
    required final List<OrderGoodsDTO> goodsList,
    required final List<String> reviewIds,
    required this.payType,
    required this.easyPayProvider,
    this.pickupTime,
    this.latitude,
    this.longitude,
    this.memo,
    this.discount,
    this.address,
  }) : _imageUrls = imageUrls,
       _goodsList = goodsList,
       _reviewIds = reviewIds,
       super._();

  factory _$OrderListDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderListDTOImplFromJson(json);

  @override
  final String orderId;
  @override
  final OrderGuestStatus orderStatus;
  @override
  final String createdAt;
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

  final List<OrderGoodsDTO> _goodsList;
  @override
  List<OrderGoodsDTO> get goodsList {
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
  final String easyPayProvider;
  @override
  final String? pickupTime;
  // NOTE: test 필요
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final String? memo;
  // TODO: API 반환값 추가 필요
  @override
  final int? discount;
  @override
  final String? address;

  @override
  String toString() {
    return 'OrderListDTO(orderId: $orderId, orderStatus: $orderStatus, createdAt: $createdAt, storeId: $storeId, storeName: $storeName, imageUrls: $imageUrls, goodsList: $goodsList, reviewIds: $reviewIds, payType: $payType, easyPayProvider: $easyPayProvider, pickupTime: $pickupTime, latitude: $latitude, longitude: $longitude, memo: $memo, discount: $discount, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderListDTOImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.orderStatus, orderStatus) ||
                other.orderStatus == orderStatus) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
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
                other.easyPayProvider == easyPayProvider) &&
            (identical(other.pickupTime, pickupTime) ||
                other.pickupTime == pickupTime) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    orderId,
    orderStatus,
    createdAt,
    storeId,
    storeName,
    const DeepCollectionEquality().hash(_imageUrls),
    const DeepCollectionEquality().hash(_goodsList),
    const DeepCollectionEquality().hash(_reviewIds),
    payType,
    easyPayProvider,
    pickupTime,
    latitude,
    longitude,
    memo,
    discount,
    address,
  );

  /// Create a copy of OrderListDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderListDTOImplCopyWith<_$OrderListDTOImpl> get copyWith =>
      __$$OrderListDTOImplCopyWithImpl<_$OrderListDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderListDTOImplToJson(this);
  }
}

abstract class _OrderListDTO extends OrderListDTO {
  const factory _OrderListDTO({
    required final String orderId,
    required final OrderGuestStatus orderStatus,
    required final String createdAt,
    required final String storeId,
    required final String storeName,
    required final List<String> imageUrls,
    required final List<OrderGoodsDTO> goodsList,
    required final List<String> reviewIds,
    required final String payType,
    required final String easyPayProvider,
    final String? pickupTime,
    final double? latitude,
    final double? longitude,
    final String? memo,
    final int? discount,
    final String? address,
  }) = _$OrderListDTOImpl;
  const _OrderListDTO._() : super._();

  factory _OrderListDTO.fromJson(Map<String, dynamic> json) =
      _$OrderListDTOImpl.fromJson;

  @override
  String get orderId;
  @override
  OrderGuestStatus get orderStatus;
  @override
  String get createdAt;
  @override
  String get storeId;
  @override
  String get storeName;
  @override
  List<String> get imageUrls;
  @override
  List<OrderGoodsDTO> get goodsList;
  @override
  List<String> get reviewIds;
  @override
  String get payType;
  @override
  String get easyPayProvider;
  @override
  String? get pickupTime; // NOTE: test 필요
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  String? get memo; // TODO: API 반환값 추가 필요
  @override
  int? get discount;
  @override
  String? get address;

  /// Create a copy of OrderListDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderListDTOImplCopyWith<_$OrderListDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderGoodsDTO _$OrderGoodsDTOFromJson(Map<String, dynamic> json) {
  return _OrderGoodsDTO.fromJson(json);
}

/// @nodoc
mixin _$OrderGoodsDTO {
  String get orderGoodsId => throw _privateConstructorUsedError;
  String? get goodsName => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  int get salePrice => throw _privateConstructorUsedError;

  /// Serializes this OrderGoodsDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderGoodsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderGoodsDTOCopyWith<OrderGoodsDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderGoodsDTOCopyWith<$Res> {
  factory $OrderGoodsDTOCopyWith(
    OrderGoodsDTO value,
    $Res Function(OrderGoodsDTO) then,
  ) = _$OrderGoodsDTOCopyWithImpl<$Res, OrderGoodsDTO>;
  @useResult
  $Res call({
    String orderGoodsId,
    String? goodsName,
    int quantity,
    int salePrice,
  });
}

/// @nodoc
class _$OrderGoodsDTOCopyWithImpl<$Res, $Val extends OrderGoodsDTO>
    implements $OrderGoodsDTOCopyWith<$Res> {
  _$OrderGoodsDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderGoodsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderGoodsId = null,
    Object? goodsName = freezed,
    Object? quantity = null,
    Object? salePrice = null,
  }) {
    return _then(
      _value.copyWith(
            orderGoodsId: null == orderGoodsId
                ? _value.orderGoodsId
                : orderGoodsId // ignore: cast_nullable_to_non_nullable
                      as String,
            goodsName: freezed == goodsName
                ? _value.goodsName
                : goodsName // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$OrderGoodsDTOImplCopyWith<$Res>
    implements $OrderGoodsDTOCopyWith<$Res> {
  factory _$$OrderGoodsDTOImplCopyWith(
    _$OrderGoodsDTOImpl value,
    $Res Function(_$OrderGoodsDTOImpl) then,
  ) = __$$OrderGoodsDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String orderGoodsId,
    String? goodsName,
    int quantity,
    int salePrice,
  });
}

/// @nodoc
class __$$OrderGoodsDTOImplCopyWithImpl<$Res>
    extends _$OrderGoodsDTOCopyWithImpl<$Res, _$OrderGoodsDTOImpl>
    implements _$$OrderGoodsDTOImplCopyWith<$Res> {
  __$$OrderGoodsDTOImplCopyWithImpl(
    _$OrderGoodsDTOImpl _value,
    $Res Function(_$OrderGoodsDTOImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderGoodsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderGoodsId = null,
    Object? goodsName = freezed,
    Object? quantity = null,
    Object? salePrice = null,
  }) {
    return _then(
      _$OrderGoodsDTOImpl(
        orderGoodsId: null == orderGoodsId
            ? _value.orderGoodsId
            : orderGoodsId // ignore: cast_nullable_to_non_nullable
                  as String,
        goodsName: freezed == goodsName
            ? _value.goodsName
            : goodsName // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$OrderGoodsDTOImpl implements _OrderGoodsDTO {
  const _$OrderGoodsDTOImpl({
    required this.orderGoodsId,
    this.goodsName,
    required this.quantity,
    required this.salePrice,
  });

  factory _$OrderGoodsDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderGoodsDTOImplFromJson(json);

  @override
  final String orderGoodsId;
  @override
  final String? goodsName;
  @override
  final int quantity;
  @override
  final int salePrice;

  @override
  String toString() {
    return 'OrderGoodsDTO(orderGoodsId: $orderGoodsId, goodsName: $goodsName, quantity: $quantity, salePrice: $salePrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderGoodsDTOImpl &&
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

  /// Create a copy of OrderGoodsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderGoodsDTOImplCopyWith<_$OrderGoodsDTOImpl> get copyWith =>
      __$$OrderGoodsDTOImplCopyWithImpl<_$OrderGoodsDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderGoodsDTOImplToJson(this);
  }
}

abstract class _OrderGoodsDTO implements OrderGoodsDTO {
  const factory _OrderGoodsDTO({
    required final String orderGoodsId,
    final String? goodsName,
    required final int quantity,
    required final int salePrice,
  }) = _$OrderGoodsDTOImpl;

  factory _OrderGoodsDTO.fromJson(Map<String, dynamic> json) =
      _$OrderGoodsDTOImpl.fromJson;

  @override
  String get orderGoodsId;
  @override
  String? get goodsName;
  @override
  int get quantity;
  @override
  int get salePrice;

  /// Create a copy of OrderGoodsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderGoodsDTOImplCopyWith<_$OrderGoodsDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
