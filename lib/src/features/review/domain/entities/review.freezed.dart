// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return _Review.fromJson(json);
}

/// @nodoc
mixin _$Review {
  String get reviewId => throw _privateConstructorUsedError;
  int get rating => throw _privateConstructorUsedError;
  List<String> get satisfactionReasons => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<String> get imageUrls => throw _privateConstructorUsedError;
  String get nickName => throw _privateConstructorUsedError;
  String get goodsId => throw _privateConstructorUsedError;
  String get storeId => throw _privateConstructorUsedError;
  String get storeName => throw _privateConstructorUsedError;

  /// Serializes this Review to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewCopyWith<Review> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewCopyWith<$Res> {
  factory $ReviewCopyWith(Review value, $Res Function(Review) then) =
      _$ReviewCopyWithImpl<$Res, Review>;
  @useResult
  $Res call({
    String reviewId,
    int rating,
    List<String> satisfactionReasons,
    String description,
    DateTime createdAt,
    List<String> imageUrls,
    String nickName,
    String goodsId,
    String storeId,
    String storeName,
  });
}

/// @nodoc
class _$ReviewCopyWithImpl<$Res, $Val extends Review>
    implements $ReviewCopyWith<$Res> {
  _$ReviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reviewId = null,
    Object? rating = null,
    Object? satisfactionReasons = null,
    Object? description = null,
    Object? createdAt = null,
    Object? imageUrls = null,
    Object? nickName = null,
    Object? goodsId = null,
    Object? storeId = null,
    Object? storeName = null,
  }) {
    return _then(
      _value.copyWith(
            reviewId: null == reviewId
                ? _value.reviewId
                : reviewId // ignore: cast_nullable_to_non_nullable
                      as String,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as int,
            satisfactionReasons: null == satisfactionReasons
                ? _value.satisfactionReasons
                : satisfactionReasons // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            imageUrls: null == imageUrls
                ? _value.imageUrls
                : imageUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            nickName: null == nickName
                ? _value.nickName
                : nickName // ignore: cast_nullable_to_non_nullable
                      as String,
            goodsId: null == goodsId
                ? _value.goodsId
                : goodsId // ignore: cast_nullable_to_non_nullable
                      as String,
            storeId: null == storeId
                ? _value.storeId
                : storeId // ignore: cast_nullable_to_non_nullable
                      as String,
            storeName: null == storeName
                ? _value.storeName
                : storeName // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReviewImplCopyWith<$Res> implements $ReviewCopyWith<$Res> {
  factory _$$ReviewImplCopyWith(
    _$ReviewImpl value,
    $Res Function(_$ReviewImpl) then,
  ) = __$$ReviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String reviewId,
    int rating,
    List<String> satisfactionReasons,
    String description,
    DateTime createdAt,
    List<String> imageUrls,
    String nickName,
    String goodsId,
    String storeId,
    String storeName,
  });
}

/// @nodoc
class __$$ReviewImplCopyWithImpl<$Res>
    extends _$ReviewCopyWithImpl<$Res, _$ReviewImpl>
    implements _$$ReviewImplCopyWith<$Res> {
  __$$ReviewImplCopyWithImpl(
    _$ReviewImpl _value,
    $Res Function(_$ReviewImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reviewId = null,
    Object? rating = null,
    Object? satisfactionReasons = null,
    Object? description = null,
    Object? createdAt = null,
    Object? imageUrls = null,
    Object? nickName = null,
    Object? goodsId = null,
    Object? storeId = null,
    Object? storeName = null,
  }) {
    return _then(
      _$ReviewImpl(
        reviewId: null == reviewId
            ? _value.reviewId
            : reviewId // ignore: cast_nullable_to_non_nullable
                  as String,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as int,
        satisfactionReasons: null == satisfactionReasons
            ? _value._satisfactionReasons
            : satisfactionReasons // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        imageUrls: null == imageUrls
            ? _value._imageUrls
            : imageUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        nickName: null == nickName
            ? _value.nickName
            : nickName // ignore: cast_nullable_to_non_nullable
                  as String,
        goodsId: null == goodsId
            ? _value.goodsId
            : goodsId // ignore: cast_nullable_to_non_nullable
                  as String,
        storeId: null == storeId
            ? _value.storeId
            : storeId // ignore: cast_nullable_to_non_nullable
                  as String,
        storeName: null == storeName
            ? _value.storeName
            : storeName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewImpl extends _Review {
  const _$ReviewImpl({
    required this.reviewId,
    required this.rating,
    required final List<String> satisfactionReasons,
    required this.description,
    required this.createdAt,
    required final List<String> imageUrls,
    required this.nickName,
    required this.goodsId,
    required this.storeId,
    required this.storeName,
  }) : _satisfactionReasons = satisfactionReasons,
       _imageUrls = imageUrls,
       super._();

  factory _$ReviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewImplFromJson(json);

  @override
  final String reviewId;
  @override
  final int rating;
  final List<String> _satisfactionReasons;
  @override
  List<String> get satisfactionReasons {
    if (_satisfactionReasons is EqualUnmodifiableListView)
      return _satisfactionReasons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_satisfactionReasons);
  }

  @override
  final String description;
  @override
  final DateTime createdAt;
  final List<String> _imageUrls;
  @override
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  @override
  final String nickName;
  @override
  final String goodsId;
  @override
  final String storeId;
  @override
  final String storeName;

  @override
  String toString() {
    return 'Review(reviewId: $reviewId, rating: $rating, satisfactionReasons: $satisfactionReasons, description: $description, createdAt: $createdAt, imageUrls: $imageUrls, nickName: $nickName, goodsId: $goodsId, storeId: $storeId, storeName: $storeName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewImpl &&
            (identical(other.reviewId, reviewId) ||
                other.reviewId == reviewId) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            const DeepCollectionEquality().equals(
              other._satisfactionReasons,
              _satisfactionReasons,
            ) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(
              other._imageUrls,
              _imageUrls,
            ) &&
            (identical(other.nickName, nickName) ||
                other.nickName == nickName) &&
            (identical(other.goodsId, goodsId) || other.goodsId == goodsId) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.storeName, storeName) ||
                other.storeName == storeName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    reviewId,
    rating,
    const DeepCollectionEquality().hash(_satisfactionReasons),
    description,
    createdAt,
    const DeepCollectionEquality().hash(_imageUrls),
    nickName,
    goodsId,
    storeId,
    storeName,
  );

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewImplCopyWith<_$ReviewImpl> get copyWith =>
      __$$ReviewImplCopyWithImpl<_$ReviewImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewImplToJson(this);
  }
}

abstract class _Review extends Review {
  const factory _Review({
    required final String reviewId,
    required final int rating,
    required final List<String> satisfactionReasons,
    required final String description,
    required final DateTime createdAt,
    required final List<String> imageUrls,
    required final String nickName,
    required final String goodsId,
    required final String storeId,
    required final String storeName,
  }) = _$ReviewImpl;
  const _Review._() : super._();

  factory _Review.fromJson(Map<String, dynamic> json) = _$ReviewImpl.fromJson;

  @override
  String get reviewId;
  @override
  int get rating;
  @override
  List<String> get satisfactionReasons;
  @override
  String get description;
  @override
  DateTime get createdAt;
  @override
  List<String> get imageUrls;
  @override
  String get nickName;
  @override
  String get goodsId;
  @override
  String get storeId;
  @override
  String get storeName;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewImplCopyWith<_$ReviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
