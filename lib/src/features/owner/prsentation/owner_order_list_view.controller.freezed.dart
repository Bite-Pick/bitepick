// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'owner_order_list_view.controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OwnerOrderListState {
  List<OrderOwner> get orders => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  OrderStatus? get selectedStatus => throw _privateConstructorUsedError;
  Map<OrderStatus?, int> get statusCounts => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of OwnerOrderListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OwnerOrderListStateCopyWith<OwnerOrderListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OwnerOrderListStateCopyWith<$Res> {
  factory $OwnerOrderListStateCopyWith(
    OwnerOrderListState value,
    $Res Function(OwnerOrderListState) then,
  ) = _$OwnerOrderListStateCopyWithImpl<$Res, OwnerOrderListState>;
  @useResult
  $Res call({
    List<OrderOwner> orders,
    bool isLoading,
    OrderStatus? selectedStatus,
    Map<OrderStatus?, int> statusCounts,
    String? error,
  });
}

/// @nodoc
class _$OwnerOrderListStateCopyWithImpl<$Res, $Val extends OwnerOrderListState>
    implements $OwnerOrderListStateCopyWith<$Res> {
  _$OwnerOrderListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OwnerOrderListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
    Object? isLoading = null,
    Object? selectedStatus = freezed,
    Object? statusCounts = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            orders: null == orders
                ? _value.orders
                : orders // ignore: cast_nullable_to_non_nullable
                      as List<OrderOwner>,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            selectedStatus: freezed == selectedStatus
                ? _value.selectedStatus
                : selectedStatus // ignore: cast_nullable_to_non_nullable
                      as OrderStatus?,
            statusCounts: null == statusCounts
                ? _value.statusCounts
                : statusCounts // ignore: cast_nullable_to_non_nullable
                      as Map<OrderStatus?, int>,
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
abstract class _$$OwnerOrderListStateImplCopyWith<$Res>
    implements $OwnerOrderListStateCopyWith<$Res> {
  factory _$$OwnerOrderListStateImplCopyWith(
    _$OwnerOrderListStateImpl value,
    $Res Function(_$OwnerOrderListStateImpl) then,
  ) = __$$OwnerOrderListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<OrderOwner> orders,
    bool isLoading,
    OrderStatus? selectedStatus,
    Map<OrderStatus?, int> statusCounts,
    String? error,
  });
}

/// @nodoc
class __$$OwnerOrderListStateImplCopyWithImpl<$Res>
    extends _$OwnerOrderListStateCopyWithImpl<$Res, _$OwnerOrderListStateImpl>
    implements _$$OwnerOrderListStateImplCopyWith<$Res> {
  __$$OwnerOrderListStateImplCopyWithImpl(
    _$OwnerOrderListStateImpl _value,
    $Res Function(_$OwnerOrderListStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OwnerOrderListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
    Object? isLoading = null,
    Object? selectedStatus = freezed,
    Object? statusCounts = null,
    Object? error = freezed,
  }) {
    return _then(
      _$OwnerOrderListStateImpl(
        orders: null == orders
            ? _value._orders
            : orders // ignore: cast_nullable_to_non_nullable
                  as List<OrderOwner>,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedStatus: freezed == selectedStatus
            ? _value.selectedStatus
            : selectedStatus // ignore: cast_nullable_to_non_nullable
                  as OrderStatus?,
        statusCounts: null == statusCounts
            ? _value._statusCounts
            : statusCounts // ignore: cast_nullable_to_non_nullable
                  as Map<OrderStatus?, int>,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$OwnerOrderListStateImpl implements _OwnerOrderListState {
  const _$OwnerOrderListStateImpl({
    final List<OrderOwner> orders = const [],
    this.isLoading = false,
    this.selectedStatus,
    final Map<OrderStatus?, int> statusCounts = const {},
    this.error,
  }) : _orders = orders,
       _statusCounts = statusCounts;

  final List<OrderOwner> _orders;
  @override
  @JsonKey()
  List<OrderOwner> get orders {
    if (_orders is EqualUnmodifiableListView) return _orders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orders);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final OrderStatus? selectedStatus;
  final Map<OrderStatus?, int> _statusCounts;
  @override
  @JsonKey()
  Map<OrderStatus?, int> get statusCounts {
    if (_statusCounts is EqualUnmodifiableMapView) return _statusCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_statusCounts);
  }

  @override
  final String? error;

  @override
  String toString() {
    return 'OwnerOrderListState(orders: $orders, isLoading: $isLoading, selectedStatus: $selectedStatus, statusCounts: $statusCounts, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OwnerOrderListStateImpl &&
            const DeepCollectionEquality().equals(other._orders, _orders) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.selectedStatus, selectedStatus) ||
                other.selectedStatus == selectedStatus) &&
            const DeepCollectionEquality().equals(
              other._statusCounts,
              _statusCounts,
            ) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_orders),
    isLoading,
    selectedStatus,
    const DeepCollectionEquality().hash(_statusCounts),
    error,
  );

  /// Create a copy of OwnerOrderListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OwnerOrderListStateImplCopyWith<_$OwnerOrderListStateImpl> get copyWith =>
      __$$OwnerOrderListStateImplCopyWithImpl<_$OwnerOrderListStateImpl>(
        this,
        _$identity,
      );
}

abstract class _OwnerOrderListState implements OwnerOrderListState {
  const factory _OwnerOrderListState({
    final List<OrderOwner> orders,
    final bool isLoading,
    final OrderStatus? selectedStatus,
    final Map<OrderStatus?, int> statusCounts,
    final String? error,
  }) = _$OwnerOrderListStateImpl;

  @override
  List<OrderOwner> get orders;
  @override
  bool get isLoading;
  @override
  OrderStatus? get selectedStatus;
  @override
  Map<OrderStatus?, int> get statusCounts;
  @override
  String? get error;

  /// Create a copy of OwnerOrderListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OwnerOrderListStateImplCopyWith<_$OwnerOrderListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
