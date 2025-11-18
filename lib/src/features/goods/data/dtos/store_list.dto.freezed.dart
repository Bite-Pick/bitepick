// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_list.dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StoreListDTO _$StoreListDTOFromJson(Map<String, dynamic> json) {
  return _StoreListDTO.fromJson(json);
}

/// @nodoc
mixin _$StoreListDTO {
  String get storeId => throw _privateConstructorUsedError;
  String get storeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'ImageUrl')
  List<String> get imageUrl => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String? get goodsName => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  int get originPrice => throw _privateConstructorUsedError;
  int get discount => throw _privateConstructorUsedError;
  int get salePrice => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get distance => throw _privateConstructorUsedError;
  String get saleStatus => throw _privateConstructorUsedError;

  /// Serializes this StoreListDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoreListDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoreListDTOCopyWith<StoreListDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreListDTOCopyWith<$Res> {
  factory $StoreListDTOCopyWith(
    StoreListDTO value,
    $Res Function(StoreListDTO) then,
  ) = _$StoreListDTOCopyWithImpl<$Res, StoreListDTO>;
  @useResult
  $Res call({
    String storeId,
    String storeName,
    @JsonKey(name: 'ImageUrl') List<String> imageUrl,
    double latitude,
    double longitude,
    String address,
    String? goodsName,
    String startTime,
    String endTime,
    int originPrice,
    int discount,
    int salePrice,
    int quantity,
    double distance,
    String saleStatus,
  });
}

/// @nodoc
class _$StoreListDTOCopyWithImpl<$Res, $Val extends StoreListDTO>
    implements $StoreListDTOCopyWith<$Res> {
  _$StoreListDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoreListDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? storeName = null,
    Object? imageUrl = null,
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
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
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
                      as int,
            salePrice: null == salePrice
                ? _value.salePrice
                : salePrice // ignore: cast_nullable_to_non_nullable
                      as int,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$StoreListDTOImplCopyWith<$Res>
    implements $StoreListDTOCopyWith<$Res> {
  factory _$$StoreListDTOImplCopyWith(
    _$StoreListDTOImpl value,
    $Res Function(_$StoreListDTOImpl) then,
  ) = __$$StoreListDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String storeId,
    String storeName,
    @JsonKey(name: 'ImageUrl') List<String> imageUrl,
    double latitude,
    double longitude,
    String address,
    String? goodsName,
    String startTime,
    String endTime,
    int originPrice,
    int discount,
    int salePrice,
    int quantity,
    double distance,
    String saleStatus,
  });
}

/// @nodoc
class __$$StoreListDTOImplCopyWithImpl<$Res>
    extends _$StoreListDTOCopyWithImpl<$Res, _$StoreListDTOImpl>
    implements _$$StoreListDTOImplCopyWith<$Res> {
  __$$StoreListDTOImplCopyWithImpl(
    _$StoreListDTOImpl _value,
    $Res Function(_$StoreListDTOImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoreListDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? storeName = null,
    Object? imageUrl = null,
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
      _$StoreListDTOImpl(
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
                  as int,
        salePrice: null == salePrice
            ? _value.salePrice
            : salePrice // ignore: cast_nullable_to_non_nullable
                  as int,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$StoreListDTOImpl extends _StoreListDTO {
  const _$StoreListDTOImpl({
    required this.storeId,
    required this.storeName,
    @JsonKey(name: 'ImageUrl') required final List<String> imageUrl,
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
  }) : _imageUrl = imageUrl,
       super._();

  factory _$StoreListDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoreListDTOImplFromJson(json);

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
  final int discount;
  @override
  final int salePrice;
  @override
  final int quantity;
  @override
  final double distance;
  @override
  final String saleStatus;

  @override
  String toString() {
    return 'StoreListDTO(storeId: $storeId, storeName: $storeName, imageUrl: $imageUrl, latitude: $latitude, longitude: $longitude, address: $address, goodsName: $goodsName, startTime: $startTime, endTime: $endTime, originPrice: $originPrice, discount: $discount, salePrice: $salePrice, quantity: $quantity, distance: $distance, saleStatus: $saleStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreListDTOImpl &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.storeName, storeName) ||
                other.storeName == storeName) &&
            const DeepCollectionEquality().equals(other._imageUrl, _imageUrl) &&
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
    const DeepCollectionEquality().hash(_imageUrl),
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

  /// Create a copy of StoreListDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreListDTOImplCopyWith<_$StoreListDTOImpl> get copyWith =>
      __$$StoreListDTOImplCopyWithImpl<_$StoreListDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoreListDTOImplToJson(this);
  }
}

abstract class _StoreListDTO extends StoreListDTO {
  const factory _StoreListDTO({
    required final String storeId,
    required final String storeName,
    @JsonKey(name: 'ImageUrl') required final List<String> imageUrl,
    required final double latitude,
    required final double longitude,
    required final String address,
    final String? goodsName,
    required final String startTime,
    required final String endTime,
    required final int originPrice,
    required final int discount,
    required final int salePrice,
    required final int quantity,
    required final double distance,
    required final String saleStatus,
  }) = _$StoreListDTOImpl;
  const _StoreListDTO._() : super._();

  factory _StoreListDTO.fromJson(Map<String, dynamic> json) =
      _$StoreListDTOImpl.fromJson;

  @override
  String get storeId;
  @override
  String get storeName;
  @override
  @JsonKey(name: 'ImageUrl')
  List<String> get imageUrl;
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
  int get discount;
  @override
  int get salePrice;
  @override
  int get quantity;
  @override
  double get distance;
  @override
  String get saleStatus;

  /// Create a copy of StoreListDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoreListDTOImplCopyWith<_$StoreListDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
