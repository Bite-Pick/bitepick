// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_screen.controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HomeScreenControllerState {
  bool get onlyAvailable => throw _privateConstructorUsedError;
  SortType get sortType => throw _privateConstructorUsedError;
  Address get defaultAddress => throw _privateConstructorUsedError;
  List<StoreListDTO> get storeGoodsList => throw _privateConstructorUsedError;
  List<Address> get serviceAddresses => throw _privateConstructorUsedError;

  /// Create a copy of HomeScreenControllerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeScreenControllerStateCopyWith<HomeScreenControllerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeScreenControllerStateCopyWith<$Res> {
  factory $HomeScreenControllerStateCopyWith(
    HomeScreenControllerState value,
    $Res Function(HomeScreenControllerState) then,
  ) = _$HomeScreenControllerStateCopyWithImpl<$Res, HomeScreenControllerState>;
  @useResult
  $Res call({
    bool onlyAvailable,
    SortType sortType,
    Address defaultAddress,
    List<StoreListDTO> storeGoodsList,
    List<Address> serviceAddresses,
  });

  $AddressCopyWith<$Res> get defaultAddress;
}

/// @nodoc
class _$HomeScreenControllerStateCopyWithImpl<
  $Res,
  $Val extends HomeScreenControllerState
>
    implements $HomeScreenControllerStateCopyWith<$Res> {
  _$HomeScreenControllerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeScreenControllerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onlyAvailable = null,
    Object? sortType = null,
    Object? defaultAddress = null,
    Object? storeGoodsList = null,
    Object? serviceAddresses = null,
  }) {
    return _then(
      _value.copyWith(
            onlyAvailable: null == onlyAvailable
                ? _value.onlyAvailable
                : onlyAvailable // ignore: cast_nullable_to_non_nullable
                      as bool,
            sortType: null == sortType
                ? _value.sortType
                : sortType // ignore: cast_nullable_to_non_nullable
                      as SortType,
            defaultAddress: null == defaultAddress
                ? _value.defaultAddress
                : defaultAddress // ignore: cast_nullable_to_non_nullable
                      as Address,
            storeGoodsList: null == storeGoodsList
                ? _value.storeGoodsList
                : storeGoodsList // ignore: cast_nullable_to_non_nullable
                      as List<StoreListDTO>,
            serviceAddresses: null == serviceAddresses
                ? _value.serviceAddresses
                : serviceAddresses // ignore: cast_nullable_to_non_nullable
                      as List<Address>,
          )
          as $Val,
    );
  }

  /// Create a copy of HomeScreenControllerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get defaultAddress {
    return $AddressCopyWith<$Res>(_value.defaultAddress, (value) {
      return _then(_value.copyWith(defaultAddress: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeScreenControllerStateImplCopyWith<$Res>
    implements $HomeScreenControllerStateCopyWith<$Res> {
  factory _$$HomeScreenControllerStateImplCopyWith(
    _$HomeScreenControllerStateImpl value,
    $Res Function(_$HomeScreenControllerStateImpl) then,
  ) = __$$HomeScreenControllerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool onlyAvailable,
    SortType sortType,
    Address defaultAddress,
    List<StoreListDTO> storeGoodsList,
    List<Address> serviceAddresses,
  });

  @override
  $AddressCopyWith<$Res> get defaultAddress;
}

/// @nodoc
class __$$HomeScreenControllerStateImplCopyWithImpl<$Res>
    extends
        _$HomeScreenControllerStateCopyWithImpl<
          $Res,
          _$HomeScreenControllerStateImpl
        >
    implements _$$HomeScreenControllerStateImplCopyWith<$Res> {
  __$$HomeScreenControllerStateImplCopyWithImpl(
    _$HomeScreenControllerStateImpl _value,
    $Res Function(_$HomeScreenControllerStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeScreenControllerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onlyAvailable = null,
    Object? sortType = null,
    Object? defaultAddress = null,
    Object? storeGoodsList = null,
    Object? serviceAddresses = null,
  }) {
    return _then(
      _$HomeScreenControllerStateImpl(
        onlyAvailable: null == onlyAvailable
            ? _value.onlyAvailable
            : onlyAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
        sortType: null == sortType
            ? _value.sortType
            : sortType // ignore: cast_nullable_to_non_nullable
                  as SortType,
        defaultAddress: null == defaultAddress
            ? _value.defaultAddress
            : defaultAddress // ignore: cast_nullable_to_non_nullable
                  as Address,
        storeGoodsList: null == storeGoodsList
            ? _value._storeGoodsList
            : storeGoodsList // ignore: cast_nullable_to_non_nullable
                  as List<StoreListDTO>,
        serviceAddresses: null == serviceAddresses
            ? _value._serviceAddresses
            : serviceAddresses // ignore: cast_nullable_to_non_nullable
                  as List<Address>,
      ),
    );
  }
}

/// @nodoc

class _$HomeScreenControllerStateImpl implements _HomeScreenControllerState {
  const _$HomeScreenControllerStateImpl({
    required this.onlyAvailable,
    required this.sortType,
    required this.defaultAddress,
    required final List<StoreListDTO> storeGoodsList,
    required final List<Address> serviceAddresses,
  }) : _storeGoodsList = storeGoodsList,
       _serviceAddresses = serviceAddresses;

  @override
  final bool onlyAvailable;
  @override
  final SortType sortType;
  @override
  final Address defaultAddress;
  final List<StoreListDTO> _storeGoodsList;
  @override
  List<StoreListDTO> get storeGoodsList {
    if (_storeGoodsList is EqualUnmodifiableListView) return _storeGoodsList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_storeGoodsList);
  }

  final List<Address> _serviceAddresses;
  @override
  List<Address> get serviceAddresses {
    if (_serviceAddresses is EqualUnmodifiableListView)
      return _serviceAddresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_serviceAddresses);
  }

  @override
  String toString() {
    return 'HomeScreenControllerState(onlyAvailable: $onlyAvailable, sortType: $sortType, defaultAddress: $defaultAddress, storeGoodsList: $storeGoodsList, serviceAddresses: $serviceAddresses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeScreenControllerStateImpl &&
            (identical(other.onlyAvailable, onlyAvailable) ||
                other.onlyAvailable == onlyAvailable) &&
            (identical(other.sortType, sortType) ||
                other.sortType == sortType) &&
            (identical(other.defaultAddress, defaultAddress) ||
                other.defaultAddress == defaultAddress) &&
            const DeepCollectionEquality().equals(
              other._storeGoodsList,
              _storeGoodsList,
            ) &&
            const DeepCollectionEquality().equals(
              other._serviceAddresses,
              _serviceAddresses,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    onlyAvailable,
    sortType,
    defaultAddress,
    const DeepCollectionEquality().hash(_storeGoodsList),
    const DeepCollectionEquality().hash(_serviceAddresses),
  );

  /// Create a copy of HomeScreenControllerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeScreenControllerStateImplCopyWith<_$HomeScreenControllerStateImpl>
  get copyWith =>
      __$$HomeScreenControllerStateImplCopyWithImpl<
        _$HomeScreenControllerStateImpl
      >(this, _$identity);
}

abstract class _HomeScreenControllerState implements HomeScreenControllerState {
  const factory _HomeScreenControllerState({
    required final bool onlyAvailable,
    required final SortType sortType,
    required final Address defaultAddress,
    required final List<StoreListDTO> storeGoodsList,
    required final List<Address> serviceAddresses,
  }) = _$HomeScreenControllerStateImpl;

  @override
  bool get onlyAvailable;
  @override
  SortType get sortType;
  @override
  Address get defaultAddress;
  @override
  List<StoreListDTO> get storeGoodsList;
  @override
  List<Address> get serviceAddresses;

  /// Create a copy of HomeScreenControllerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeScreenControllerStateImplCopyWith<_$HomeScreenControllerStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
