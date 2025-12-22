// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_service_area_screen.controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SelectServiceAreaState {
  String? get selectedCity => throw _privateConstructorUsedError;
  String? get selectedDistrict => throw _privateConstructorUsedError;
  String? get selectedTown => throw _privateConstructorUsedError;
  List<String> get districts => throw _privateConstructorUsedError;
  List<String> get towns => throw _privateConstructorUsedError;

  /// Create a copy of SelectServiceAreaState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelectServiceAreaStateCopyWith<SelectServiceAreaState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectServiceAreaStateCopyWith<$Res> {
  factory $SelectServiceAreaStateCopyWith(
    SelectServiceAreaState value,
    $Res Function(SelectServiceAreaState) then,
  ) = _$SelectServiceAreaStateCopyWithImpl<$Res, SelectServiceAreaState>;
  @useResult
  $Res call({
    String? selectedCity,
    String? selectedDistrict,
    String? selectedTown,
    List<String> districts,
    List<String> towns,
  });
}

/// @nodoc
class _$SelectServiceAreaStateCopyWithImpl<
  $Res,
  $Val extends SelectServiceAreaState
>
    implements $SelectServiceAreaStateCopyWith<$Res> {
  _$SelectServiceAreaStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectServiceAreaState
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
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SelectServiceAreaStateImplCopyWith<$Res>
    implements $SelectServiceAreaStateCopyWith<$Res> {
  factory _$$SelectServiceAreaStateImplCopyWith(
    _$SelectServiceAreaStateImpl value,
    $Res Function(_$SelectServiceAreaStateImpl) then,
  ) = __$$SelectServiceAreaStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? selectedCity,
    String? selectedDistrict,
    String? selectedTown,
    List<String> districts,
    List<String> towns,
  });
}

/// @nodoc
class __$$SelectServiceAreaStateImplCopyWithImpl<$Res>
    extends
        _$SelectServiceAreaStateCopyWithImpl<$Res, _$SelectServiceAreaStateImpl>
    implements _$$SelectServiceAreaStateImplCopyWith<$Res> {
  __$$SelectServiceAreaStateImplCopyWithImpl(
    _$SelectServiceAreaStateImpl _value,
    $Res Function(_$SelectServiceAreaStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SelectServiceAreaState
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
      _$SelectServiceAreaStateImpl(
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
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$SelectServiceAreaStateImpl implements _SelectServiceAreaState {
  const _$SelectServiceAreaStateImpl({
    this.selectedCity,
    this.selectedDistrict,
    this.selectedTown,
    final List<String> districts = const [],
    final List<String> towns = const [],
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

  final List<String> _towns;
  @override
  @JsonKey()
  List<String> get towns {
    if (_towns is EqualUnmodifiableListView) return _towns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_towns);
  }

  @override
  String toString() {
    return 'SelectServiceAreaState(selectedCity: $selectedCity, selectedDistrict: $selectedDistrict, selectedTown: $selectedTown, districts: $districts, towns: $towns)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectServiceAreaStateImpl &&
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

  /// Create a copy of SelectServiceAreaState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectServiceAreaStateImplCopyWith<_$SelectServiceAreaStateImpl>
  get copyWith =>
      __$$SelectServiceAreaStateImplCopyWithImpl<_$SelectServiceAreaStateImpl>(
        this,
        _$identity,
      );
}

abstract class _SelectServiceAreaState implements SelectServiceAreaState {
  const factory _SelectServiceAreaState({
    final String? selectedCity,
    final String? selectedDistrict,
    final String? selectedTown,
    final List<String> districts,
    final List<String> towns,
  }) = _$SelectServiceAreaStateImpl;

  @override
  String? get selectedCity;
  @override
  String? get selectedDistrict;
  @override
  String? get selectedTown;
  @override
  List<String> get districts;
  @override
  List<String> get towns;

  /// Create a copy of SelectServiceAreaState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectServiceAreaStateImplCopyWith<_$SelectServiceAreaStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
