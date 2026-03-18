// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registered_store.dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RegisteredStoreDto _$RegisteredStoreDtoFromJson(Map<String, dynamic> json) {
  return _RegisteredStoreDto.fromJson(json);
}

/// @nodoc
mixin _$RegisteredStoreDto {
  String get storeId => throw _privateConstructorUsedError;
  String get storeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'ImageUrl')
  List<String> get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'GoodImageUrl')
  List<String> get goodsImages => throw _privateConstructorUsedError;
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
  String get ownerName => throw _privateConstructorUsedError;
  String get ownerPhone => throw _privateConstructorUsedError;
  String get businessNumber => throw _privateConstructorUsedError;
  String get bankName => throw _privateConstructorUsedError;
  String get bankAccount => throw _privateConstructorUsedError;

  /// Serializes this RegisteredStoreDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegisteredStoreDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisteredStoreDtoCopyWith<RegisteredStoreDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisteredStoreDtoCopyWith<$Res> {
  factory $RegisteredStoreDtoCopyWith(
    RegisteredStoreDto value,
    $Res Function(RegisteredStoreDto) then,
  ) = _$RegisteredStoreDtoCopyWithImpl<$Res, RegisteredStoreDto>;
  @useResult
  $Res call({
    String storeId,
    String storeName,
    @JsonKey(name: 'ImageUrl') List<String> imageUrl,
    @JsonKey(name: 'GoodImageUrl') List<String> goodsImages,
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
    String ownerName,
    String ownerPhone,
    String businessNumber,
    String bankName,
    String bankAccount,
  });
}

/// @nodoc
class _$RegisteredStoreDtoCopyWithImpl<$Res, $Val extends RegisteredStoreDto>
    implements $RegisteredStoreDtoCopyWith<$Res> {
  _$RegisteredStoreDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisteredStoreDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? storeName = null,
    Object? imageUrl = null,
    Object? goodsImages = null,
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
    Object? ownerName = null,
    Object? ownerPhone = null,
    Object? businessNumber = null,
    Object? bankName = null,
    Object? bankAccount = null,
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
            goodsImages: null == goodsImages
                ? _value.goodsImages
                : goodsImages // ignore: cast_nullable_to_non_nullable
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
            ownerName: null == ownerName
                ? _value.ownerName
                : ownerName // ignore: cast_nullable_to_non_nullable
                      as String,
            ownerPhone: null == ownerPhone
                ? _value.ownerPhone
                : ownerPhone // ignore: cast_nullable_to_non_nullable
                      as String,
            businessNumber: null == businessNumber
                ? _value.businessNumber
                : businessNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            bankName: null == bankName
                ? _value.bankName
                : bankName // ignore: cast_nullable_to_non_nullable
                      as String,
            bankAccount: null == bankAccount
                ? _value.bankAccount
                : bankAccount // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RegisteredStoreDtoImplCopyWith<$Res>
    implements $RegisteredStoreDtoCopyWith<$Res> {
  factory _$$RegisteredStoreDtoImplCopyWith(
    _$RegisteredStoreDtoImpl value,
    $Res Function(_$RegisteredStoreDtoImpl) then,
  ) = __$$RegisteredStoreDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String storeId,
    String storeName,
    @JsonKey(name: 'ImageUrl') List<String> imageUrl,
    @JsonKey(name: 'GoodImageUrl') List<String> goodsImages,
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
    String ownerName,
    String ownerPhone,
    String businessNumber,
    String bankName,
    String bankAccount,
  });
}

