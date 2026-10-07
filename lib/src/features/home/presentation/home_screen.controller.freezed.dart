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

  /// 거리 계산 기준 좌표 (현위치 또는 죽전역)
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  /// 서버에서 받은 전체 매장 (필터/정렬 전)
  List<StoreListDTO> get allStores => throw _privateConstructorUsedError;

  /// 필터/정렬이 적용된 전체 매장
  List<StoreListDTO> get storeGoodsList => throw _privateConstructorUsedError;
  List<Address> get serviceAddresses => throw _privateConstructorUsedError;
  int get visibleCount => throw _privateConstructorUsedError;

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
    double latitude,
    double longitude,
    List<StoreListDTO> allStores,
    List<StoreListDTO> storeGoodsList,
    List<Address> serviceAddresses,
    int visibleCount,
  });
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
    Object? latitude = null,
    Object? longitude = null,
    Object? allStores = null,
    Object? storeGoodsList = null,
    Object? serviceAddresses = null,
    Object? visibleCount = null,
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
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            allStores: null == allStores
                ? _value.allStores
                : allStores // ignore: cast_nullable_to_non_nullable
                      as List<StoreListDTO>,
            storeGoodsList: null == storeGoodsList
                ? _value.storeGoodsList
                : storeGoodsList // ignore: cast_nullable_to_non_nullable
                      as List<StoreListDTO>,
            serviceAddresses: null == serviceAddresses
                ? _value.serviceAddresses
                : serviceAddresses // ignore: cast_nullable_to_non_nullable
                      as List<Address>,
            visibleCount: null == visibleCount
                ? _value.visibleCount
                : visibleCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
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
    double latitude,
    double longitude,
    List<StoreListDTO> allStores,
    List<StoreListDTO> storeGoodsList,
    List<Address> serviceAddresses,
    int visibleCount,
  });
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
    Object? latitude = null,
    Object? longitude = null,
    Object? allStores = null,
    Object? storeGoodsList = null,
    Object? serviceAddresses = null,
    Object? visibleCount = null,
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
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        allStores: null == allStores
            ? _value._allStores
            : allStores // ignore: cast_nullable_to_non_nullable
                  as List<StoreListDTO>,
        storeGoodsList: null == storeGoodsList
            ? _value._storeGoodsList
            : storeGoodsList // ignore: cast_nullable_to_non_nullable
                  as List<StoreListDTO>,
        serviceAddresses: null == serviceAddresses
            ? _value._serviceAddresses
            : serviceAddresses // ignore: cast_nullable_to_non_nullable
                  as List<Address>,
        visibleCount: null == visibleCount
            ? _value.visibleCount
            : visibleCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$HomeScreenControllerStateImpl extends _HomeScreenControllerState {
  const _$HomeScreenControllerStateImpl({
    required this.onlyAvailable,
    required this.sortType,
    required this.latitude,
    required this.longitude,
    required final List<StoreListDTO> allStores,
    required final List<StoreListDTO> storeGoodsList,
    required final List<Address> serviceAddresses,
    this.visibleCount = _pageSize,
  }) : _allStores = allStores,
       _storeGoodsList = storeGoodsList,
       _serviceAddresses = serviceAddresses,
       super._();

  @override
  final bool onlyAvailable;
  @override
  final SortType sortType;

  /// 거리 계산 기준 좌표 (현위치 또는 죽전역)
  @override
  final double latitude;
  @override
  final double longitude;

  /// 서버에서 받은 전체 매장 (필터/정렬 전)
  final List<StoreListDTO> _allStores;

  /// 서버에서 받은 전체 매장 (필터/정렬 전)
  @override
  List<StoreListDTO> get allStores {
    if (_allStores is EqualUnmodifiableListView) return _allStores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allStores);
  }

  /// 필터/정렬이 적용된 전체 매장
  final List<StoreListDTO> _storeGoodsList;

  /// 필터/정렬이 적용된 전체 매장
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
  @JsonKey()
  final int visibleCount;

  @override
  String toString() {
    return 'HomeScreenControllerState(onlyAvailable: $onlyAvailable, sortType: $sortType, latitude: $latitude, longitude: $longitude, allStores: $allStores, storeGoodsList: $storeGoodsList, serviceAddresses: $serviceAddresses, visibleCount: $visibleCount)';
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
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            const DeepCollectionEquality().equals(
              other._allStores,
              _allStores,
            ) &&
            const DeepCollectionEquality().equals(
              other._storeGoodsList,
              _storeGoodsList,
            ) &&
            const DeepCollectionEquality().equals(
              other._serviceAddresses,
              _serviceAddresses,
            ) &&
            (identical(other.visibleCount, visibleCount) ||
                other.visibleCount == visibleCount));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    onlyAvailable,
    sortType,
    latitude,
    longitude,
    const DeepCollectionEquality().hash(_allStores),
    const DeepCollectionEquality().hash(_storeGoodsList),
    const DeepCollectionEquality().hash(_serviceAddresses),
    visibleCount,
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

abstract class _HomeScreenControllerState extends HomeScreenControllerState {
  const factory _HomeScreenControllerState({
    required final bool onlyAvailable,
    required final SortType sortType,
    required final double latitude,
    required final double longitude,
    required final List<StoreListDTO> allStores,
    required final List<StoreListDTO> storeGoodsList,
    required final List<Address> serviceAddresses,
    final int visibleCount,
  }) = _$HomeScreenControllerStateImpl;
  const _HomeScreenControllerState._() : super._();

  @override
  bool get onlyAvailable;
  @override
  SortType get sortType;

  /// 거리 계산 기준 좌표 (현위치 또는 죽전역)
  @override
  double get latitude;
  @override
  double get longitude;

  /// 서버에서 받은 전체 매장 (필터/정렬 전)
  @override
  List<StoreListDTO> get allStores;

  /// 필터/정렬이 적용된 전체 매장
  @override
  List<StoreListDTO> get storeGoodsList;
  @override
  List<Address> get serviceAddresses;
  @override
  int get visibleCount;

  /// Create a copy of HomeScreenControllerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeScreenControllerStateImplCopyWith<_$HomeScreenControllerStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
