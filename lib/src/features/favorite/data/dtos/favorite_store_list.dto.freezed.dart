// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_store_list.dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FavoriteStoreListDTO _$FavoriteStoreListDTOFromJson(Map<String, dynamic> json) {
  return _FavoriteStoreListDTO.fromJson(json);
}

/// @nodoc
mixin _$FavoriteStoreListDTO {
  String get storeId => throw _privateConstructorUsedError;
  String get storeName => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'ImageUrl')
  List<String> get imageUrl => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  int get originPrice => throw _privateConstructorUsedError;
  int get discount => throw _privateConstructorUsedError;
  int get salePrice => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String get saleStatus => throw _privateConstructorUsedError;
  String? get goodsName => throw _privateConstructorUsedError;

  /// Serializes this FavoriteStoreListDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FavoriteStoreListDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FavoriteStoreListDTOCopyWith<FavoriteStoreListDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteStoreListDTOCopyWith<$Res> {
  factory $FavoriteStoreListDTOCopyWith(
    FavoriteStoreListDTO value,
    $Res Function(FavoriteStoreListDTO) then,
  ) = _$FavoriteStoreListDTOCopyWithImpl<$Res, FavoriteStoreListDTO>;
  @useResult
  $Res call({
    String storeId,
    String storeName,
    String address,
    @JsonKey(name: 'ImageUrl') List<String> imageUrl,
    String startTime,
    String endTime,
    int originPrice,
    int discount,
    int salePrice,
    int quantity,
    String saleStatus,
    String? goodsName,
  });
}

/// @nodoc
class _$FavoriteStoreListDTOCopyWithImpl<
  $Res,
  $Val extends FavoriteStoreListDTO
>
    implements $FavoriteStoreListDTOCopyWith<$Res> {
  _$FavoriteStoreListDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoriteStoreListDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? storeName = null,
    Object? address = null,
    Object? imageUrl = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? originPrice = null,
    Object? discount = null,
    Object? salePrice = null,
    Object? quantity = null,
    Object? saleStatus = null,
    Object? goodsName = freezed,
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
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as List<String>,
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
            saleStatus: null == saleStatus
                ? _value.saleStatus
                : saleStatus // ignore: cast_nullable_to_non_nullable
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
abstract class _$$FavoriteStoreListDTOImplCopyWith<$Res>
    implements $FavoriteStoreListDTOCopyWith<$Res> {
  factory _$$FavoriteStoreListDTOImplCopyWith(
    _$FavoriteStoreListDTOImpl value,
    $Res Function(_$FavoriteStoreListDTOImpl) then,
  ) = __$$FavoriteStoreListDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String storeId,
    String storeName,
    String address,
    @JsonKey(name: 'ImageUrl') List<String> imageUrl,
    String startTime,
    String endTime,
    int originPrice,
    int discount,
    int salePrice,
    int quantity,
    String saleStatus,
    String? goodsName,
  });
}

/// @nodoc
class __$$FavoriteStoreListDTOImplCopyWithImpl<$Res>
    extends _$FavoriteStoreListDTOCopyWithImpl<$Res, _$FavoriteStoreListDTOImpl>
    implements _$$FavoriteStoreListDTOImplCopyWith<$Res> {
  __$$FavoriteStoreListDTOImplCopyWithImpl(
    _$FavoriteStoreListDTOImpl _value,
    $Res Function(_$FavoriteStoreListDTOImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FavoriteStoreListDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? storeName = null,
    Object? address = null,
    Object? imageUrl = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? originPrice = null,
    Object? discount = null,
    Object? salePrice = null,
    Object? quantity = null,
    Object? saleStatus = null,
    Object? goodsName = freezed,
  }) {
    return _then(
      _$FavoriteStoreListDTOImpl(
        storeId: null == storeId
            ? _value.storeId
            : storeId // ignore: cast_nullable_to_non_nullable
                  as String,
        storeName: null == storeName
            ? _value.storeName
            : storeName // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value._imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as List<String>,
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
        saleStatus: null == saleStatus
            ? _value.saleStatus
            : saleStatus // ignore: cast_nullable_to_non_nullable
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
class _$FavoriteStoreListDTOImpl extends _FavoriteStoreListDTO {
  const _$FavoriteStoreListDTOImpl({
    required this.storeId,
    required this.storeName,
    required this.address,
    @JsonKey(name: 'ImageUrl') required final List<String> imageUrl,
    required this.startTime,
    required this.endTime,
    required this.originPrice,
    required this.discount,
    required this.salePrice,
    required this.quantity,
    required this.saleStatus,
    this.goodsName,
  }) : _imageUrl = imageUrl,
       super._();

  factory _$FavoriteStoreListDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$FavoriteStoreListDTOImplFromJson(json);

  @override
  final String storeId;
  @override
  final String storeName;
  @override
  final String address;
  final List<String> _imageUrl;
  @override
  @JsonKey(name: 'ImageUrl')
  List<String> get imageUrl {
    if (_imageUrl is EqualUnmodifiableListView) return _imageUrl;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrl);
  }

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
  final String saleStatus;
  @override
  final String? goodsName;

  @override
  String toString() {
    return 'FavoriteStoreListDTO(storeId: $storeId, storeName: $storeName, address: $address, imageUrl: $imageUrl, startTime: $startTime, endTime: $endTime, originPrice: $originPrice, discount: $discount, salePrice: $salePrice, quantity: $quantity, saleStatus: $saleStatus, goodsName: $goodsName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteStoreListDTOImpl &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.storeName, storeName) ||
                other.storeName == storeName) &&
            (identical(other.address, address) || other.address == address) &&
            const DeepCollectionEquality().equals(other._imageUrl, _imageUrl) &&
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
            (identical(other.saleStatus, saleStatus) ||
                other.saleStatus == saleStatus) &&
            (identical(other.goodsName, goodsName) ||
                other.goodsName == goodsName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    storeId,
    storeName,
    address,
    const DeepCollectionEquality().hash(_imageUrl),
    startTime,
    endTime,
    originPrice,
    discount,
    salePrice,
    quantity,
    saleStatus,
    goodsName,
  );

  /// Create a copy of FavoriteStoreListDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteStoreListDTOImplCopyWith<_$FavoriteStoreListDTOImpl>
  get copyWith =>
      __$$FavoriteStoreListDTOImplCopyWithImpl<_$FavoriteStoreListDTOImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FavoriteStoreListDTOImplToJson(this);
  }
}

abstract class _FavoriteStoreListDTO extends FavoriteStoreListDTO {
  const factory _FavoriteStoreListDTO({
    required final String storeId,
    required final String storeName,
    required final String address,
    @JsonKey(name: 'ImageUrl') required final List<String> imageUrl,
    required final String startTime,
    required final String endTime,
    required final int originPrice,
    required final int discount,
    required final int salePrice,
    required final int quantity,
    required final String saleStatus,
    final String? goodsName,
  }) = _$FavoriteStoreListDTOImpl;
  const _FavoriteStoreListDTO._() : super._();

  factory _FavoriteStoreListDTO.fromJson(Map<String, dynamic> json) =
      _$FavoriteStoreListDTOImpl.fromJson;

  @override
  String get storeId;
  @override
  String get storeName;
  @override
  String get address;
  @override
  @JsonKey(name: 'ImageUrl')
  List<String> get imageUrl;
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
  String get saleStatus;
  @override
  String? get goodsName;

  /// Create a copy of FavoriteStoreListDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoriteStoreListDTOImplCopyWith<_$FavoriteStoreListDTOImpl>
  get copyWith => throw _privateConstructorUsedError;
}
