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
  String? get goodsId => throw _privateConstructorUsedError;
  String? get storeId => throw _privateConstructorUsedError;
  String? get storeName => throw _privateConstructorUsedError;
  String? get goodsName => throw _privateConstructorUsedError;
  List<String>? get ImageUrl => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  double? get distance => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  int get originPrice => throw _privateConstructorUsedError;
  int get discount => throw _privateConstructorUsedError;
  int get salePrice => throw _privateConstructorUsedError;
  int get stockQuantity => throw _privateConstructorUsedError;
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
    String? goodsId,
    String? storeId,
    String? storeName,
    String? goodsName,
    List<String>? ImageUrl,
    double? latitude,
    double? longitude,
    double? distance,
    String? address,
    String? description,
    String startTime,
    String endTime,
    int originPrice,
    int discount,
    int salePrice,
    int stockQuantity,
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
    Object? goodsId = freezed,
    Object? storeId = freezed,
    Object? storeName = freezed,
    Object? goodsName = freezed,
    Object? ImageUrl = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? distance = freezed,
    Object? address = freezed,
    Object? description = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? originPrice = null,
    Object? discount = null,
    Object? salePrice = null,
    Object? stockQuantity = null,
    Object? saleStatus = null,
  }) {
    return _then(
      _value.copyWith(
            goodsId: freezed == goodsId
                ? _value.goodsId
                : goodsId // ignore: cast_nullable_to_non_nullable
                      as String?,
            storeId: freezed == storeId
                ? _value.storeId
                : storeId // ignore: cast_nullable_to_non_nullable
                      as String?,
            storeName: freezed == storeName
                ? _value.storeName
                : storeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            goodsName: freezed == goodsName
                ? _value.goodsName
                : goodsName // ignore: cast_nullable_to_non_nullable
                      as String?,
            ImageUrl: freezed == ImageUrl
                ? _value.ImageUrl
                : ImageUrl // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            distance: freezed == distance
                ? _value.distance
                : distance // ignore: cast_nullable_to_non_nullable
                      as double?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
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
                      as int,
            salePrice: null == salePrice
                ? _value.salePrice
                : salePrice // ignore: cast_nullable_to_non_nullable
                      as int,
            stockQuantity: null == stockQuantity
                ? _value.stockQuantity
                : stockQuantity // ignore: cast_nullable_to_non_nullable
                      as int,
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
    String? goodsId,
    String? storeId,
    String? storeName,
    String? goodsName,
    List<String>? ImageUrl,
    double? latitude,
    double? longitude,
    double? distance,
    String? address,
    String? description,
    String startTime,
    String endTime,
    int originPrice,
    int discount,
    int salePrice,
    int stockQuantity,
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
    Object? goodsId = freezed,
    Object? storeId = freezed,
    Object? storeName = freezed,
    Object? goodsName = freezed,
    Object? ImageUrl = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? distance = freezed,
    Object? address = freezed,
    Object? description = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? originPrice = null,
    Object? discount = null,
    Object? salePrice = null,
    Object? stockQuantity = null,
    Object? saleStatus = null,
  }) {
    return _then(
      _$GoodsImpl(
        goodsId: freezed == goodsId
            ? _value.goodsId
            : goodsId // ignore: cast_nullable_to_non_nullable
                  as String?,
        storeId: freezed == storeId
            ? _value.storeId
            : storeId // ignore: cast_nullable_to_non_nullable
                  as String?,
        storeName: freezed == storeName
            ? _value.storeName
            : storeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        goodsName: freezed == goodsName
            ? _value.goodsName
            : goodsName // ignore: cast_nullable_to_non_nullable
                  as String?,
        ImageUrl: freezed == ImageUrl
            ? _value._ImageUrl
            : ImageUrl // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        distance: freezed == distance
            ? _value.distance
            : distance // ignore: cast_nullable_to_non_nullable
                  as double?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
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
                  as int,
        salePrice: null == salePrice
            ? _value.salePrice
            : salePrice // ignore: cast_nullable_to_non_nullable
                  as int,
        stockQuantity: null == stockQuantity
            ? _value.stockQuantity
            : stockQuantity // ignore: cast_nullable_to_non_nullable
                  as int,
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
    this.goodsId,
    this.storeId,
    this.storeName,
    this.goodsName,
    final List<String>? ImageUrl,
    this.latitude,
    this.longitude,
    this.distance,
    this.address,
    this.description,
    required this.startTime,
    required this.endTime,
    required this.originPrice,
    required this.discount,
    required this.salePrice,
    required this.stockQuantity,
    required this.saleStatus,
  }) : _ImageUrl = ImageUrl,
       super._();

  factory _$GoodsImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoodsImplFromJson(json);

  @override
  final String? goodsId;
  @override
  final String? storeId;
  @override
  final String? storeName;
  @override
  final String? goodsName;
  final List<String>? _ImageUrl;
  @override
  List<String>? get ImageUrl {
    final value = _ImageUrl;
    if (value == null) return null;
    if (_ImageUrl is EqualUnmodifiableListView) return _ImageUrl;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final double? distance;
  @override
  final String? address;
  @override
  final String? description;
  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final int originPrice;
  @override
  final int discount;
  @override
  final int salePrice;
  @override
  final int stockQuantity;
  @override
  final String saleStatus;

  @override
  String toString() {
    return 'Goods(goodsId: $goodsId, storeId: $storeId, storeName: $storeName, goodsName: $goodsName, ImageUrl: $ImageUrl, latitude: $latitude, longitude: $longitude, distance: $distance, address: $address, description: $description, startTime: $startTime, endTime: $endTime, originPrice: $originPrice, discount: $discount, salePrice: $salePrice, stockQuantity: $stockQuantity, saleStatus: $saleStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoodsImpl &&
            (identical(other.goodsId, goodsId) || other.goodsId == goodsId) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.storeName, storeName) ||
                other.storeName == storeName) &&
            (identical(other.goodsName, goodsName) ||
                other.goodsName == goodsName) &&
            const DeepCollectionEquality().equals(other._ImageUrl, _ImageUrl) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.originPrice, originPrice) ||
                other.originPrice == originPrice) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.salePrice, salePrice) ||
                other.salePrice == salePrice) &&
            (identical(other.stockQuantity, stockQuantity) ||
                other.stockQuantity == stockQuantity) &&
            (identical(other.saleStatus, saleStatus) ||
                other.saleStatus == saleStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    goodsId,
    storeId,
    storeName,
    goodsName,
    const DeepCollectionEquality().hash(_ImageUrl),
    latitude,
    longitude,
    distance,
    address,
    description,
    startTime,
    endTime,
    originPrice,
    discount,
    salePrice,
    stockQuantity,
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
    final String? goodsId,
    final String? storeId,
    final String? storeName,
    final String? goodsName,
    final List<String>? ImageUrl,
    final double? latitude,
    final double? longitude,
    final double? distance,
    final String? address,
    final String? description,
    required final String startTime,
    required final String endTime,
    required final int originPrice,
    required final int discount,
    required final int salePrice,
    required final int stockQuantity,
    required final String saleStatus,
  }) = _$GoodsImpl;
  const _Goods._() : super._();

  factory _Goods.fromJson(Map<String, dynamic> json) = _$GoodsImpl.fromJson;

  @override
  String? get goodsId;
  @override
  String? get storeId;
  @override
  String? get storeName;
  @override
  String? get goodsName;
  @override
  List<String>? get ImageUrl;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  double? get distance;
  @override
  String? get address;
  @override
  String? get description;
  @override
  String get startTime;
  @override
  String get endTime;
  @override
  int get originPrice;
  @override
  int get discount;
  @override
  int get salePrice;
  @override
  int get stockQuantity;
  @override
  String get saleStatus;

  /// Create a copy of Goods
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoodsImplCopyWith<_$GoodsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GoodsImagesList _$GoodsImagesListFromJson(Map<String, dynamic> json) {
  return _GoodsImagesList.fromJson(json);
}

