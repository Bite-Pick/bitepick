// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goods_detail.dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GoodsDetailDto _$GoodsDetailDtoFromJson(Map<String, dynamic> json) {
  return _GoodsDetailDto.fromJson(json);
}

/// @nodoc
mixin _$GoodsDetailDto {
  String get storeId => throw _privateConstructorUsedError;
  String get goodsId => throw _privateConstructorUsedError;
  String get storeName => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  int get originalPrice => throw _privateConstructorUsedError;
  int get salePrice => throw _privateConstructorUsedError;
  int get discount => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String get saleStatus => throw _privateConstructorUsedError;
  int get reviewCount => throw _privateConstructorUsedError;
  double get averageRating => throw _privateConstructorUsedError;

  /// Serializes this GoodsDetailDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GoodsDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoodsDetailDtoCopyWith<GoodsDetailDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoodsDetailDtoCopyWith<$Res> {
  factory $GoodsDetailDtoCopyWith(
    GoodsDetailDto value,
    $Res Function(GoodsDetailDto) then,
  ) = _$GoodsDetailDtoCopyWithImpl<$Res, GoodsDetailDto>;
  @useResult
  $Res call({
    String storeId,
    String goodsId,
    String storeName,
    String address,
    List<String> images,
    DateTime startTime,
    DateTime endTime,
    int originalPrice,
    int salePrice,
    int discount,
    String description,
    int quantity,
    String saleStatus,
    int reviewCount,
    double averageRating,
  });
}

