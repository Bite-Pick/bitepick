// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StoreReviewSummary _$StoreReviewSummaryFromJson(Map<String, dynamic> json) {
  return _StoreReviewSummary.fromJson(json);
}

/// @nodoc
mixin _$StoreReviewSummary {
  @JsonKey(defaultValue: 0.0)
  double get averageRating => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: 0)
  int get totalCount => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: 0)
  int get noReplyCount => throw _privateConstructorUsedError;

  /// Serializes this StoreReviewSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoreReviewSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoreReviewSummaryCopyWith<StoreReviewSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreReviewSummaryCopyWith<$Res> {
  factory $StoreReviewSummaryCopyWith(
    StoreReviewSummary value,
    $Res Function(StoreReviewSummary) then,
  ) = _$StoreReviewSummaryCopyWithImpl<$Res, StoreReviewSummary>;
  @useResult
  $Res call({
    @JsonKey(defaultValue: 0.0) double averageRating,
    @JsonKey(defaultValue: 0) int totalCount,
    @JsonKey(defaultValue: 0) int noReplyCount,
  });
}

/// @nodoc
class _$StoreReviewSummaryCopyWithImpl<$Res, $Val extends StoreReviewSummary>
    implements $StoreReviewSummaryCopyWith<$Res> {
  _$StoreReviewSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoreReviewSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? averageRating = null,
    Object? totalCount = null,
    Object? noReplyCount = null,
  }) {
    return _then(
      _value.copyWith(
            averageRating: null == averageRating
                ? _value.averageRating
                : averageRating // ignore: cast_nullable_to_non_nullable
                      as double,
            totalCount: null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int,
            noReplyCount: null == noReplyCount
                ? _value.noReplyCount
                : noReplyCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StoreReviewSummaryImplCopyWith<$Res>
    implements $StoreReviewSummaryCopyWith<$Res> {
  factory _$$StoreReviewSummaryImplCopyWith(
    _$StoreReviewSummaryImpl value,
    $Res Function(_$StoreReviewSummaryImpl) then,
  ) = __$$StoreReviewSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(defaultValue: 0.0) double averageRating,
    @JsonKey(defaultValue: 0) int totalCount,
    @JsonKey(defaultValue: 0) int noReplyCount,
  });
}

/// @nodoc
class __$$StoreReviewSummaryImplCopyWithImpl<$Res>
    extends _$StoreReviewSummaryCopyWithImpl<$Res, _$StoreReviewSummaryImpl>
    implements _$$StoreReviewSummaryImplCopyWith<$Res> {
  __$$StoreReviewSummaryImplCopyWithImpl(
    _$StoreReviewSummaryImpl _value,
    $Res Function(_$StoreReviewSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoreReviewSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? averageRating = null,
    Object? totalCount = null,
    Object? noReplyCount = null,
  }) {
    return _then(
      _$StoreReviewSummaryImpl(
        averageRating: null == averageRating
            ? _value.averageRating
            : averageRating // ignore: cast_nullable_to_non_nullable
                  as double,
        totalCount: null == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        noReplyCount: null == noReplyCount
            ? _value.noReplyCount
            : noReplyCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoreReviewSummaryImpl implements _StoreReviewSummary {
  const _$StoreReviewSummaryImpl({
    @JsonKey(defaultValue: 0.0) required this.averageRating,
    @JsonKey(defaultValue: 0) required this.totalCount,
    @JsonKey(defaultValue: 0) required this.noReplyCount,
  });

  factory _$StoreReviewSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoreReviewSummaryImplFromJson(json);

  @override
  @JsonKey(defaultValue: 0.0)
  final double averageRating;
  @override
  @JsonKey(defaultValue: 0)
  final int totalCount;
  @override
  @JsonKey(defaultValue: 0)
  final int noReplyCount;

  @override
  String toString() {
    return 'StoreReviewSummary(averageRating: $averageRating, totalCount: $totalCount, noReplyCount: $noReplyCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreReviewSummaryImpl &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.noReplyCount, noReplyCount) ||
                other.noReplyCount == noReplyCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, averageRating, totalCount, noReplyCount);

  /// Create a copy of StoreReviewSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreReviewSummaryImplCopyWith<_$StoreReviewSummaryImpl> get copyWith =>
      __$$StoreReviewSummaryImplCopyWithImpl<_$StoreReviewSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StoreReviewSummaryImplToJson(this);
  }
}

abstract class _StoreReviewSummary implements StoreReviewSummary {
  const factory _StoreReviewSummary({
    @JsonKey(defaultValue: 0.0) required final double averageRating,
    @JsonKey(defaultValue: 0) required final int totalCount,
    @JsonKey(defaultValue: 0) required final int noReplyCount,
  }) = _$StoreReviewSummaryImpl;

  factory _StoreReviewSummary.fromJson(Map<String, dynamic> json) =
      _$StoreReviewSummaryImpl.fromJson;

  @override
  @JsonKey(defaultValue: 0.0)
  double get averageRating;
  @override
  @JsonKey(defaultValue: 0)
  int get totalCount;
  @override
  @JsonKey(defaultValue: 0)
  int get noReplyCount;

  /// Create a copy of StoreReviewSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoreReviewSummaryImplCopyWith<_$StoreReviewSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StoreReviewReply _$StoreReviewReplyFromJson(Map<String, dynamic> json) {
  return _StoreReviewReply.fromJson(json);
}

/// @nodoc
mixin _$StoreReviewReply {
  String get replyId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this StoreReviewReply to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoreReviewReply
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoreReviewReplyCopyWith<StoreReviewReply> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreReviewReplyCopyWith<$Res> {
  factory $StoreReviewReplyCopyWith(
    StoreReviewReply value,
    $Res Function(StoreReviewReply) then,
  ) = _$StoreReviewReplyCopyWithImpl<$Res, StoreReviewReply>;
  @useResult
  $Res call({String replyId, String content, DateTime createdAt});
}

/// @nodoc
class _$StoreReviewReplyCopyWithImpl<$Res, $Val extends StoreReviewReply>
    implements $StoreReviewReplyCopyWith<$Res> {
  _$StoreReviewReplyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoreReviewReply
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? replyId = null,
    Object? content = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            replyId: null == replyId
                ? _value.replyId
                : replyId // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StoreReviewReplyImplCopyWith<$Res>
    implements $StoreReviewReplyCopyWith<$Res> {
  factory _$$StoreReviewReplyImplCopyWith(
    _$StoreReviewReplyImpl value,
    $Res Function(_$StoreReviewReplyImpl) then,
  ) = __$$StoreReviewReplyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String replyId, String content, DateTime createdAt});
}

/// @nodoc
class __$$StoreReviewReplyImplCopyWithImpl<$Res>
    extends _$StoreReviewReplyCopyWithImpl<$Res, _$StoreReviewReplyImpl>
    implements _$$StoreReviewReplyImplCopyWith<$Res> {
  __$$StoreReviewReplyImplCopyWithImpl(
    _$StoreReviewReplyImpl _value,
    $Res Function(_$StoreReviewReplyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoreReviewReply
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? replyId = null,
    Object? content = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$StoreReviewReplyImpl(
        replyId: null == replyId
            ? _value.replyId
            : replyId // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoreReviewReplyImpl implements _StoreReviewReply {
  const _$StoreReviewReplyImpl({
    required this.replyId,
    required this.content,
    required this.createdAt,
  });

  factory _$StoreReviewReplyImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoreReviewReplyImplFromJson(json);

  @override
  final String replyId;
  @override
  final String content;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'StoreReviewReply(replyId: $replyId, content: $content, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreReviewReplyImpl &&
            (identical(other.replyId, replyId) || other.replyId == replyId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, replyId, content, createdAt);

  /// Create a copy of StoreReviewReply
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreReviewReplyImplCopyWith<_$StoreReviewReplyImpl> get copyWith =>
      __$$StoreReviewReplyImplCopyWithImpl<_$StoreReviewReplyImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StoreReviewReplyImplToJson(this);
  }
}

abstract class _StoreReviewReply implements StoreReviewReply {
  const factory _StoreReviewReply({
    required final String replyId,
    required final String content,
    required final DateTime createdAt,
  }) = _$StoreReviewReplyImpl;

  factory _StoreReviewReply.fromJson(Map<String, dynamic> json) =
      _$StoreReviewReplyImpl.fromJson;

  @override
  String get replyId;
  @override
  String get content;
  @override
  DateTime get createdAt;

  /// Create a copy of StoreReviewReply
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoreReviewReplyImplCopyWith<_$StoreReviewReplyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StoreReviewItem _$StoreReviewItemFromJson(Map<String, dynamic> json) {
  return _StoreReviewItem.fromJson(json);
}

/// @nodoc
mixin _$StoreReviewItem {
  String get reviewId => throw _privateConstructorUsedError;
  int get rating => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get imageUrls => throw _privateConstructorUsedError;
  String get nickName => throw _privateConstructorUsedError;
  DateTime get orderedAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  StoreReviewReply? get reply => throw _privateConstructorUsedError;

  /// Serializes this StoreReviewItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoreReviewItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoreReviewItemCopyWith<StoreReviewItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreReviewItemCopyWith<$Res> {
  factory $StoreReviewItemCopyWith(
    StoreReviewItem value,
    $Res Function(StoreReviewItem) then,
  ) = _$StoreReviewItemCopyWithImpl<$Res, StoreReviewItem>;
  @useResult
  $Res call({
    String reviewId,
    int rating,
    String description,
    List<String> imageUrls,
    String nickName,
    DateTime orderedAt,
    DateTime createdAt,
    String productName,
    StoreReviewReply? reply,
  });

  $StoreReviewReplyCopyWith<$Res>? get reply;
}

/// @nodoc
class _$StoreReviewItemCopyWithImpl<$Res, $Val extends StoreReviewItem>
    implements $StoreReviewItemCopyWith<$Res> {
  _$StoreReviewItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoreReviewItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reviewId = null,
    Object? rating = null,
    Object? description = null,
    Object? imageUrls = null,
    Object? nickName = null,
    Object? orderedAt = null,
    Object? createdAt = null,
    Object? productName = null,
    Object? reply = freezed,
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
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrls: null == imageUrls
                ? _value.imageUrls
                : imageUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            nickName: null == nickName
                ? _value.nickName
                : nickName // ignore: cast_nullable_to_non_nullable
                      as String,
            orderedAt: null == orderedAt
                ? _value.orderedAt
                : orderedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            productName: null == productName
                ? _value.productName
                : productName // ignore: cast_nullable_to_non_nullable
                      as String,
            reply: freezed == reply
                ? _value.reply
                : reply // ignore: cast_nullable_to_non_nullable
                      as StoreReviewReply?,
          )
          as $Val,
    );
  }

  /// Create a copy of StoreReviewItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StoreReviewReplyCopyWith<$Res>? get reply {
    if (_value.reply == null) {
      return null;
    }

    return $StoreReviewReplyCopyWith<$Res>(_value.reply!, (value) {
      return _then(_value.copyWith(reply: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StoreReviewItemImplCopyWith<$Res>
    implements $StoreReviewItemCopyWith<$Res> {
  factory _$$StoreReviewItemImplCopyWith(
    _$StoreReviewItemImpl value,
    $Res Function(_$StoreReviewItemImpl) then,
  ) = __$$StoreReviewItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String reviewId,
    int rating,
    String description,
    List<String> imageUrls,
    String nickName,
    DateTime orderedAt,
    DateTime createdAt,
    String productName,
    StoreReviewReply? reply,
  });

  @override
  $StoreReviewReplyCopyWith<$Res>? get reply;
}

/// @nodoc
class __$$StoreReviewItemImplCopyWithImpl<$Res>
    extends _$StoreReviewItemCopyWithImpl<$Res, _$StoreReviewItemImpl>
    implements _$$StoreReviewItemImplCopyWith<$Res> {
  __$$StoreReviewItemImplCopyWithImpl(
    _$StoreReviewItemImpl _value,
    $Res Function(_$StoreReviewItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoreReviewItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reviewId = null,
    Object? rating = null,
    Object? description = null,
    Object? imageUrls = null,
    Object? nickName = null,
    Object? orderedAt = null,
    Object? createdAt = null,
    Object? productName = null,
    Object? reply = freezed,
  }) {
    return _then(
      _$StoreReviewItemImpl(
        reviewId: null == reviewId
            ? _value.reviewId
            : reviewId // ignore: cast_nullable_to_non_nullable
                  as String,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as int,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrls: null == imageUrls
            ? _value._imageUrls
            : imageUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        nickName: null == nickName
            ? _value.nickName
            : nickName // ignore: cast_nullable_to_non_nullable
                  as String,
        orderedAt: null == orderedAt
            ? _value.orderedAt
            : orderedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        productName: null == productName
            ? _value.productName
            : productName // ignore: cast_nullable_to_non_nullable
                  as String,
        reply: freezed == reply
            ? _value.reply
            : reply // ignore: cast_nullable_to_non_nullable
                  as StoreReviewReply?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoreReviewItemImpl implements _StoreReviewItem {
  const _$StoreReviewItemImpl({
    required this.reviewId,
    required this.rating,
    required this.description,
    required final List<String> imageUrls,
    required this.nickName,
    required this.orderedAt,
    required this.createdAt,
    required this.productName,
    this.reply,
  }) : _imageUrls = imageUrls;

  factory _$StoreReviewItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoreReviewItemImplFromJson(json);

  @override
  final String reviewId;
  @override
  final int rating;
  @override
  final String description;
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
  final DateTime orderedAt;
  @override
  final DateTime createdAt;
  @override
  final String productName;
  @override
  final StoreReviewReply? reply;

  @override
  String toString() {
    return 'StoreReviewItem(reviewId: $reviewId, rating: $rating, description: $description, imageUrls: $imageUrls, nickName: $nickName, orderedAt: $orderedAt, createdAt: $createdAt, productName: $productName, reply: $reply)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreReviewItemImpl &&
            (identical(other.reviewId, reviewId) ||
                other.reviewId == reviewId) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._imageUrls,
              _imageUrls,
            ) &&
            (identical(other.nickName, nickName) ||
                other.nickName == nickName) &&
            (identical(other.orderedAt, orderedAt) ||
                other.orderedAt == orderedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.reply, reply) || other.reply == reply));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    reviewId,
    rating,
    description,
    const DeepCollectionEquality().hash(_imageUrls),
    nickName,
    orderedAt,
    createdAt,
    productName,
    reply,
  );

  /// Create a copy of StoreReviewItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreReviewItemImplCopyWith<_$StoreReviewItemImpl> get copyWith =>
      __$$StoreReviewItemImplCopyWithImpl<_$StoreReviewItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StoreReviewItemImplToJson(this);
  }
}

abstract class _StoreReviewItem implements StoreReviewItem {
  const factory _StoreReviewItem({
    required final String reviewId,
    required final int rating,
    required final String description,
    required final List<String> imageUrls,
    required final String nickName,
    required final DateTime orderedAt,
    required final DateTime createdAt,
    required final String productName,
    final StoreReviewReply? reply,
  }) = _$StoreReviewItemImpl;

  factory _StoreReviewItem.fromJson(Map<String, dynamic> json) =
      _$StoreReviewItemImpl.fromJson;

  @override
  String get reviewId;
  @override
  int get rating;
  @override
  String get description;
  @override
  List<String> get imageUrls;
  @override
  String get nickName;
  @override
  DateTime get orderedAt;
  @override
  DateTime get createdAt;
  @override
  String get productName;
  @override
  StoreReviewReply? get reply;

  /// Create a copy of StoreReviewItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoreReviewItemImplCopyWith<_$StoreReviewItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StoreReviewListResponse _$StoreReviewListResponseFromJson(
  Map<String, dynamic> json,
) {
  return _StoreReviewListResponse.fromJson(json);
}

/// @nodoc
mixin _$StoreReviewListResponse {
  StoreReviewSummary get summary => throw _privateConstructorUsedError;
  List<StoreReviewItem> get items => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: 0)
  int get nextCursor => throw _privateConstructorUsedError;
  bool get hasNext => throw _privateConstructorUsedError;

  /// Serializes this StoreReviewListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoreReviewListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoreReviewListResponseCopyWith<StoreReviewListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreReviewListResponseCopyWith<$Res> {
  factory $StoreReviewListResponseCopyWith(
    StoreReviewListResponse value,
    $Res Function(StoreReviewListResponse) then,
  ) = _$StoreReviewListResponseCopyWithImpl<$Res, StoreReviewListResponse>;
  @useResult
  $Res call({
    StoreReviewSummary summary,
    List<StoreReviewItem> items,
    @JsonKey(defaultValue: 0) int nextCursor,
    bool hasNext,
  });

  $StoreReviewSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class _$StoreReviewListResponseCopyWithImpl<
  $Res,
  $Val extends StoreReviewListResponse
>
    implements $StoreReviewListResponseCopyWith<$Res> {
  _$StoreReviewListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoreReviewListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? summary = null,
    Object? items = null,
    Object? nextCursor = null,
    Object? hasNext = null,
  }) {
    return _then(
      _value.copyWith(
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as StoreReviewSummary,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<StoreReviewItem>,
            nextCursor: null == nextCursor
                ? _value.nextCursor
                : nextCursor // ignore: cast_nullable_to_non_nullable
                      as int,
            hasNext: null == hasNext
                ? _value.hasNext
                : hasNext // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of StoreReviewListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StoreReviewSummaryCopyWith<$Res> get summary {
    return $StoreReviewSummaryCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StoreReviewListResponseImplCopyWith<$Res>
    implements $StoreReviewListResponseCopyWith<$Res> {
  factory _$$StoreReviewListResponseImplCopyWith(
    _$StoreReviewListResponseImpl value,
    $Res Function(_$StoreReviewListResponseImpl) then,
  ) = __$$StoreReviewListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    StoreReviewSummary summary,
    List<StoreReviewItem> items,
    @JsonKey(defaultValue: 0) int nextCursor,
    bool hasNext,
  });

  @override
  $StoreReviewSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class __$$StoreReviewListResponseImplCopyWithImpl<$Res>
    extends
        _$StoreReviewListResponseCopyWithImpl<
          $Res,
          _$StoreReviewListResponseImpl
        >
    implements _$$StoreReviewListResponseImplCopyWith<$Res> {
  __$$StoreReviewListResponseImplCopyWithImpl(
    _$StoreReviewListResponseImpl _value,
    $Res Function(_$StoreReviewListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoreReviewListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? summary = null,
    Object? items = null,
    Object? nextCursor = null,
    Object? hasNext = null,
  }) {
    return _then(
      _$StoreReviewListResponseImpl(
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as StoreReviewSummary,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<StoreReviewItem>,
        nextCursor: null == nextCursor
            ? _value.nextCursor
            : nextCursor // ignore: cast_nullable_to_non_nullable
                  as int,
        hasNext: null == hasNext
            ? _value.hasNext
            : hasNext // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoreReviewListResponseImpl implements _StoreReviewListResponse {
  const _$StoreReviewListResponseImpl({
    required this.summary,
    required final List<StoreReviewItem> items,
    @JsonKey(defaultValue: 0) required this.nextCursor,
    required this.hasNext,
  }) : _items = items;

  factory _$StoreReviewListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoreReviewListResponseImplFromJson(json);

  @override
  final StoreReviewSummary summary;
  final List<StoreReviewItem> _items;
  @override
  List<StoreReviewItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey(defaultValue: 0)
  final int nextCursor;
  @override
  final bool hasNext;

  @override
  String toString() {
    return 'StoreReviewListResponse(summary: $summary, items: $items, nextCursor: $nextCursor, hasNext: $hasNext)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreReviewListResponseImpl &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.nextCursor, nextCursor) ||
                other.nextCursor == nextCursor) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    summary,
    const DeepCollectionEquality().hash(_items),
    nextCursor,
    hasNext,
  );

  /// Create a copy of StoreReviewListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreReviewListResponseImplCopyWith<_$StoreReviewListResponseImpl>
  get copyWith =>
      __$$StoreReviewListResponseImplCopyWithImpl<
        _$StoreReviewListResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoreReviewListResponseImplToJson(this);
  }
}

abstract class _StoreReviewListResponse implements StoreReviewListResponse {
  const factory _StoreReviewListResponse({
    required final StoreReviewSummary summary,
    required final List<StoreReviewItem> items,
    @JsonKey(defaultValue: 0) required final int nextCursor,
    required final bool hasNext,
  }) = _$StoreReviewListResponseImpl;

  factory _StoreReviewListResponse.fromJson(Map<String, dynamic> json) =
      _$StoreReviewListResponseImpl.fromJson;

  @override
  StoreReviewSummary get summary;
  @override
  List<StoreReviewItem> get items;
  @override
  @JsonKey(defaultValue: 0)
  int get nextCursor;
  @override
  bool get hasNext;

  /// Create a copy of StoreReviewListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoreReviewListResponseImplCopyWith<_$StoreReviewListResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
