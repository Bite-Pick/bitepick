// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigator_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MgDefaultNavigatorState {
  int get tabIndex => throw _privateConstructorUsedError;

  /// Create a copy of MgDefaultNavigatorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MgDefaultNavigatorStateCopyWith<MgDefaultNavigatorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MgDefaultNavigatorStateCopyWith<$Res> {
  factory $MgDefaultNavigatorStateCopyWith(
    MgDefaultNavigatorState value,
    $Res Function(MgDefaultNavigatorState) then,
  ) = _$MgDefaultNavigatorStateCopyWithImpl<$Res, MgDefaultNavigatorState>;
  @useResult
  $Res call({int tabIndex});
}

/// @nodoc
class _$MgDefaultNavigatorStateCopyWithImpl<
  $Res,
  $Val extends MgDefaultNavigatorState
>
    implements $MgDefaultNavigatorStateCopyWith<$Res> {
  _$MgDefaultNavigatorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MgDefaultNavigatorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tabIndex = null}) {
    return _then(
      _value.copyWith(
            tabIndex: null == tabIndex
                ? _value.tabIndex
                : tabIndex // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MgDefaultNavigatorStateImplCopyWith<$Res>
    implements $MgDefaultNavigatorStateCopyWith<$Res> {
  factory _$$MgDefaultNavigatorStateImplCopyWith(
    _$MgDefaultNavigatorStateImpl value,
    $Res Function(_$MgDefaultNavigatorStateImpl) then,
  ) = __$$MgDefaultNavigatorStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int tabIndex});
}

/// @nodoc
class __$$MgDefaultNavigatorStateImplCopyWithImpl<$Res>
    extends
        _$MgDefaultNavigatorStateCopyWithImpl<
          $Res,
          _$MgDefaultNavigatorStateImpl
        >
    implements _$$MgDefaultNavigatorStateImplCopyWith<$Res> {
  __$$MgDefaultNavigatorStateImplCopyWithImpl(
    _$MgDefaultNavigatorStateImpl _value,
    $Res Function(_$MgDefaultNavigatorStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MgDefaultNavigatorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tabIndex = null}) {
    return _then(
      _$MgDefaultNavigatorStateImpl(
        tabIndex: null == tabIndex
            ? _value.tabIndex
            : tabIndex // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$MgDefaultNavigatorStateImpl implements _MgDefaultNavigatorState {
  _$MgDefaultNavigatorStateImpl({required this.tabIndex});

  @override
  final int tabIndex;

  @override
  String toString() {
    return 'MgDefaultNavigatorState(tabIndex: $tabIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MgDefaultNavigatorStateImpl &&
            (identical(other.tabIndex, tabIndex) ||
                other.tabIndex == tabIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tabIndex);

  /// Create a copy of MgDefaultNavigatorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MgDefaultNavigatorStateImplCopyWith<_$MgDefaultNavigatorStateImpl>
  get copyWith =>
      __$$MgDefaultNavigatorStateImplCopyWithImpl<
        _$MgDefaultNavigatorStateImpl
      >(this, _$identity);
}

abstract class _MgDefaultNavigatorState implements MgDefaultNavigatorState {
  factory _MgDefaultNavigatorState({required final int tabIndex}) =
      _$MgDefaultNavigatorStateImpl;

  @override
  int get tabIndex;

  /// Create a copy of MgDefaultNavigatorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MgDefaultNavigatorStateImplCopyWith<_$MgDefaultNavigatorStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
