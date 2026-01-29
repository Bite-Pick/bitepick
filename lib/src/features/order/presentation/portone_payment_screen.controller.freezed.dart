// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portone_payment_screen.controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PortOnePaymentState {
  String get storeId => throw _privateConstructorUsedError;
  String get paymentId => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of PortOnePaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PortOnePaymentStateCopyWith<PortOnePaymentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PortOnePaymentStateCopyWith<$Res> {
  factory $PortOnePaymentStateCopyWith(
    PortOnePaymentState value,
    $Res Function(PortOnePaymentState) then,
  ) = _$PortOnePaymentStateCopyWithImpl<$Res, PortOnePaymentState>;
  @useResult
  $Res call({
    String storeId,
    String paymentId,
    int amount,
    bool isProcessing,
    String? error,
  });
}

/// @nodoc
class _$PortOnePaymentStateCopyWithImpl<$Res, $Val extends PortOnePaymentState>
    implements $PortOnePaymentStateCopyWith<$Res> {
  _$PortOnePaymentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PortOnePaymentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? paymentId = null,
    Object? amount = null,
    Object? isProcessing = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            storeId: null == storeId
                ? _value.storeId
                : storeId // ignore: cast_nullable_to_non_nullable
                      as String,
            paymentId: null == paymentId
                ? _value.paymentId
                : paymentId // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            isProcessing: null == isProcessing
                ? _value.isProcessing
                : isProcessing // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$PortOnePaymentStateImplCopyWith<$Res>
    implements $PortOnePaymentStateCopyWith<$Res> {
  factory _$$PortOnePaymentStateImplCopyWith(
    _$PortOnePaymentStateImpl value,
    $Res Function(_$PortOnePaymentStateImpl) then,
  ) = __$$PortOnePaymentStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String storeId,
    String paymentId,
    int amount,
    bool isProcessing,
    String? error,
  });
}

/// @nodoc
class __$$PortOnePaymentStateImplCopyWithImpl<$Res>
    extends _$PortOnePaymentStateCopyWithImpl<$Res, _$PortOnePaymentStateImpl>
    implements _$$PortOnePaymentStateImplCopyWith<$Res> {
  __$$PortOnePaymentStateImplCopyWithImpl(
    _$PortOnePaymentStateImpl _value,
    $Res Function(_$PortOnePaymentStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PortOnePaymentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? paymentId = null,
    Object? amount = null,
    Object? isProcessing = null,
    Object? error = freezed,
  }) {
    return _then(
      _$PortOnePaymentStateImpl(
        storeId: null == storeId
            ? _value.storeId
            : storeId // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentId: null == paymentId
            ? _value.paymentId
            : paymentId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        isProcessing: null == isProcessing
            ? _value.isProcessing
            : isProcessing // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$PortOnePaymentStateImpl implements _PortOnePaymentState {
  const _$PortOnePaymentStateImpl({
    required this.storeId,
    required this.paymentId,
    required this.amount,
    this.isProcessing = false,
    this.error,
  });

  @override
  final String storeId;
  @override
  final String paymentId;
  @override
  final int amount;
  @override
  @JsonKey()
  final bool isProcessing;
  @override
  final String? error;

  @override
  String toString() {
    return 'PortOnePaymentState(storeId: $storeId, paymentId: $paymentId, amount: $amount, isProcessing: $isProcessing, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PortOnePaymentStateImpl &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, storeId, paymentId, amount, isProcessing, error);

  /// Create a copy of PortOnePaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PortOnePaymentStateImplCopyWith<_$PortOnePaymentStateImpl> get copyWith =>
      __$$PortOnePaymentStateImplCopyWithImpl<_$PortOnePaymentStateImpl>(
        this,
        _$identity,
      );
}

abstract class _PortOnePaymentState implements PortOnePaymentState {
  const factory _PortOnePaymentState({
    required final String storeId,
    required final String paymentId,
    required final int amount,
    final bool isProcessing,
    final String? error,
  }) = _$PortOnePaymentStateImpl;

  @override
  String get storeId;
  @override
  String get paymentId;
  @override
  int get amount;
  @override
  bool get isProcessing;
  @override
  String? get error;

  /// Create a copy of PortOnePaymentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PortOnePaymentStateImplCopyWith<_$PortOnePaymentStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
