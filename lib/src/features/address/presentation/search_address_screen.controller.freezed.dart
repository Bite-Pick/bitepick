// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_address_screen.controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SearchAddressState {
  List<Address> get addresses =>
      throw _privateConstructorUsedError; // 저장된 주소 목록(최대 5)
  List<Address> get addressSearchResults =>
      throw _privateConstructorUsedError; // 전체 주소 검색 결과
  List<Area> get areaSearchResults =>
      throw _privateConstructorUsedError; // 동 수준 검색 결과
  String get searchText => throw _privateConstructorUsedError; // 입력 텍스트(즉시)
  bool get isLoading => throw _privateConstructorUsedError; // 검색/저장 중 플래그
  String? get message => throw _privateConstructorUsedError;

  /// Create a copy of SearchAddressState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchAddressStateCopyWith<SearchAddressState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchAddressStateCopyWith<$Res> {
  factory $SearchAddressStateCopyWith(
    SearchAddressState value,
    $Res Function(SearchAddressState) then,
  ) = _$SearchAddressStateCopyWithImpl<$Res, SearchAddressState>;
  @useResult
  $Res call({
    List<Address> addresses,
    List<Address> addressSearchResults,
    List<Area> areaSearchResults,
    String searchText,
    bool isLoading,
    String? message,
  });
}

/// @nodoc
class _$SearchAddressStateCopyWithImpl<$Res, $Val extends SearchAddressState>
    implements $SearchAddressStateCopyWith<$Res> {
  _$SearchAddressStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchAddressState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addresses = null,
    Object? addressSearchResults = null,
    Object? areaSearchResults = null,
    Object? searchText = null,
    Object? isLoading = null,
    Object? message = freezed,
  }) {
    return _then(
      _value.copyWith(
            addresses: null == addresses
                ? _value.addresses
                : addresses // ignore: cast_nullable_to_non_nullable
                      as List<Address>,
            addressSearchResults: null == addressSearchResults
                ? _value.addressSearchResults
                : addressSearchResults // ignore: cast_nullable_to_non_nullable
                      as List<Address>,
            areaSearchResults: null == areaSearchResults
                ? _value.areaSearchResults
                : areaSearchResults // ignore: cast_nullable_to_non_nullable
                      as List<Area>,
            searchText: null == searchText
                ? _value.searchText
                : searchText // ignore: cast_nullable_to_non_nullable
                      as String,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
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
abstract class _$$SearchAddressStateImplCopyWith<$Res>
    implements $SearchAddressStateCopyWith<$Res> {
  factory _$$SearchAddressStateImplCopyWith(
    _$SearchAddressStateImpl value,
    $Res Function(_$SearchAddressStateImpl) then,
  ) = __$$SearchAddressStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Address> addresses,
    List<Address> addressSearchResults,
    List<Area> areaSearchResults,
    String searchText,
    bool isLoading,
    String? message,
  });
}

/// @nodoc
class __$$SearchAddressStateImplCopyWithImpl<$Res>
    extends _$SearchAddressStateCopyWithImpl<$Res, _$SearchAddressStateImpl>
    implements _$$SearchAddressStateImplCopyWith<$Res> {
  __$$SearchAddressStateImplCopyWithImpl(
    _$SearchAddressStateImpl _value,
    $Res Function(_$SearchAddressStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchAddressState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addresses = null,
    Object? addressSearchResults = null,
    Object? areaSearchResults = null,
    Object? searchText = null,
    Object? isLoading = null,
    Object? message = freezed,
  }) {
    return _then(
      _$SearchAddressStateImpl(
        addresses: null == addresses
            ? _value._addresses
            : addresses // ignore: cast_nullable_to_non_nullable
                  as List<Address>,
        addressSearchResults: null == addressSearchResults
            ? _value._addressSearchResults
            : addressSearchResults // ignore: cast_nullable_to_non_nullable
                  as List<Address>,
        areaSearchResults: null == areaSearchResults
            ? _value._areaSearchResults
            : areaSearchResults // ignore: cast_nullable_to_non_nullable
                  as List<Area>,
        searchText: null == searchText
            ? _value.searchText
            : searchText // ignore: cast_nullable_to_non_nullable
                  as String,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
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

class _$SearchAddressStateImpl implements _SearchAddressState {
  const _$SearchAddressStateImpl({
    final List<Address> addresses = const [],
    final List<Address> addressSearchResults = const [],
    final List<Area> areaSearchResults = const [],
    this.searchText = '',
    this.isLoading = false,
    this.message,
  }) : _addresses = addresses,
       _addressSearchResults = addressSearchResults,
       _areaSearchResults = areaSearchResults;

  final List<Address> _addresses;
  @override
  @JsonKey()
  List<Address> get addresses {
    if (_addresses is EqualUnmodifiableListView) return _addresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addresses);
  }

  // 저장된 주소 목록(최대 5)
  final List<Address> _addressSearchResults;
  // 저장된 주소 목록(최대 5)
  @override
  @JsonKey()
  List<Address> get addressSearchResults {
    if (_addressSearchResults is EqualUnmodifiableListView)
      return _addressSearchResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addressSearchResults);
  }

  // 전체 주소 검색 결과
  final List<Area> _areaSearchResults;
  // 전체 주소 검색 결과
  @override
  @JsonKey()
  List<Area> get areaSearchResults {
    if (_areaSearchResults is EqualUnmodifiableListView)
      return _areaSearchResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areaSearchResults);
  }

  // 동 수준 검색 결과
  @override
  @JsonKey()
  final String searchText;
  // 입력 텍스트(즉시)
  @override
  @JsonKey()
  final bool isLoading;
  // 검색/저장 중 플래그
  @override
  final String? message;

  @override
  String toString() {
    return 'SearchAddressState(addresses: $addresses, addressSearchResults: $addressSearchResults, areaSearchResults: $areaSearchResults, searchText: $searchText, isLoading: $isLoading, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchAddressStateImpl &&
            const DeepCollectionEquality().equals(
              other._addresses,
              _addresses,
            ) &&
            const DeepCollectionEquality().equals(
              other._addressSearchResults,
              _addressSearchResults,
            ) &&
            const DeepCollectionEquality().equals(
              other._areaSearchResults,
              _areaSearchResults,
            ) &&
            (identical(other.searchText, searchText) ||
                other.searchText == searchText) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_addresses),
    const DeepCollectionEquality().hash(_addressSearchResults),
    const DeepCollectionEquality().hash(_areaSearchResults),
    searchText,
    isLoading,
    message,
  );

  /// Create a copy of SearchAddressState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchAddressStateImplCopyWith<_$SearchAddressStateImpl> get copyWith =>
      __$$SearchAddressStateImplCopyWithImpl<_$SearchAddressStateImpl>(
        this,
        _$identity,
      );
}

abstract class _SearchAddressState implements SearchAddressState {
  const factory _SearchAddressState({
    final List<Address> addresses,
    final List<Address> addressSearchResults,
    final List<Area> areaSearchResults,
    final String searchText,
    final bool isLoading,
    final String? message,
  }) = _$SearchAddressStateImpl;

  @override
  List<Address> get addresses; // 저장된 주소 목록(최대 5)
  @override
  List<Address> get addressSearchResults; // 전체 주소 검색 결과
  @override
  List<Area> get areaSearchResults; // 동 수준 검색 결과
  @override
  String get searchText; // 입력 텍스트(즉시)
  @override
  bool get isLoading; // 검색/저장 중 플래그
  @override
  String? get message;

  /// Create a copy of SearchAddressState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchAddressStateImplCopyWith<_$SearchAddressStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
