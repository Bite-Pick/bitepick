// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goods_edit_screen.controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GoodsEditState {
  FormGroup get form => throw _privateConstructorUsedError;
  List<GoodsDetailItem> get goodsDetails => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  double get uploadProgress => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of GoodsEditState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoodsEditStateCopyWith<GoodsEditState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoodsEditStateCopyWith<$Res> {
  factory $GoodsEditStateCopyWith(
    GoodsEditState value,
    $Res Function(GoodsEditState) then,
  ) = _$GoodsEditStateCopyWithImpl<$Res, GoodsEditState>;
  @useResult
  $Res call({
    FormGroup form,
    List<GoodsDetailItem> goodsDetails,
    bool isSubmitting,
    double uploadProgress,
    String? error,
  });
}

/// @nodoc
class _$GoodsEditStateCopyWithImpl<$Res, $Val extends GoodsEditState>
    implements $GoodsEditStateCopyWith<$Res> {
  _$GoodsEditStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GoodsEditState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? form = null,
    Object? goodsDetails = null,
    Object? isSubmitting = null,
    Object? uploadProgress = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            form: null == form
                ? _value.form
                : form // ignore: cast_nullable_to_non_nullable
                      as FormGroup,
            goodsDetails: null == goodsDetails
                ? _value.goodsDetails
                : goodsDetails // ignore: cast_nullable_to_non_nullable
                      as List<GoodsDetailItem>,
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
abstract class _$$GoodsEditStateImplCopyWith<$Res>
    implements $GoodsEditStateCopyWith<$Res> {
  factory _$$GoodsEditStateImplCopyWith(
    _$GoodsEditStateImpl value,
    $Res Function(_$GoodsEditStateImpl) then,
  ) = __$$GoodsEditStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    FormGroup form,
    List<GoodsDetailItem> goodsDetails,
    bool isSubmitting,
    double uploadProgress,
    String? error,
  });
}

/// @nodoc
class __$$GoodsEditStateImplCopyWithImpl<$Res>
    extends _$GoodsEditStateCopyWithImpl<$Res, _$GoodsEditStateImpl>
    implements _$$GoodsEditStateImplCopyWith<$Res> {
  __$$GoodsEditStateImplCopyWithImpl(
    _$GoodsEditStateImpl _value,
    $Res Function(_$GoodsEditStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GoodsEditState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? form = null,
    Object? goodsDetails = null,
    Object? isSubmitting = null,
    Object? uploadProgress = null,
    Object? error = freezed,
  }) {
    return _then(
      _$GoodsEditStateImpl(
        form: null == form
            ? _value.form
            : form // ignore: cast_nullable_to_non_nullable
                  as FormGroup,
        goodsDetails: null == goodsDetails
            ? _value._goodsDetails
            : goodsDetails // ignore: cast_nullable_to_non_nullable
                  as List<GoodsDetailItem>,
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

class _$GoodsEditStateImpl implements _GoodsEditState {
  const _$GoodsEditStateImpl({
    required this.form,
    final List<GoodsDetailItem> goodsDetails = const [],
    this.isSubmitting = false,
    this.uploadProgress = 0.0,
    this.error,
  }) : _goodsDetails = goodsDetails;

  @override
  final FormGroup form;
  final List<GoodsDetailItem> _goodsDetails;
  @override
  @JsonKey()
  List<GoodsDetailItem> get goodsDetails {
    if (_goodsDetails is EqualUnmodifiableListView) return _goodsDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_goodsDetails);
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
    return 'GoodsEditState(form: $form, goodsDetails: $goodsDetails, isSubmitting: $isSubmitting, uploadProgress: $uploadProgress, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoodsEditStateImpl &&
            (identical(other.form, form) || other.form == form) &&
            const DeepCollectionEquality().equals(
              other._goodsDetails,
              _goodsDetails,
            ) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.uploadProgress, uploadProgress) ||
                other.uploadProgress == uploadProgress) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    form,
    const DeepCollectionEquality().hash(_goodsDetails),
    isSubmitting,
    uploadProgress,
    error,
  );

  /// Create a copy of GoodsEditState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoodsEditStateImplCopyWith<_$GoodsEditStateImpl> get copyWith =>
      __$$GoodsEditStateImplCopyWithImpl<_$GoodsEditStateImpl>(
        this,
        _$identity,
      );
}

abstract class _GoodsEditState implements GoodsEditState {
  const factory _GoodsEditState({
    required final FormGroup form,
    final List<GoodsDetailItem> goodsDetails,
    final bool isSubmitting,
    final double uploadProgress,
    final String? error,
  }) = _$GoodsEditStateImpl;

  @override
  FormGroup get form;
  @override
  List<GoodsDetailItem> get goodsDetails;
  @override
  bool get isSubmitting;
  @override
  double get uploadProgress;
  @override
  String? get error;

  /// Create a copy of GoodsEditState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoodsEditStateImplCopyWith<_$GoodsEditStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
