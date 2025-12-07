// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OrderForm _$OrderFormFromJson(Map<String, dynamic> json) {
  return _OrderForm.fromJson(json);
}

/// @nodoc
mixin _$OrderForm {
  int get count => throw _privateConstructorUsedError;
  String get storeId => throw _privateConstructorUsedError;
  PaymentMethod get paymentMethod => throw _privateConstructorUsedError;
  PaymentCompany get paymentsCompany => throw _privateConstructorUsedError;
  String get pickupTime => throw _privateConstructorUsedError; // HH:mm 형식
  String? get request => throw _privateConstructorUsedError;
  int? get totalPrice => throw _privateConstructorUsedError;
  String? get merchantUid => throw _privateConstructorUsedError;

  /// Serializes this OrderForm to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderForm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderFormCopyWith<OrderForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderFormCopyWith<$Res> {
  factory $OrderFormCopyWith(OrderForm value, $Res Function(OrderForm) then) =
      _$OrderFormCopyWithImpl<$Res, OrderForm>;
  @useResult
  $Res call({
    int count,
    String storeId,
    PaymentMethod paymentMethod,
    PaymentCompany paymentsCompany,
    String pickupTime,
    String? request,
    int? totalPrice,
    String? merchantUid,
  });
}

/// @nodoc
class _$OrderFormCopyWithImpl<$Res, $Val extends OrderForm>
    implements $OrderFormCopyWith<$Res> {
  _$OrderFormCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderForm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? storeId = null,
    Object? paymentMethod = null,
    Object? paymentsCompany = null,
    Object? pickupTime = null,
    Object? request = freezed,
    Object? totalPrice = freezed,
    Object? merchantUid = freezed,
  }) {
    return _then(
      _value.copyWith(
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
            storeId: null == storeId
                ? _value.storeId
                : storeId // ignore: cast_nullable_to_non_nullable
                      as String,
            paymentMethod: null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as PaymentMethod,
            paymentsCompany: null == paymentsCompany
                ? _value.paymentsCompany
                : paymentsCompany // ignore: cast_nullable_to_non_nullable
                      as PaymentCompany,
            pickupTime: null == pickupTime
                ? _value.pickupTime
                : pickupTime // ignore: cast_nullable_to_non_nullable
                      as String,
            request: freezed == request
                ? _value.request
                : request // ignore: cast_nullable_to_non_nullable
                      as String?,
            totalPrice: freezed == totalPrice
                ? _value.totalPrice
                : totalPrice // ignore: cast_nullable_to_non_nullable
                      as int?,
            merchantUid: freezed == merchantUid
                ? _value.merchantUid
                : merchantUid // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderFormImplCopyWith<$Res>
    implements $OrderFormCopyWith<$Res> {
  factory _$$OrderFormImplCopyWith(
    _$OrderFormImpl value,
    $Res Function(_$OrderFormImpl) then,
  ) = __$$OrderFormImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int count,
    String storeId,
    PaymentMethod paymentMethod,
    PaymentCompany paymentsCompany,
    String pickupTime,
    String? request,
    int? totalPrice,
    String? merchantUid,
  });
}

/// @nodoc
class __$$OrderFormImplCopyWithImpl<$Res>
    extends _$OrderFormCopyWithImpl<$Res, _$OrderFormImpl>
    implements _$$OrderFormImplCopyWith<$Res> {
  __$$OrderFormImplCopyWithImpl(
    _$OrderFormImpl _value,
    $Res Function(_$OrderFormImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderForm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? storeId = null,
    Object? paymentMethod = null,
    Object? paymentsCompany = null,
    Object? pickupTime = null,
    Object? request = freezed,
    Object? totalPrice = freezed,
    Object? merchantUid = freezed,
  }) {
    return _then(
      _$OrderFormImpl(
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
        storeId: null == storeId
            ? _value.storeId
            : storeId // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentMethod: null == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as PaymentMethod,
        paymentsCompany: null == paymentsCompany
            ? _value.paymentsCompany
            : paymentsCompany // ignore: cast_nullable_to_non_nullable
                  as PaymentCompany,
        pickupTime: null == pickupTime
            ? _value.pickupTime
            : pickupTime // ignore: cast_nullable_to_non_nullable
                  as String,
        request: freezed == request
            ? _value.request
            : request // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalPrice: freezed == totalPrice
            ? _value.totalPrice
            : totalPrice // ignore: cast_nullable_to_non_nullable
                  as int?,
        merchantUid: freezed == merchantUid
            ? _value.merchantUid
            : merchantUid // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderFormImpl implements _OrderForm {
  const _$OrderFormImpl({
    required this.count,
    required this.storeId,
    required this.paymentMethod,
    required this.paymentsCompany,
    required this.pickupTime,
    this.request,
    this.totalPrice,
    this.merchantUid,
  });

  factory _$OrderFormImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderFormImplFromJson(json);

  @override
  final int count;
  @override
  final String storeId;
  @override
  final PaymentMethod paymentMethod;
  @override
  final PaymentCompany paymentsCompany;
  @override
  final String pickupTime;
  // HH:mm 형식
  @override
  final String? request;
  @override
  final int? totalPrice;
  @override
  final String? merchantUid;

  @override
  String toString() {
    return 'OrderForm(count: $count, storeId: $storeId, paymentMethod: $paymentMethod, paymentsCompany: $paymentsCompany, pickupTime: $pickupTime, request: $request, totalPrice: $totalPrice, merchantUid: $merchantUid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderFormImpl &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.paymentsCompany, paymentsCompany) ||
                other.paymentsCompany == paymentsCompany) &&
            (identical(other.pickupTime, pickupTime) ||
                other.pickupTime == pickupTime) &&
            (identical(other.request, request) || other.request == request) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.merchantUid, merchantUid) ||
                other.merchantUid == merchantUid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    count,
    storeId,
    paymentMethod,
    paymentsCompany,
    pickupTime,
    request,
    totalPrice,
    merchantUid,
  );

  /// Create a copy of OrderForm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderFormImplCopyWith<_$OrderFormImpl> get copyWith =>
      __$$OrderFormImplCopyWithImpl<_$OrderFormImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderFormImplToJson(this);
  }
}

abstract class _OrderForm implements OrderForm {
  const factory _OrderForm({
    required final int count,
    required final String storeId,
    required final PaymentMethod paymentMethod,
    required final PaymentCompany paymentsCompany,
    required final String pickupTime,
    final String? request,
    final int? totalPrice,
    final String? merchantUid,
  }) = _$OrderFormImpl;

  factory _OrderForm.fromJson(Map<String, dynamic> json) =
      _$OrderFormImpl.fromJson;

  @override
  int get count;
  @override
  String get storeId;
  @override
  PaymentMethod get paymentMethod;
  @override
  PaymentCompany get paymentsCompany;
  @override
  String get pickupTime; // HH:mm 형식
  @override
  String? get request;
  @override
  int? get totalPrice;
  @override
  String? get merchantUid;

  /// Create a copy of OrderForm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderFormImplCopyWith<_$OrderFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