/// @nodoc
class __$$RegisteredStoreDtoImplCopyWithImpl<$Res>
    extends _$RegisteredStoreDtoCopyWithImpl<$Res, _$RegisteredStoreDtoImpl>
    implements _$$RegisteredStoreDtoImplCopyWith<$Res> {
  __$$RegisteredStoreDtoImplCopyWithImpl(
    _$RegisteredStoreDtoImpl _value,
    $Res Function(_$RegisteredStoreDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RegisteredStoreDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? storeName = null,
    Object? imageUrl = null,
    Object? goodsImages = null,
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
    Object? ownerName = null,
    Object? ownerPhone = null,
    Object? businessNumber = null,
    Object? bankName = null,
    Object? bankAccount = null,
  }) {
    return _then(
      _$RegisteredStoreDtoImpl(
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
        goodsImages: null == goodsImages
            ? _value._goodsImages
            : goodsImages // ignore: cast_nullable_to_non_nullable
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
        ownerName: null == ownerName
            ? _value.ownerName
            : ownerName // ignore: cast_nullable_to_non_nullable
                  as String,
        ownerPhone: null == ownerPhone
            ? _value.ownerPhone
            : ownerPhone // ignore: cast_nullable_to_non_nullable
                  as String,
        businessNumber: null == businessNumber
            ? _value.businessNumber
            : businessNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        bankName: null == bankName
            ? _value.bankName
            : bankName // ignore: cast_nullable_to_non_nullable
                  as String,
        bankAccount: null == bankAccount
            ? _value.bankAccount
            : bankAccount // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisteredStoreDtoImpl implements _RegisteredStoreDto {
  const _$RegisteredStoreDtoImpl({
    required this.storeId,
    required this.storeName,
    @JsonKey(name: 'ImageUrl') final List<String> imageUrl = const [],
    @JsonKey(name: 'GoodImageUrl') final List<String> goodsImages = const [],
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
    required this.ownerName,
    required this.ownerPhone,
    required this.businessNumber,
    required this.bankName,
    required this.bankAccount,
  }) : _imageUrl = imageUrl,
       _goodsImages = goodsImages;

  factory _$RegisteredStoreDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisteredStoreDtoImplFromJson(json);

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

  final List<String> _goodsImages;
  @override
  @JsonKey(name: 'GoodImageUrl')
  List<String> get goodsImages {
    if (_goodsImages is EqualUnmodifiableListView) return _goodsImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_goodsImages);
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
  final String ownerName;
  @override
  final String ownerPhone;
  @override
  final String businessNumber;
  @override
  final String bankName;
  @override
  final String bankAccount;

  @override
  String toString() {
    return 'RegisteredStoreDto(storeId: $storeId, storeName: $storeName, imageUrl: $imageUrl, goodsImages: $goodsImages, goodsName: $goodsName, startTime: $startTime, endTime: $endTime, originPrice: $originPrice, discount: $discount, salePrice: $salePrice, quantity: $quantity, distance: $distance, saleStatus: $saleStatus, longitude: $longitude, latitude: $latitude, address: $address, ownerName: $ownerName, ownerPhone: $ownerPhone, businessNumber: $businessNumber, bankName: $bankName, bankAccount: $bankAccount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisteredStoreDtoImpl &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.storeName, storeName) ||
                other.storeName == storeName) &&
            const DeepCollectionEquality().equals(other._imageUrl, _imageUrl) &&
            const DeepCollectionEquality().equals(
              other._goodsImages,
              _goodsImages,
            ) &&
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
            (identical(other.address, address) || other.address == address) &&
            (identical(other.ownerName, ownerName) ||
                other.ownerName == ownerName) &&
            (identical(other.ownerPhone, ownerPhone) ||
                other.ownerPhone == ownerPhone) &&
            (identical(other.businessNumber, businessNumber) ||
                other.businessNumber == businessNumber) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.bankAccount, bankAccount) ||
                other.bankAccount == bankAccount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    storeId,
    storeName,
    const DeepCollectionEquality().hash(_imageUrl),
    const DeepCollectionEquality().hash(_goodsImages),
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
    ownerName,
    ownerPhone,
    businessNumber,
    bankName,
    bankAccount,
  ]);

  /// Create a copy of RegisteredStoreDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisteredStoreDtoImplCopyWith<_$RegisteredStoreDtoImpl> get copyWith =>
      __$$RegisteredStoreDtoImplCopyWithImpl<_$RegisteredStoreDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisteredStoreDtoImplToJson(this);
  }
}

abstract class _RegisteredStoreDto implements RegisteredStoreDto {
  const factory _RegisteredStoreDto({
    required final String storeId,
    required final String storeName,
    @JsonKey(name: 'ImageUrl') final List<String> imageUrl,
    @JsonKey(name: 'GoodImageUrl') final List<String> goodsImages,
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
    required final String ownerName,
    required final String ownerPhone,
    required final String businessNumber,
    required final String bankName,
    required final String bankAccount,
  }) = _$RegisteredStoreDtoImpl;

  factory _RegisteredStoreDto.fromJson(Map<String, dynamic> json) =
      _$RegisteredStoreDtoImpl.fromJson;

  @override
  String get storeId;
  @override
  String get storeName;
  @override
  @JsonKey(name: 'ImageUrl')
  List<String> get imageUrl;
  @override
  @JsonKey(name: 'GoodImageUrl')
  List<String> get goodsImages;
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
  @override
  String get ownerName;
  @override
  String get ownerPhone;
  @override
  String get businessNumber;
  @override
  String get bankName;
  @override
  String get bankAccount;

  /// Create a copy of RegisteredStoreDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisteredStoreDtoImplCopyWith<_$RegisteredStoreDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
