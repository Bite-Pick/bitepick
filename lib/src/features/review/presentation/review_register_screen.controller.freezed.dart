// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_register_screen.controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ReviewRegisterState {
  int get rating => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<LocalImage> get images => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  double get uploadProgress => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of ReviewRegisterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewRegisterStateCopyWith<ReviewRegisterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewRegisterStateCopyWith<$Res> {
  factory $ReviewRegisterStateCopyWith(
    ReviewRegisterState value,
    $Res Function(ReviewRegisterState) then,
  ) = _$ReviewRegisterStateCopyWithImpl<$Res, ReviewRegisterState>;
  @useResult
  $Res call({
    int rating,
    String description,
    List<LocalImage> images,
    bool isSubmitting,
    double uploadProgress,
    String? error,
  });
}

/// @nodoc
class _$ReviewRegisterStateCopyWithImpl<$Res, $Val extends ReviewRegisterState>
    implements $ReviewRegisterStateCopyWith<$Res> {
  _$ReviewRegisterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewRegisterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rating = null,
    Object? description = null,
    Object? images = null,
    Object? isSubmitting = null,
    Object? uploadProgress = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as int,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            images: null == images
                ? _value.images
                : images // ignore: cast_nullable_to_non_nullable
                      as List<LocalImage>,
            isSubmitting: null == isSubmitting
                ? _value.isSubmitting
                : isSubmitting // ignore: cast_nullable_to_non_nullable
                      as bool,
            uploadProgress: null == uploadProgress
                ? _value.uploadProgress
                : uploadProgress // ignore: cast_nullable_to_non_nullable
                      as double,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReviewRegisterStateImplCopyWith<$Res>
    implements $ReviewRegisterStateCopyWith<$Res> {
  factory _$$ReviewRegisterStateImplCopyWith(
    _$ReviewRegisterStateImpl value,
    $Res Function(_$ReviewRegisterStateImpl) then,
  ) = __$$ReviewRegisterStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int rating,
    String description,
    List<LocalImage> images,
    bool isSubmitting,
    double uploadProgress,
    String? error,
  });
}

/// @nodoc
class __$$ReviewRegisterStateImplCopyWithImpl<$Res>
    extends _$ReviewRegisterStateCopyWithImpl<$Res, _$ReviewRegisterStateImpl>
    implements _$$ReviewRegisterStateImplCopyWith<$Res> {
  __$$ReviewRegisterStateImplCopyWithImpl(
    _$ReviewRegisterStateImpl _value,
    $Res Function(_$ReviewRegisterStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReviewRegisterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rating = null,
    Object? description = null,
    Object? images = null,
    Object? isSubmitting = null,
    Object? uploadProgress = null,
    Object? error = freezed,
  }) {
    return _then(
      _$ReviewRegisterStateImpl(
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as int,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        images: null == images
            ? _value._images
            : images // ignore: cast_nullable_to_non_nullable
                  as List<LocalImage>,
        isSubmitting: null == isSubmitting
            ? _value.isSubmitting
            : isSubmitting // ignore: cast_nullable_to_non_nullable
                  as bool,
        uploadProgress: null == uploadProgress
            ? _value.uploadProgress
            : uploadProgress // ignore: cast_nullable_to_non_nullable
                  as double,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ReviewRegisterStateImpl implements _ReviewRegisterState {
  const _$ReviewRegisterStateImpl({
    this.rating = 0,
    this.description = '',
    final List<LocalImage> images = const [],
    this.isSubmitting = false,
    this.uploadProgress = 0.0,
    this.error,
  }) : _images = images;

  @override
  @JsonKey()
  final int rating;
  @override
  @JsonKey()
  final String description;
  final List<LocalImage> _images;
  @override
  @JsonKey()
  List<LocalImage> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  @JsonKey()
  final double uploadProgress;
  @override
  final String? error;

  @override
  String toString() {
    return 'ReviewRegisterState(rating: $rating, description: $description, images: $images, isSubmitting: $isSubmitting, uploadProgress: $uploadProgress, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewRegisterStateImpl &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.uploadProgress, uploadProgress) ||
                other.uploadProgress == uploadProgress) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    rating,
    description,
    const DeepCollectionEquality().hash(_images),
    isSubmitting,
    uploadProgress,
    error,
  );

  /// Create a copy of ReviewRegisterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewRegisterStateImplCopyWith<_$ReviewRegisterStateImpl> get copyWith =>
      __$$ReviewRegisterStateImplCopyWithImpl<_$ReviewRegisterStateImpl>(
        this,
        _$identity,
      );
}

abstract class _ReviewRegisterState implements ReviewRegisterState {
  const factory _ReviewRegisterState({
    final int rating,
    final String description,
    final List<LocalImage> images,
    final bool isSubmitting,
    final double uploadProgress,
    final String? error,
  }) = _$ReviewRegisterStateImpl;

  @override
  int get rating;
  @override
  String get description;
  @override
  List<LocalImage> get images;
  @override
  bool get isSubmitting;
  @override
  double get uploadProgress;
  @override
  String? get error;

  /// Create a copy of ReviewRegisterState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewRegisterStateImplCopyWith<_$ReviewRegisterStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
