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

  /// 서버에 보내는 기준 좌표 (현위치 또는 죽전역)
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  /// 위치 권한(및 위치 서비스)이 허용되어 매장 목록을 보여줄 수 있는지 여부
  bool get isLocationGranted => throw _privateConstructorUsedError;
  List<StoreListDTO> get storeGoodsList => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;

  /// 다음 페이지 조회가 실패한 상태. 사용자가 재시도하기 전까지 자동 재요청하지 않는다.
  bool get loadMoreFailed => throw _privateConstructorUsedError;

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
    bool isLocationGranted,
    List<StoreListDTO> storeGoodsList,
    int currentPage,
    bool isLoadingMore,
    bool hasMore,
    bool loadMoreFailed,
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
    Object? isLocationGranted = null,
    Object? storeGoodsList = null,
    Object? currentPage = null,
    Object? isLoadingMore = null,
    Object? hasMore = null,
    Object? loadMoreFailed = null,
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
            isLocationGranted: null == isLocationGranted
                ? _value.isLocationGranted
                : isLocationGranted // ignore: cast_nullable_to_non_nullable
                      as bool,
            storeGoodsList: null == storeGoodsList
                ? _value.storeGoodsList
                : storeGoodsList // ignore: cast_nullable_to_non_nullable
                      as List<StoreListDTO>,
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
            isLoadingMore: null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            loadMoreFailed: null == loadMoreFailed
                ? _value.loadMoreFailed
                : loadMoreFailed // ignore: cast_nullable_to_non_nullable
                      as bool,
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
    bool isLocationGranted,
    List<StoreListDTO> storeGoodsList,
    int currentPage,
    bool isLoadingMore,
    bool hasMore,
    bool loadMoreFailed,
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
    Object? isLocationGranted = null,
    Object? storeGoodsList = null,
    Object? currentPage = null,
    Object? isLoadingMore = null,
    Object? hasMore = null,
    Object? loadMoreFailed = null,
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
        isLocationGranted: null == isLocationGranted
            ? _value.isLocationGranted
            : isLocationGranted // ignore: cast_nullable_to_non_nullable
                  as bool,
        storeGoodsList: null == storeGoodsList
            ? _value._storeGoodsList
            : storeGoodsList // ignore: cast_nullable_to_non_nullable
                  as List<StoreListDTO>,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        loadMoreFailed: null == loadMoreFailed
            ? _value.loadMoreFailed
            : loadMoreFailed // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$HomeScreenControllerStateImpl implements _HomeScreenControllerState {
  const _$HomeScreenControllerStateImpl({
    required this.onlyAvailable,
    required this.sortType,
    required this.latitude,
    required this.longitude,
    required this.isLocationGranted,
    required final List<StoreListDTO> storeGoodsList,
    this.currentPage = 1,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.loadMoreFailed = false,
  }) : _storeGoodsList = storeGoodsList;

  @override
  final bool onlyAvailable;
  @override
  final SortType sortType;

  /// 서버에 보내는 기준 좌표 (현위치 또는 죽전역)
  @override
  final double latitude;
  @override
  final double longitude;

  /// 위치 권한(및 위치 서비스)이 허용되어 매장 목록을 보여줄 수 있는지 여부
  @override
  final bool isLocationGranted;
  final List<StoreListDTO> _storeGoodsList;
  @override
  List<StoreListDTO> get storeGoodsList {
    if (_storeGoodsList is EqualUnmodifiableListView) return _storeGoodsList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_storeGoodsList);
  }

  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  @JsonKey()
  final bool hasMore;

  /// 다음 페이지 조회가 실패한 상태. 사용자가 재시도하기 전까지 자동 재요청하지 않는다.
  @override
  @JsonKey()
  final bool loadMoreFailed;

  @override
  String toString() {
    return 'HomeScreenControllerState(onlyAvailable: $onlyAvailable, sortType: $sortType, latitude: $latitude, longitude: $longitude, isLocationGranted: $isLocationGranted, storeGoodsList: $storeGoodsList, currentPage: $currentPage, isLoadingMore: $isLoadingMore, hasMore: $hasMore, loadMoreFailed: $loadMoreFailed)';
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
            (identical(other.isLocationGranted, isLocationGranted) ||
                other.isLocationGranted == isLocationGranted) &&
            const DeepCollectionEquality().equals(
              other._storeGoodsList,
              _storeGoodsList,
            ) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.loadMoreFailed, loadMoreFailed) ||
                other.loadMoreFailed == loadMoreFailed));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    onlyAvailable,
    sortType,
    latitude,
    longitude,
    isLocationGranted,
    const DeepCollectionEquality().hash(_storeGoodsList),
    currentPage,
    isLoadingMore,
    hasMore,
    loadMoreFailed,
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
    required final double latitude,
    required final double longitude,
    required final bool isLocationGranted,
    required final List<StoreListDTO> storeGoodsList,
    final int currentPage,
    final bool isLoadingMore,
    final bool hasMore,
    final bool loadMoreFailed,
  }) = _$HomeScreenControllerStateImpl;

  @override
  bool get onlyAvailable;
  @override
  SortType get sortType;

  /// 서버에 보내는 기준 좌표 (현위치 또는 죽전역)
  @override
  double get latitude;
  @override
  double get longitude;

  /// 위치 권한(및 위치 서비스)이 허용되어 매장 목록을 보여줄 수 있는지 여부
  @override
  bool get isLocationGranted;
  @override
  List<StoreListDTO> get storeGoodsList;
  @override
  int get currentPage;
  @override
  bool get isLoadingMore;
  @override
  bool get hasMore;

  /// 다음 페이지 조회가 실패한 상태. 사용자가 재시도하기 전까지 자동 재요청하지 않는다.
  @override
  bool get loadMoreFailed;

  /// Create a copy of HomeScreenControllerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeScreenControllerStateImplCopyWith<_$HomeScreenControllerStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
