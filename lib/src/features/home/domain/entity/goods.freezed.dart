// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goods.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Goods _$GoodsFromJson(Map<String, dynamic> json) {
  return _Goods.fromJson(json);
}

/// @nodoc
mixin _$Goods {
  String get storeId => throw _privateConstructorUsedError;
  String get storeName => throw _privateConstructorUsedError;
  List<String> get ImageUrl => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String? get goodsName => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  int get originPrice => throw _privateConstructorUsedError;
  double get discount => throw _privateConstructorUsedError;
  double get salePrice => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  double get distance => throw _privateConstructorUsedError;
  String get saleStatus => throw _privateConstructorUsedError;

  /// Serializes this Goods to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Goods
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoodsCopyWith<Goods> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoodsCopyWith<$Res> {
  factory $GoodsCopyWith(Goods value, $Res Function(Goods) then) =
      _$GoodsCopyWithImpl<$Res, Goods>;
  @useResult
  $Res call({
    String storeId,
    String storeName,
    List<String> ImageUrl,
    double latitude,
    double longitude,
    String address,
    String? goodsName,
    String startTime,
    String endTime,
    int originPrice,
    double discount,
    double salePrice,
    double quantity,
    double distance,
    String saleStatus,
  });
}

/// @nodoc
class _$GoodsCopyWithImpl<$Res, $Val extends Goods>
    implements $GoodsCopyWith<$Res> {
  _$GoodsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Goods
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? storeName = null,
    Object? ImageUrl = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? address = null,
    Object? goodsName = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? originPrice = null,
    Object? discount = null,
    Object? salePrice = null,
    Object? quantity = null,
    Object? distance = null,
    Object? saleStatus = null,
  }) {
    return _then(
      _value.copyWith(
            storeId: null == storeId
                ? _value.storeId
                : storeId // ignore: cast_nullable_to_non_nullable
                      as String,
            storeName: null == storeName
                ? _value.storeName
                : storeName // ignore: cast_nullable_to_non_nullable
                      as String,
            ImageUrl: null == ImageUrl
                ? _value.ImageUrl
                : ImageUrl // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            goodsName: freezed == goodsName
                ? _value.goodsName
                : goodsName // ignore: cast_nullable_to_non_nullable
                      as String?,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as String,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as String,
            originPrice: null == originPrice
                ? _value.originPrice
                : originPrice // ignore: cast_nullable_to_non_nullable
                      as int,
            discount: null == discount
                ? _value.discount
                : discount // ignore: cast_nullable_to_non_nullable
                      as double,
            salePrice: null == salePrice
                ? _value.salePrice
                : salePrice // ignore: cast_nullable_to_non_nullable
                      as double,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as double,
            distance: null == distance
                ? _value.distance
                : distance // ignore: cast_nullable_to_non_nullable
                      as double,
            saleStatus: null == saleStatus
                ? _value.saleStatus
                : saleStatus // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GoodsImplCopyWith<$Res> implements $GoodsCopyWith<$Res> {
  factory _$$GoodsImplCopyWith(
    _$GoodsImpl value,
    $Res Function(_$GoodsImpl) then,
  ) = __$$GoodsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String storeId,
    String storeName,
    List<String> ImageUrl,
    double latitude,
    double longitude,
    String address,
    String? goodsName,
    String startTime,
    String endTime,
    int originPrice,
    double discount,
    double salePrice,
    double quantity,
    double distance,
    String saleStatus,
  });
}

