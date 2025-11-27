// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'banner_list_screen.controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BannerListScreenControllerState {
  bool get isProgress => throw _privateConstructorUsedError;
  int? get uploadingId => throw _privateConstructorUsedError;

  /// Create a copy of BannerListScreenControllerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BannerListScreenControllerStateCopyWith<BannerListScreenControllerState>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BannerListScreenControllerStateCopyWith<$Res> {
  factory $BannerListScreenControllerStateCopyWith(
    BannerListScreenControllerState value,
    $Res Function(BannerListScreenControllerState) then,
  ) =
      _$BannerListScreenControllerStateCopyWithImpl<
        $Res,
        BannerListScreenControllerState
      >;
  @useResult
  $Res call({bool isProgress, int? uploadingId});
}

/// @nodoc
class _$BannerListScreenControllerStateCopyWithImpl<
  $Res,
  $Val extends BannerListScreenControllerState
>
    implements $BannerListScreenControllerStateCopyWith<$Res> {
  _$BannerListScreenControllerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BannerListScreenControllerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isProgress = null, Object? uploadingId = freezed}) {
    return _then(
      _value.copyWith(
            isProgress: null == isProgress
                ? _value.isProgress
                : isProgress // ignore: cast_nullable_to_non_nullable
                      as bool,
            uploadingId: freezed == uploadingId
                ? _value.uploadingId
                : uploadingId // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BannerListScreenControllerStateImplCopyWith<$Res>
    implements $BannerListScreenControllerStateCopyWith<$Res> {
  factory _$$BannerListScreenControllerStateImplCopyWith(
    _$BannerListScreenControllerStateImpl value,
    $Res Function(_$BannerListScreenControllerStateImpl) then,
  ) = __$$BannerListScreenControllerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isProgress, int? uploadingId});
}

/// @nodoc
class __$$BannerListScreenControllerStateImplCopyWithImpl<$Res>
    extends
        _$BannerListScreenControllerStateCopyWithImpl<
          $Res,
          _$BannerListScreenControllerStateImpl
        >
    implements _$$BannerListScreenControllerStateImplCopyWith<$Res> {
  __$$BannerListScreenControllerStateImplCopyWithImpl(
    _$BannerListScreenControllerStateImpl _value,
    $Res Function(_$BannerListScreenControllerStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BannerListScreenControllerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isProgress = null, Object? uploadingId = freezed}) {
    return _then(
      _$BannerListScreenControllerStateImpl(
        isProgress: null == isProgress
            ? _value.isProgress
            : isProgress // ignore: cast_nullable_to_non_nullable
                  as bool,
        uploadingId: freezed == uploadingId
            ? _value.uploadingId
            : uploadingId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$BannerListScreenControllerStateImpl
    with DiagnosticableTreeMixin
    implements _BannerListScreenControllerState {
  const _$BannerListScreenControllerStateImpl({
    required this.isProgress,
    this.uploadingId,
  });

  @override
  final bool isProgress;
  @override
  final int? uploadingId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BannerListScreenControllerState(isProgress: $isProgress, uploadingId: $uploadingId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BannerListScreenControllerState'))
      ..add(DiagnosticsProperty('isProgress', isProgress))
      ..add(DiagnosticsProperty('uploadingId', uploadingId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BannerListScreenControllerStateImpl &&
            (identical(other.isProgress, isProgress) ||
                other.isProgress == isProgress) &&
            (identical(other.uploadingId, uploadingId) ||
                other.uploadingId == uploadingId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isProgress, uploadingId);

  /// Create a copy of BannerListScreenControllerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BannerListScreenControllerStateImplCopyWith<
    _$BannerListScreenControllerStateImpl
  >
  get copyWith =>
      __$$BannerListScreenControllerStateImplCopyWithImpl<
        _$BannerListScreenControllerStateImpl
      >(this, _$identity);
}

abstract class _BannerListScreenControllerState
    implements BannerListScreenControllerState {
  const factory _BannerListScreenControllerState({
    required final bool isProgress,
    final int? uploadingId,
  }) = _$BannerListScreenControllerStateImpl;

  @override
  bool get isProgress;
  @override
  int? get uploadingId;

  /// Create a copy of BannerListScreenControllerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BannerListScreenControllerStateImplCopyWith<
    _$BannerListScreenControllerStateImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
