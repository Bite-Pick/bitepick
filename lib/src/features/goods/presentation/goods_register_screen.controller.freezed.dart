// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goods_register_screen.controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GoodsRegisterState {
  int get currentStep => throw _privateConstructorUsedError;
  FormGroup get form => throw _privateConstructorUsedError;

  /// Create a copy of GoodsRegisterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoodsRegisterStateCopyWith<GoodsRegisterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoodsRegisterStateCopyWith<$Res> {
  factory $GoodsRegisterStateCopyWith(
    GoodsRegisterState value,
    $Res Function(GoodsRegisterState) then,
  ) = _$GoodsRegisterStateCopyWithImpl<$Res, GoodsRegisterState>;
  @useResult
  $Res call({int currentStep, FormGroup form});
}

/// @nodoc
class _$GoodsRegisterStateCopyWithImpl<$Res, $Val extends GoodsRegisterState>
    implements $GoodsRegisterStateCopyWith<$Res> {
  _$GoodsRegisterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GoodsRegisterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? currentStep = null, Object? form = null}) {
    return _then(
      _value.copyWith(
            currentStep: null == currentStep
                ? _value.currentStep
                : currentStep // ignore: cast_nullable_to_non_nullable
                      as int,
            form: null == form
                ? _value.form
                : form // ignore: cast_nullable_to_non_nullable
                      as FormGroup,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GoodsRegisterStateImplCopyWith<$Res>
    implements $GoodsRegisterStateCopyWith<$Res> {
  factory _$$GoodsRegisterStateImplCopyWith(
    _$GoodsRegisterStateImpl value,
    $Res Function(_$GoodsRegisterStateImpl) then,
  ) = __$$GoodsRegisterStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int currentStep, FormGroup form});
}

/// @nodoc
class __$$GoodsRegisterStateImplCopyWithImpl<$Res>
    extends _$GoodsRegisterStateCopyWithImpl<$Res, _$GoodsRegisterStateImpl>
    implements _$$GoodsRegisterStateImplCopyWith<$Res> {
  __$$GoodsRegisterStateImplCopyWithImpl(
    _$GoodsRegisterStateImpl _value,
    $Res Function(_$GoodsRegisterStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GoodsRegisterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? currentStep = null, Object? form = null}) {
    return _then(
      _$GoodsRegisterStateImpl(
        currentStep: null == currentStep
            ? _value.currentStep
            : currentStep // ignore: cast_nullable_to_non_nullable
                  as int,
        form: null == form
            ? _value.form
            : form // ignore: cast_nullable_to_non_nullable
                  as FormGroup,
      ),
    );
  }
}

/// @nodoc

class _$GoodsRegisterStateImpl implements _GoodsRegisterState {
  const _$GoodsRegisterStateImpl({
    required this.currentStep,
    required this.form,
  });

  @override
  final int currentStep;
  @override
  final FormGroup form;

  @override
  String toString() {
    return 'GoodsRegisterState(currentStep: $currentStep, form: $form)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoodsRegisterStateImpl &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.form, form) || other.form == form));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentStep, form);

  /// Create a copy of GoodsRegisterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoodsRegisterStateImplCopyWith<_$GoodsRegisterStateImpl> get copyWith =>
      __$$GoodsRegisterStateImplCopyWithImpl<_$GoodsRegisterStateImpl>(
        this,
        _$identity,
      );
}

abstract class _GoodsRegisterState implements GoodsRegisterState {
  const factory _GoodsRegisterState({
    required final int currentStep,
    required final FormGroup form,
  }) = _$GoodsRegisterStateImpl;

  @override
  int get currentStep;
  @override
  FormGroup get form;

  /// Create a copy of GoodsRegisterState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoodsRegisterStateImplCopyWith<_$GoodsRegisterStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