/// @nodoc
class _$GoodsDetailDtoCopyWithImpl<$Res, $Val extends GoodsDetailDto>
    implements $GoodsDetailDtoCopyWith<$Res> {
  _$GoodsDetailDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GoodsDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? goodsId = null,
    Object? storeName = null,
    Object? address = null,
    Object? images = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? originalPrice = null,
    Object? salePrice = null,
    Object? discount = null,
    Object? description = null,
    Object? quantity = null,
    Object? saleStatus = null,
    Object? reviewCount = null,
    Object? averageRating = null,
  }) {
    return _then(
      _value.copyWith(
            storeId: null == storeId
                ? _value.storeId
                : storeId // ignore: cast_nullable_to_non_nullable
                      as String,
            goodsId: null == goodsId
                ? _value.goodsId
                : goodsId // ignore: cast_nullable_to_non_nullable
                      as String,
            storeName: null == storeName
                ? _value.storeName
                : storeName // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            images: null == images
                ? _value.images
                : images // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            originalPrice: null == originalPrice
                ? _value.originalPrice
                : originalPrice // ignore: cast_nullable_to_non_nullable
                      as int,
            salePrice: null == salePrice
                ? _value.salePrice
                : salePrice // ignore: cast_nullable_to_non_nullable
                      as int,
            discount: null == discount
                ? _value.discount
                : discount // ignore: cast_nullable_to_non_nullable
                      as int,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            saleStatus: null == saleStatus
                ? _value.saleStatus
                : saleStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            reviewCount: null == reviewCount
                ? _value.reviewCount
                : reviewCount // ignore: cast_nullable_to_non_nullable
                      as int,
            averageRating: null == averageRating
                ? _value.averageRating
                : averageRating // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GoodsDetailDtoImplCopyWith<$Res>
    implements $GoodsDetailDtoCopyWith<$Res> {
  factory _$$GoodsDetailDtoImplCopyWith(
    _$GoodsDetailDtoImpl value,
    $Res Function(_$GoodsDetailDtoImpl) then,
  ) = __$$GoodsDetailDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String storeId,
    String goodsId,
    String storeName,
    String address,
    List<String> images,
    DateTime startTime,
    DateTime endTime,
    int originalPrice,
    int salePrice,
    int discount,
    String description,
    int quantity,
    String saleStatus,
    int reviewCount,
    double averageRating,
  });
}

/// @nodoc
class __$$GoodsDetailDtoImplCopyWithImpl<$Res>
    extends _$GoodsDetailDtoCopyWithImpl<$Res, _$GoodsDetailDtoImpl>
    implements _$$GoodsDetailDtoImplCopyWith<$Res> {
  __$$GoodsDetailDtoImplCopyWithImpl(
    _$GoodsDetailDtoImpl _value,
    $Res Function(_$GoodsDetailDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GoodsDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? goodsId = null,
    Object? storeName = null,
    Object? address = null,
    Object? images = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? originalPrice = null,
    Object? salePrice = null,
    Object? discount = null,
    Object? description = null,
    Object? quantity = null,
    Object? saleStatus = null,
    Object? reviewCount = null,
    Object? averageRating = null,
  }) {
    return _then(
      _$GoodsDetailDtoImpl(
        storeId: null == storeId
            ? _value.storeId
            : storeId // ignore: cast_nullable_to_non_nullable
                  as String,
        goodsId: null == goodsId
            ? _value.goodsId
            : goodsId // ignore: cast_nullable_to_non_nullable
                  as String,
        storeName: null == storeName
            ? _value.storeName
            : storeName // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        images: null == images
            ? _value._images
            : images // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        originalPrice: null == originalPrice
            ? _value.originalPrice
            : originalPrice // ignore: cast_nullable_to_non_nullable
                  as int,
        salePrice: null == salePrice
            ? _value.salePrice
            : salePrice // ignore: cast_nullable_to_non_nullable
                  as int,
        discount: null == discount
            ? _value.discount
            : discount // ignore: cast_nullable_to_non_nullable
                  as int,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        saleStatus: null == saleStatus
            ? _value.saleStatus
            : saleStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        reviewCount: null == reviewCount
            ? _value.reviewCount
            : reviewCount // ignore: cast_nullable_to_non_nullable
                  as int,
        averageRating: null == averageRating
            ? _value.averageRating
            : averageRating // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GoodsDetailDtoImpl extends _GoodsDetailDto {
  const _$GoodsDetailDtoImpl({
    required this.storeId,
    required this.goodsId,
    required this.storeName,
    required this.address,
    required final List<String> images,
    required this.startTime,
    required this.endTime,
    required this.originalPrice,
    required this.salePrice,
    required this.discount,
    required this.description,
    required this.quantity,
    required this.saleStatus,
    required this.reviewCount,
    required this.averageRating,
  }) : _images = images,
       super._();

  factory _$GoodsDetailDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoodsDetailDtoImplFromJson(json);

  @override
  final String storeId;
  @override
  final String goodsId;
  @override
  final String storeName;
  @override
  final String address;
  final List<String> _images;
  @override
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final int originalPrice;
  @override
  final int salePrice;
  @override
  final int discount;
  @override
  final String description;
  @override
  final int quantity;
  @override
  final String saleStatus;
  @override
  final int reviewCount;
  @override
  final double averageRating;

  @override
  String toString() {
    return 'GoodsDetailDto(storeId: $storeId, goodsId: $goodsId, storeName: $storeName, address: $address, images: $images, startTime: $startTime, endTime: $endTime, originalPrice: $originalPrice, salePrice: $salePrice, discount: $discount, description: $description, quantity: $quantity, saleStatus: $saleStatus, reviewCount: $reviewCount, averageRating: $averageRating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoodsDetailDtoImpl &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.goodsId, goodsId) || other.goodsId == goodsId) &&
            (identical(other.storeName, storeName) ||
                other.storeName == storeName) &&
            (identical(other.address, address) || other.address == address) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.originalPrice, originalPrice) ||
                other.originalPrice == originalPrice) &&
            (identical(other.salePrice, salePrice) ||
                other.salePrice == salePrice) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.saleStatus, saleStatus) ||
                other.saleStatus == saleStatus) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    storeId,
    goodsId,
    storeName,
    address,
    const DeepCollectionEquality().hash(_images),
    startTime,
    endTime,
    originalPrice,
    salePrice,
    discount,
    description,
    quantity,
    saleStatus,
    reviewCount,
    averageRating,
  );

  /// Create a copy of GoodsDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoodsDetailDtoImplCopyWith<_$GoodsDetailDtoImpl> get copyWith =>
      __$$GoodsDetailDtoImplCopyWithImpl<_$GoodsDetailDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GoodsDetailDtoImplToJson(this);
  }
}

abstract class _GoodsDetailDto extends GoodsDetailDto {
  const factory _GoodsDetailDto({
    required final String storeId,
    required final String goodsId,
    required final String storeName,
    required final String address,
    required final List<String> images,
    required final DateTime startTime,
    required final DateTime endTime,
    required final int originalPrice,
    required final int salePrice,
    required final int discount,
    required final String description,
    required final int quantity,
    required final String saleStatus,
    required final int reviewCount,
    required final double averageRating,
  }) = _$GoodsDetailDtoImpl;
  const _GoodsDetailDto._() : super._();

  factory _GoodsDetailDto.fromJson(Map<String, dynamic> json) =
      _$GoodsDetailDtoImpl.fromJson;

  @override
  String get storeId;
  @override
  String get goodsId;
  @override
  String get storeName;
  @override
  String get address;
  @override
  List<String> get images;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  int get originalPrice;
  @override
  int get salePrice;
  @override
  int get discount;
  @override
  String get description;
  @override
  int get quantity;
  @override
  String get saleStatus;
  @override
  int get reviewCount;
  @override
  double get averageRating;

  /// Create a copy of GoodsDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoodsDetailDtoImplCopyWith<_$GoodsDetailDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
