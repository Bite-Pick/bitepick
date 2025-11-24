// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pending_store.dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PendingStoreDto _$PendingStoreDtoFromJson(Map<String, dynamic> json) {
  return _PendingStoreDto.fromJson(json);
}

/// @nodoc
mixin _$PendingStoreDto {
  String get storeId => throw _privateConstructorUsedError;
  String get storeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'ImageUrl')
  List<String> get imageUrl => throw _privateConstructorUsedError;
  String? get goodsName => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  int get originPrice => throw _privateConstructorUsedError;
  int get discount => throw _privateConstructorUsedError;
  int get salePrice => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double? get distance => throw _privateConstructorUsedError;
  String get saleStatus => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;

  /// Serializes this PendingStoreDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PendingStoreDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PendingStoreDtoCopyWith<PendingStoreDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PendingStoreDtoCopyWith<$Res> {
  factory $PendingStoreDtoCopyWith(
    PendingStoreDto value,
    $Res Function(PendingStoreDto) then,
  ) = _$PendingStoreDtoCopyWithImpl<$Res, PendingStoreDto>;
  @useResult
  $Res call({
    String storeId,
    String storeName,
    @JsonKey(name: 'ImageUrl') List<String> imageUrl,
    String? goodsName,
    String startTime,
    String endTime,
    int originPrice,
    int discount,
    int salePrice,
    int quantity,
    double? distance,
    String saleStatus,
    double longitude,
    double latitude,
    String address,
  });
}

/// @nodoc
class _$PendingStoreDtoCopyWithImpl<$Res, $Val extends PendingStoreDto>
    implements $PendingStoreDtoCopyWith<$Res> {
  _$PendingStoreDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PendingStoreDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? storeName = null,
    Object? imageUrl = null,
    Object? goodsName = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? originPrice = null,
    Object? discount = null,
    Object? salePrice = null,
    Object? quantity = null,
    Object? distance = freezed,
    Object? saleStatus = null,
    Object? longitude = null,
    Object? latitude = null,
    Object? address = null,
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
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as List<String>,
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
                      as int,
            salePrice: null == salePrice
                ? _value.salePrice
                : salePrice // ignore: cast_nullable_to_non_nullable
                      as int,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            distance: freezed == distance
                ? _value.distance
                : distance // ignore: cast_nullable_to_non_nullable
                      as double?,
            saleStatus: null == saleStatus
                ? _value.saleStatus
                : saleStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PendingStoreDtoImplCopyWith<$Res>
    implements $PendingStoreDtoCopyWith<$Res> {
  factory _$$PendingStoreDtoImplCopyWith(
    _$PendingStoreDtoImpl value,
    $Res Function(_$PendingStoreDtoImpl) then,
  ) = __$$PendingStoreDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String storeId,
    String storeName,
    @JsonKey(name: 'ImageUrl') List<String> imageUrl,
    String? goodsName,
    String startTime,
    String endTime,
    int originPrice,
    int discount,
    int salePrice,
    int quantity,
    double? distance,
    String saleStatus,
    double longitude,
    double latitude,
    String address,
  });
}