/// @nodoc
mixin _$GoodsImagesList {
  int get goodsImageId => throw _privateConstructorUsedError;
  String get goodsName => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this GoodsImagesList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GoodsImagesList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoodsImagesListCopyWith<GoodsImagesList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoodsImagesListCopyWith<$Res> {
  factory $GoodsImagesListCopyWith(
    GoodsImagesList value,
    $Res Function(GoodsImagesList) then,
  ) = _$GoodsImagesListCopyWithImpl<$Res, GoodsImagesList>;
  @useResult
  $Res call({int goodsImageId, String goodsName, String imageUrl});
}

/// @nodoc
class _$GoodsImagesListCopyWithImpl<$Res, $Val extends GoodsImagesList>
    implements $GoodsImagesListCopyWith<$Res> {
  _$GoodsImagesListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GoodsImagesList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goodsImageId = null,
    Object? goodsName = null,
    Object? imageUrl = null,
  }) {
    return _then(
      _value.copyWith(
            goodsImageId: null == goodsImageId
                ? _value.goodsImageId
                : goodsImageId // ignore: cast_nullable_to_non_nullable
                      as int,
            goodsName: null == goodsName
                ? _value.goodsName
                : goodsName // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GoodsImagesListImplCopyWith<$Res>
    implements $GoodsImagesListCopyWith<$Res> {
  factory _$$GoodsImagesListImplCopyWith(
    _$GoodsImagesListImpl value,
    $Res Function(_$GoodsImagesListImpl) then,
  ) = __$$GoodsImagesListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int goodsImageId, String goodsName, String imageUrl});
}

/// @nodoc
class __$$GoodsImagesListImplCopyWithImpl<$Res>
    extends _$GoodsImagesListCopyWithImpl<$Res, _$GoodsImagesListImpl>
    implements _$$GoodsImagesListImplCopyWith<$Res> {
  __$$GoodsImagesListImplCopyWithImpl(
    _$GoodsImagesListImpl _value,
    $Res Function(_$GoodsImagesListImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GoodsImagesList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goodsImageId = null,
    Object? goodsName = null,
    Object? imageUrl = null,
  }) {
    return _then(
      _$GoodsImagesListImpl(
        goodsImageId: null == goodsImageId
            ? _value.goodsImageId
            : goodsImageId // ignore: cast_nullable_to_non_nullable
                  as int,
        goodsName: null == goodsName
            ? _value.goodsName
            : goodsName // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GoodsImagesListImpl extends _GoodsImagesList {
  const _$GoodsImagesListImpl({
    required this.goodsImageId,
    required this.goodsName,
    required this.imageUrl,
  }) : super._();

  factory _$GoodsImagesListImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoodsImagesListImplFromJson(json);

  @override
  final int goodsImageId;
  @override
  final String goodsName;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'GoodsImagesList(goodsImageId: $goodsImageId, goodsName: $goodsName, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoodsImagesListImpl &&
            (identical(other.goodsImageId, goodsImageId) ||
                other.goodsImageId == goodsImageId) &&
            (identical(other.goodsName, goodsName) ||
                other.goodsName == goodsName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, goodsImageId, goodsName, imageUrl);

  /// Create a copy of GoodsImagesList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoodsImagesListImplCopyWith<_$GoodsImagesListImpl> get copyWith =>
      __$$GoodsImagesListImplCopyWithImpl<_$GoodsImagesListImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GoodsImagesListImplToJson(this);
  }
}

abstract class _GoodsImagesList extends GoodsImagesList {
  const factory _GoodsImagesList({
    required final int goodsImageId,
    required final String goodsName,
    required final String imageUrl,
  }) = _$GoodsImagesListImpl;
  const _GoodsImagesList._() : super._();

  factory _GoodsImagesList.fromJson(Map<String, dynamic> json) =
      _$GoodsImagesListImpl.fromJson;

  @override
  int get goodsImageId;
  @override
  String get goodsName;
  @override
  String get imageUrl;

  /// Create a copy of GoodsImagesList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoodsImagesListImplCopyWith<_$GoodsImagesListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
