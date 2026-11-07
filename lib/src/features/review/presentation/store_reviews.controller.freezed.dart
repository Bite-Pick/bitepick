// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_reviews.controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$StoreReviewsState {
  List<Review> get reviews => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;

  /// Create a copy of StoreReviewsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoreReviewsStateCopyWith<StoreReviewsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreReviewsStateCopyWith<$Res> {
  factory $StoreReviewsStateCopyWith(
    StoreReviewsState value,
    $Res Function(StoreReviewsState) then,
  ) = _$StoreReviewsStateCopyWithImpl<$Res, StoreReviewsState>;
  @useResult
  $Res call({List<Review> reviews, int page, bool hasMore, bool isLoadingMore});
}

/// @nodoc
class _$StoreReviewsStateCopyWithImpl<$Res, $Val extends StoreReviewsState>
    implements $StoreReviewsStateCopyWith<$Res> {
  _$StoreReviewsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoreReviewsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reviews = null,
    Object? page = null,
    Object? hasMore = null,
    Object? isLoadingMore = null,
  }) {
    return _then(
      _value.copyWith(
            reviews: null == reviews
                ? _value.reviews
                : reviews // ignore: cast_nullable_to_non_nullable
                      as List<Review>,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingMore: null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StoreReviewsStateImplCopyWith<$Res>
    implements $StoreReviewsStateCopyWith<$Res> {
  factory _$$StoreReviewsStateImplCopyWith(
    _$StoreReviewsStateImpl value,
    $Res Function(_$StoreReviewsStateImpl) then,
  ) = __$$StoreReviewsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Review> reviews, int page, bool hasMore, bool isLoadingMore});
}

/// @nodoc
class __$$StoreReviewsStateImplCopyWithImpl<$Res>
    extends _$StoreReviewsStateCopyWithImpl<$Res, _$StoreReviewsStateImpl>
    implements _$$StoreReviewsStateImplCopyWith<$Res> {
  __$$StoreReviewsStateImplCopyWithImpl(
    _$StoreReviewsStateImpl _value,
    $Res Function(_$StoreReviewsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoreReviewsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reviews = null,
    Object? page = null,
    Object? hasMore = null,
    Object? isLoadingMore = null,
  }) {
    return _then(
      _$StoreReviewsStateImpl(
        reviews: null == reviews
            ? _value._reviews
            : reviews // ignore: cast_nullable_to_non_nullable
                  as List<Review>,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$StoreReviewsStateImpl implements _StoreReviewsState {
  const _$StoreReviewsStateImpl({
    required final List<Review> reviews,
    this.page = 1,
    this.hasMore = true,
    this.isLoadingMore = false,
  }) : _reviews = reviews;

  final List<Review> _reviews;
  @override
  List<Review> get reviews {
    if (_reviews is EqualUnmodifiableListView) return _reviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviews);
  }

  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final bool hasMore;
  @override
  @JsonKey()
  final bool isLoadingMore;

  @override
  String toString() {
    return 'StoreReviewsState(reviews: $reviews, page: $page, hasMore: $hasMore, isLoadingMore: $isLoadingMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreReviewsStateImpl &&
            const DeepCollectionEquality().equals(other._reviews, _reviews) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_reviews),
    page,
    hasMore,
    isLoadingMore,
  );

  /// Create a copy of StoreReviewsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreReviewsStateImplCopyWith<_$StoreReviewsStateImpl> get copyWith =>
      __$$StoreReviewsStateImplCopyWithImpl<_$StoreReviewsStateImpl>(
        this,
        _$identity,
      );
}

abstract class _StoreReviewsState implements StoreReviewsState {
  const factory _StoreReviewsState({
    required final List<Review> reviews,
    final int page,
    final bool hasMore,
    final bool isLoadingMore,
  }) = _$StoreReviewsStateImpl;

  @override
  List<Review> get reviews;
  @override
  int get page;
  @override
  bool get hasMore;
  @override
  bool get isLoadingMore;

  /// Create a copy of StoreReviewsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoreReviewsStateImplCopyWith<_$StoreReviewsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
