// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) {
  return _OrderResponse.fromJson(json);
}

/// @nodoc
mixin _$OrderResponse {
  String get merchantUid => throw _privateConstructorUsedError;
  int get totalAmount => throw _privateConstructorUsedError;

  /// Serializes this OrderResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderResponseCopyWith<OrderResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderResponseCopyWith<$Res> {
  factory $OrderResponseCopyWith(
    OrderResponse value,
    $Res Function(OrderResponse) then,
  ) = _$OrderResponseCopyWithImpl<$Res, OrderResponse>;
  @useResult
  $Res call({String merchantUid, int totalAmount});
}

/// @nodoc
class _$OrderResponseCopyWithImpl<$Res, $Val extends OrderResponse>
    implements $OrderResponseCopyWith<$Res> {
  _$OrderResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? merchantUid = null, Object? totalAmount = null}) {
    return _then(
      _value.copyWith(
            merchantUid: null == merchantUid
                ? _value.merchantUid
                : merchantUid // ignore: cast_nullable_to_non_nullable
                      as String,
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderResponseImplCopyWith<$Res>
    implements $OrderResponseCopyWith<$Res> {
  factory _$$OrderResponseImplCopyWith(
    _$OrderResponseImpl value,
    $Res Function(_$OrderResponseImpl) then,
  ) = __$$OrderResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String merchantUid, int totalAmount});
}

/// @nodoc
class __$$OrderResponseImplCopyWithImpl<$Res>
    extends _$OrderResponseCopyWithImpl<$Res, _$OrderResponseImpl>
    implements _$$OrderResponseImplCopyWith<$Res> {
  __$$OrderResponseImplCopyWithImpl(
    _$OrderResponseImpl _value,
    $Res Function(_$OrderResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? merchantUid = null, Object? totalAmount = null}) {
    return _then(
      _$OrderResponseImpl(
        merchantUid: null == merchantUid
            ? _value.merchantUid
            : merchantUid // ignore: cast_nullable_to_non_nullable
                  as String,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderResponseImpl implements _OrderResponse {
  const _$OrderResponseImpl({
    required this.merchantUid,
    required this.totalAmount,
  });

  factory _$OrderResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderResponseImplFromJson(json);

  @override
  final String merchantUid;
  @override
  final int totalAmount;

  @override
  String toString() {
    return 'OrderResponse(merchantUid: $merchantUid, totalAmount: $totalAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderResponseImpl &&
            (identical(other.merchantUid, merchantUid) ||
                other.merchantUid == merchantUid) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, merchantUid, totalAmount);

  /// Create a copy of OrderResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderResponseImplCopyWith<_$OrderResponseImpl> get copyWith =>
      __$$OrderResponseImplCopyWithImpl<_$OrderResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderResponseImplToJson(this);
  }
}

abstract class _OrderResponse implements OrderResponse {
  const factory _OrderResponse({
    required final String merchantUid,
    required final int totalAmount,
  }) = _$OrderResponseImpl;

  factory _OrderResponse.fromJson(Map<String, dynamic> json) =
      _$OrderResponseImpl.fromJson;

  @override
  String get merchantUid;
  @override
  int get totalAmount;

  /// Create a copy of OrderResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderResponseImplCopyWith<_$OrderResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentCompleteRequest _$PaymentCompleteRequestFromJson(
  Map<String, dynamic> json,
) {
  return _PaymentCompleteRequest.fromJson(json);
}

/// @nodoc
mixin _$PaymentCompleteRequest {
  String get impUid => throw _privateConstructorUsedError;
  String get merchantUid => throw _privateConstructorUsedError;

  /// Serializes this PaymentCompleteRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentCompleteRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentCompleteRequestCopyWith<PaymentCompleteRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentCompleteRequestCopyWith<$Res> {
  factory $PaymentCompleteRequestCopyWith(
    PaymentCompleteRequest value,
    $Res Function(PaymentCompleteRequest) then,
  ) = _$PaymentCompleteRequestCopyWithImpl<$Res, PaymentCompleteRequest>;
  @useResult
  $Res call({String impUid, String merchantUid});
}

/// @nodoc
class _$PaymentCompleteRequestCopyWithImpl<
  $Res,
  $Val extends PaymentCompleteRequest
>
    implements $PaymentCompleteRequestCopyWith<$Res> {
  _$PaymentCompleteRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentCompleteRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? impUid = null, Object? merchantUid = null}) {
    return _then(
      _value.copyWith(
            impUid: null == impUid
                ? _value.impUid
                : impUid // ignore: cast_nullable_to_non_nullable
                      as String,
            merchantUid: null == merchantUid
                ? _value.merchantUid
                : merchantUid // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaymentCompleteRequestImplCopyWith<$Res>
    implements $PaymentCompleteRequestCopyWith<$Res> {
  factory _$$PaymentCompleteRequestImplCopyWith(
    _$PaymentCompleteRequestImpl value,
    $Res Function(_$PaymentCompleteRequestImpl) then,
  ) = __$$PaymentCompleteRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String impUid, String merchantUid});
}

/// @nodoc
class __$$PaymentCompleteRequestImplCopyWithImpl<$Res>
    extends
        _$PaymentCompleteRequestCopyWithImpl<$Res, _$PaymentCompleteRequestImpl>
    implements _$$PaymentCompleteRequestImplCopyWith<$Res> {
  __$$PaymentCompleteRequestImplCopyWithImpl(
    _$PaymentCompleteRequestImpl _value,
    $Res Function(_$PaymentCompleteRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentCompleteRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? impUid = null, Object? merchantUid = null}) {
    return _then(
      _$PaymentCompleteRequestImpl(
        impUid: null == impUid
            ? _value.impUid
            : impUid // ignore: cast_nullable_to_non_nullable
                  as String,
        merchantUid: null == merchantUid
            ? _value.merchantUid
            : merchantUid // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentCompleteRequestImpl implements _PaymentCompleteRequest {
  const _$PaymentCompleteRequestImpl({
    required this.impUid,
    required this.merchantUid,
  });

  factory _$PaymentCompleteRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentCompleteRequestImplFromJson(json);

  @override
  final String impUid;
  @override
  final String merchantUid;

  @override
  String toString() {
    return 'PaymentCompleteRequest(impUid: $impUid, merchantUid: $merchantUid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentCompleteRequestImpl &&
            (identical(other.impUid, impUid) || other.impUid == impUid) &&
            (identical(other.merchantUid, merchantUid) ||
                other.merchantUid == merchantUid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, impUid, merchantUid);

  /// Create a copy of PaymentCompleteRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentCompleteRequestImplCopyWith<_$PaymentCompleteRequestImpl>
  get copyWith =>
      __$$PaymentCompleteRequestImplCopyWithImpl<_$PaymentCompleteRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentCompleteRequestImplToJson(this);
  }
}

abstract class _PaymentCompleteRequest implements PaymentCompleteRequest {
  const factory _PaymentCompleteRequest({
    required final String impUid,
    required final String merchantUid,
  }) = _$PaymentCompleteRequestImpl;

  factory _PaymentCompleteRequest.fromJson(Map<String, dynamic> json) =
      _$PaymentCompleteRequestImpl.fromJson;

  @override
  String get impUid;
  @override
  String get merchantUid;

  /// Create a copy of PaymentCompleteRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentCompleteRequestImplCopyWith<_$PaymentCompleteRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PaymentCompleteResponse _$PaymentCompleteResponseFromJson(
  Map<String, dynamic> json,
) {
  return _PaymentCompleteResponse.fromJson(json);
}

/// @nodoc
mixin _$PaymentCompleteResponse {
  bool get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this PaymentCompleteResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentCompleteResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentCompleteResponseCopyWith<PaymentCompleteResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentCompleteResponseCopyWith<$Res> {
  factory $PaymentCompleteResponseCopyWith(
    PaymentCompleteResponse value,
    $Res Function(PaymentCompleteResponse) then,
  ) = _$PaymentCompleteResponseCopyWithImpl<$Res, PaymentCompleteResponse>;
  @useResult
  $Res call({bool success, String? message});
}

/// @nodoc
class _$PaymentCompleteResponseCopyWithImpl<
  $Res,
  $Val extends PaymentCompleteResponse
>
    implements $PaymentCompleteResponseCopyWith<$Res> {
  _$PaymentCompleteResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentCompleteResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? success = null, Object? message = freezed}) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaymentCompleteResponseImplCopyWith<$Res>
    implements $PaymentCompleteResponseCopyWith<$Res> {
  factory _$$PaymentCompleteResponseImplCopyWith(
    _$PaymentCompleteResponseImpl value,
    $Res Function(_$PaymentCompleteResponseImpl) then,
  ) = __$$PaymentCompleteResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String? message});
}

/// @nodoc
class __$$PaymentCompleteResponseImplCopyWithImpl<$Res>
    extends
        _$PaymentCompleteResponseCopyWithImpl<
          $Res,
          _$PaymentCompleteResponseImpl
        >
    implements _$$PaymentCompleteResponseImplCopyWith<$Res> {
  __$$PaymentCompleteResponseImplCopyWithImpl(
    _$PaymentCompleteResponseImpl _value,
    $Res Function(_$PaymentCompleteResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentCompleteResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? success = null, Object? message = freezed}) {
    return _then(
      _$PaymentCompleteResponseImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentCompleteResponseImpl implements _PaymentCompleteResponse {
  const _$PaymentCompleteResponseImpl({required this.success, this.message});

  factory _$PaymentCompleteResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentCompleteResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String? message;

  @override
  String toString() {
    return 'PaymentCompleteResponse(success: $success, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentCompleteResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message);

  /// Create a copy of PaymentCompleteResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentCompleteResponseImplCopyWith<_$PaymentCompleteResponseImpl>
  get copyWith =>
      __$$PaymentCompleteResponseImplCopyWithImpl<
        _$PaymentCompleteResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentCompleteResponseImplToJson(this);
  }
}

abstract class _PaymentCompleteResponse implements PaymentCompleteResponse {
  const factory _PaymentCompleteResponse({
    required final bool success,
    final String? message,
  }) = _$PaymentCompleteResponseImpl;

  factory _PaymentCompleteResponse.fromJson(Map<String, dynamic> json) =
      _$PaymentCompleteResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String? get message;

  /// Create a copy of PaymentCompleteResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentCompleteResponseImplCopyWith<_$PaymentCompleteResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
