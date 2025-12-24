// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_service_region_screen.controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SelectServiceRegionState {
  String? get selectedCity => throw _privateConstructorUsedError;
  String? get selectedDistrict => throw _privateConstructorUsedError;
  String? get selectedTown => throw _privateConstructorUsedError;
  List<String> get districts => throw _privateConstructorUsedError;
  List<Town> get towns => throw _privateConstructorUsedError;

  /// Create a copy of SelectServiceRegionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelectServiceRegionStateCopyWith<SelectServiceRegionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectServiceRegionStateCopyWith<$Res> {
  factory $SelectServiceRegionStateCopyWith(
    SelectServiceRegionState value,
    $Res Function(SelectServiceRegionState) then,
  ) = _$SelectServiceRegionStateCopyWithImpl<$Res, SelectServiceRegionState>;
  @useResult
  $Res call({
    String? selectedCity,
    String? selectedDistrict,
    String? selectedTown,
    List<String> districts,
    List<Town> towns,
  });
}

/// @nodoc
class _$SelectServiceRegionStateCopyWithImpl<
  $Res,
  $Val extends SelectServiceRegionState
>
    implements $SelectServiceRegionStateCopyWith<$Res> {
  _$SelectServiceRegionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectServiceRegionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedCity = freezed,
    Object? selectedDistrict = freezed,
    Object? selectedTown = freezed,
    Object? districts = null,
    Object? towns = null,
  }) {
    return _then(
      _value.copyWith(
            selectedCity: freezed == selectedCity
                ? _value.selectedCity
                : selectedCity // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedDistrict: freezed == selectedDistrict
                ? _value.selectedDistrict
                : selectedDistrict // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedTown: freezed == selectedTown
                ? _value.selectedTown
                : selectedTown // ignore: cast_nullable_to_non_nullable
                      as String?,
            districts: null == districts
                ? _value.districts
                : districts // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            towns: null == towns
                ? _value.towns
                : towns // ignore: cast_nullable_to_non_nullable
                      as List<Town>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SelectServiceRegionStateImplCopyWith<$Res>
    implements $SelectServiceRegionStateCopyWith<$Res> {
  factory _$$SelectServiceRegionStateImplCopyWith(
    _$SelectServiceRegionStateImpl value,
    $Res Function(_$SelectServiceRegionStateImpl) then,
  ) = __$$SelectServiceRegionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? selectedCity,
    String? selectedDistrict,
    String? selectedTown,
    List<String> districts,
    List<Town> towns,
  });
}

/// @nodoc
class __$$SelectServiceRegionStateImplCopyWithImpl<$Res>
    extends
        _$SelectServiceRegionStateCopyWithImpl<
          $Res,
          _$SelectServiceRegionStateImpl
        >
    implements _$$SelectServiceRegionStateImplCopyWith<$Res> {
  __$$SelectServiceRegionStateImplCopyWithImpl(
    _$SelectServiceRegionStateImpl _value,
    $Res Function(_$SelectServiceRegionStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SelectServiceRegionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedCity = freezed,
    Object? selectedDistrict = freezed,
    Object? selectedTown = freezed,
    Object? districts = null,
    Object? towns = null,
  }) {
    return _then(
      _$SelectServiceRegionStateImpl(
        selectedCity: freezed == selectedCity
            ? _value.selectedCity
            : selectedCity // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedDistrict: freezed == selectedDistrict
            ? _value.selectedDistrict
            : selectedDistrict // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedTown: freezed == selectedTown
            ? _value.selectedTown
            : selectedTown // ignore: cast_nullable_to_non_nullable
                  as String?,
        districts: null == districts
            ? _value._districts
            : districts // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        towns: null == towns
            ? _value._towns
            : towns // ignore: cast_nullable_to_non_nullable
                  as List<Town>,
      ),
    );
  }
}

/// @nodoc

class _$SelectServiceRegionStateImpl implements _SelectServiceRegionState {
  const _$SelectServiceRegionStateImpl({
    this.selectedCity,
    this.selectedDistrict,
    this.selectedTown,
    final List<String> districts = const [],
    final List<Town> towns = const [],
  }) : _districts = districts,
       _towns = towns;

  @override
  final String? selectedCity;
  @override
  final String? selectedDistrict;
  @override
  final String? selectedTown;
  final List<String> _districts;
  @override
  @JsonKey()
  List<String> get districts {
    if (_districts is EqualUnmodifiableListView) return _districts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_districts);
  }

  final List<Town> _towns;
  @override
  @JsonKey()
  List<Town> get towns {
    if (_towns is EqualUnmodifiableListView) return _towns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_towns);
  }

  @override
  String toString() {
    return 'SelectServiceRegionState(selectedCity: $selectedCity, selectedDistrict: $selectedDistrict, selectedTown: $selectedTown, districts: $districts, towns: $towns)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectServiceRegionStateImpl &&
            (identical(other.selectedCity, selectedCity) ||
                other.selectedCity == selectedCity) &&
            (identical(other.selectedDistrict, selectedDistrict) ||
                other.selectedDistrict == selectedDistrict) &&
            (identical(other.selectedTown, selectedTown) ||
                other.selectedTown == selectedTown) &&
            const DeepCollectionEquality().equals(
              other._districts,
              _districts,
            ) &&
            const DeepCollectionEquality().equals(other._towns, _towns));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    selectedCity,
    selectedDistrict,
    selectedTown,
    const DeepCollectionEquality().hash(_districts),
    const DeepCollectionEquality().hash(_towns),
  );

  /// Create a copy of SelectServiceRegionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectServiceRegionStateImplCopyWith<_$SelectServiceRegionStateImpl>
  get copyWith =>
      __$$SelectServiceRegionStateImplCopyWithImpl<
        _$SelectServiceRegionStateImpl
      >(this, _$identity);
}

abstract class _SelectServiceRegionState implements SelectServiceRegionState {
  const factory _SelectServiceRegionState({
    final String? selectedCity,
    final String? selectedDistrict,
    final String? selectedTown,
    final List<String> districts,
    final List<Town> towns,
  }) = _$SelectServiceRegionStateImpl;

  @override
  String? get selectedCity;
  @override
  String? get selectedDistrict;
  @override
  String? get selectedTown;
  @override
  List<String> get districts;
  @override
  List<Town> get towns;

  /// Create a copy of SelectServiceRegionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectServiceRegionStateImplCopyWith<_$SelectServiceRegionStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