/// @nodoc
class __$$GoodsImplCopyWithImpl<$Res>
    extends _$GoodsCopyWithImpl<$Res, _$GoodsImpl>
    implements _$$GoodsImplCopyWith<$Res> {
  __$$GoodsImplCopyWithImpl(
    _$GoodsImpl _value,
    $Res Function(_$GoodsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Goods
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? storeName = null,
    Object? ImageUrl = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? address = null,
    Object? goodsName = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? originPrice = null,
    Object? discount = null,
    Object? salePrice = null,
    Object? quantity = null,
    Object? distance = null,
    Object? saleStatus = null,
  }) {
    return _then(
      _$GoodsImpl(
        storeId: null == storeId
            ? _value.storeId
            : storeId // ignore: cast_nullable_to_non_nullable
                  as String,
        storeName: null == storeName
            ? _value.storeName
            : storeName // ignore: cast_nullable_to_non_nullable
                  as String,
        ImageUrl: null == ImageUrl
            ? _value._ImageUrl
            : ImageUrl // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        goodsName: freezed == goodsName
            ? _value.goodsName
            : goodsName // ignore: cast_nullable_to_non_nullable
                  as String?,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as String,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as String,
        originPrice: null == originPrice
            ? _value.originPrice
            : originPrice // ignore: cast_nullable_to_non_nullable
                  as int,
        discount: null == discount
            ? _value.discount
            : discount // ignore: cast_nullable_to_non_nullable
                  as double,
        salePrice: null == salePrice
            ? _value.salePrice
            : salePrice // ignore: cast_nullable_to_non_nullable
                  as double,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as double,
        distance: null == distance
            ? _value.distance
            : distance // ignore: cast_nullable_to_non_nullable
                  as double,
        saleStatus: null == saleStatus
            ? _value.saleStatus
            : saleStatus // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GoodsImpl extends _Goods {
  const _$GoodsImpl({
    required this.storeId,
    required this.storeName,
    required final List<String> ImageUrl,
    required this.latitude,
    required this.longitude,
    required this.address,
    this.goodsName,
    required this.startTime,
    required this.endTime,
    required this.originPrice,
    required this.discount,
    required this.salePrice,
    required this.quantity,
    required this.distance,
    required this.saleStatus,
  }) : _ImageUrl = ImageUrl,
       super._();

  factory _$GoodsImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoodsImplFromJson(json);

  @override
  final String storeId;
  @override
  final String storeName;
  final List<String> _ImageUrl;
  @override
  List<String> get ImageUrl {
    if (_ImageUrl is EqualUnmodifiableListView) return _ImageUrl;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ImageUrl);
  }

  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String address;
  @override
  final String? goodsName;
  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final int originPrice;
  @override
  final double discount;
  @override
  final double salePrice;
  @override
  final double quantity;
  @override
  final double distance;
  @override
  final String saleStatus;

  @override
  String toString() {
    return 'Goods(storeId: $storeId, storeName: $storeName, ImageUrl: $ImageUrl, latitude: $latitude, longitude: $longitude, address: $address, goodsName: $goodsName, startTime: $startTime, endTime: $endTime, originPrice: $originPrice, discount: $discount, salePrice: $salePrice, quantity: $quantity, distance: $distance, saleStatus: $saleStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoodsImpl &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.storeName, storeName) ||
                other.storeName == storeName) &&
            const DeepCollectionEquality().equals(other._ImageUrl, _ImageUrl) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.goodsName, goodsName) ||
                other.goodsName == goodsName) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.originPrice, originPrice) ||
                other.originPrice == originPrice) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.salePrice, salePrice) ||
                other.salePrice == salePrice) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.saleStatus, saleStatus) ||
                other.saleStatus == saleStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    storeId,
    storeName,
    const DeepCollectionEquality().hash(_ImageUrl),
    latitude,
    longitude,
    address,
    goodsName,
    startTime,
    endTime,
    originPrice,
    discount,
    salePrice,
    quantity,
    distance,
    saleStatus,
  );

  /// Create a copy of Goods
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoodsImplCopyWith<_$GoodsImpl> get copyWith =>
      __$$GoodsImplCopyWithImpl<_$GoodsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoodsImplToJson(this);
  }
}

abstract class _Goods extends Goods {
  const factory _Goods({
    required final String storeId,
    required final String storeName,
    required final List<String> ImageUrl,
    required final double latitude,
    required final double longitude,
    required final String address,
    final String? goodsName,
    required final String startTime,
    required final String endTime,
    required final int originPrice,
    required final double discount,
    required final double salePrice,
    required final double quantity,
    required final double distance,
    required final String saleStatus,
  }) = _$GoodsImpl;
  const _Goods._() : super._();

  factory _Goods.fromJson(Map<String, dynamic> json) = _$GoodsImpl.fromJson;

  @override
  String get storeId;
  @override
  String get storeName;
  @override
  List<String> get ImageUrl;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get address;
  @override
  String? get goodsName;
  @override
  String get startTime;
  @override
  String get endTime;
  @override
  int get originPrice;
  @override
  double get discount;
  @override
  double get salePrice;
  @override
  double get quantity;
  @override
  double get distance;
  @override
  String get saleStatus;

  /// Create a copy of Goods
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoodsImplCopyWith<_$GoodsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