/// @nodoc
class __$$PendingStoreDtoImplCopyWithImpl<$Res>
    extends _$PendingStoreDtoCopyWithImpl<$Res, _$PendingStoreDtoImpl>
    implements _$$PendingStoreDtoImplCopyWith<$Res> {
  __$$PendingStoreDtoImplCopyWithImpl(
    _$PendingStoreDtoImpl _value,
    $Res Function(_$PendingStoreDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PendingStoreDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? storeName = null,
    Object? imageUrl = null,
    Object? goodsName = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? originPrice = null,
    Object? discount = null,
    Object? salePrice = null,
    Object? quantity = null,
    Object? distance = freezed,
    Object? saleStatus = null,
    Object? longitude = null,
    Object? latitude = null,
    Object? address = null,
  }) {
    return _then(
      _$PendingStoreDtoImpl(
        storeId: null == storeId
            ? _value.storeId
            : storeId // ignore: cast_nullable_to_non_nullable
                  as String,
        storeName: null == storeName
            ? _value.storeName
            : storeName // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value._imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as List<String>,
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
                  as int,
        salePrice: null == salePrice
            ? _value.salePrice
            : salePrice // ignore: cast_nullable_to_non_nullable
                  as int,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        distance: freezed == distance
            ? _value.distance
            : distance // ignore: cast_nullable_to_non_nullable
                  as double?,
        saleStatus: null == saleStatus
            ? _value.saleStatus
            : saleStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PendingStoreDtoImpl implements _PendingStoreDto {
  const _$PendingStoreDtoImpl({
    required this.storeId,
    required this.storeName,
    @JsonKey(name: 'ImageUrl') required final List<String> imageUrl,
    this.goodsName,
    required this.startTime,
    required this.endTime,
    required this.originPrice,
    required this.discount,
    required this.salePrice,
    required this.quantity,
    this.distance,
    required this.saleStatus,
    required this.longitude,
    required this.latitude,
    required this.address,
  }) : _imageUrl = imageUrl;

  factory _$PendingStoreDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PendingStoreDtoImplFromJson(json);

  @override
  final String storeId;
  @override
  final String storeName;
  final List<String> _imageUrl;
  @override
  @JsonKey(name: 'ImageUrl')
  List<String> get imageUrl {
    if (_imageUrl is EqualUnmodifiableListView) return _imageUrl;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrl);
  }

  @override
  final String? goodsName;
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
  final int quantity;
  @override
  final double? distance;
  @override
  final String saleStatus;
  @override
  final double longitude;
  @override
  final double latitude;
  @override
  final String address;

  @override
  String toString() {
    return 'PendingStoreDto(storeId: $storeId, storeName: $storeName, imageUrl: $imageUrl, goodsName: $goodsName, startTime: $startTime, endTime: $endTime, originPrice: $originPrice, discount: $discount, salePrice: $salePrice, quantity: $quantity, distance: $distance, saleStatus: $saleStatus, longitude: $longitude, latitude: $latitude, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PendingStoreDtoImpl &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.storeName, storeName) ||
                other.storeName == storeName) &&
            const DeepCollectionEquality().equals(other._imageUrl, _imageUrl) &&
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
                other.saleStatus == saleStatus) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    storeId,
    storeName,
    const DeepCollectionEquality().hash(_imageUrl),
    goodsName,
    startTime,
    endTime,
    originPrice,
    discount,
    salePrice,
    quantity,
    distance,
    saleStatus,
    longitude,
    latitude,
    address,
  );

  /// Create a copy of PendingStoreDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PendingStoreDtoImplCopyWith<_$PendingStoreDtoImpl> get copyWith =>
      __$$PendingStoreDtoImplCopyWithImpl<_$PendingStoreDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PendingStoreDtoImplToJson(this);
  }
}

abstract class _PendingStoreDto implements PendingStoreDto {
  const factory _PendingStoreDto({
    required final String storeId,
    required final String storeName,
    @JsonKey(name: 'ImageUrl') required final List<String> imageUrl,
    final String? goodsName,
    required final String startTime,
    required final String endTime,
    required final int originPrice,
    required final int discount,
    required final int salePrice,
    required final int quantity,
    final double? distance,
    required final String saleStatus,
    required final double longitude,
    required final double latitude,
    required final String address,
  }) = _$PendingStoreDtoImpl;

  factory _PendingStoreDto.fromJson(Map<String, dynamic> json) =
      _$PendingStoreDtoImpl.fromJson;

  @override
  String get storeId;
  @override
  String get storeName;
  @override
  @JsonKey(name: 'ImageUrl')
  List<String> get imageUrl;
  @override
  String? get goodsName;
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
  int get quantity;
  @override
  double? get distance;
  @override
  String get saleStatus;
  @override
  double get longitude;
  @override
  double get latitude;
  @override
  String get address;

  /// Create a copy of PendingStoreDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PendingStoreDtoImplCopyWith<_$PendingStoreDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
