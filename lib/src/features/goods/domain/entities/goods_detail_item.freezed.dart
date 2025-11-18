// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goods_detail_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GoodsDetailItem {
  LocalImage get localImage => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Create a copy of GoodsDetailItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoodsDetailItemCopyWith<GoodsDetailItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoodsDetailItemCopyWith<$Res> {
  factory $GoodsDetailItemCopyWith(
    GoodsDetailItem value,
    $Res Function(GoodsDetailItem) then,
  ) = _$GoodsDetailItemCopyWithImpl<$Res, GoodsDetailItem>;
  @useResult
  $Res call({LocalImage localImage, String name});

  $LocalImageCopyWith<$Res> get localImage;
}

/// @nodoc
class _$GoodsDetailItemCopyWithImpl<$Res, $Val extends GoodsDetailItem>
    implements $GoodsDetailItemCopyWith<$Res> {
  _$GoodsDetailItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GoodsDetailItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? localImage = null, Object? name = null}) {
    return _then(
      _value.copyWith(
            localImage: null == localImage
                ? _value.localImage
                : localImage // ignore: cast_nullable_to_non_nullable
                      as LocalImage,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of GoodsDetailItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocalImageCopyWith<$Res> get localImage {
    return $LocalImageCopyWith<$Res>(_value.localImage, (value) {
      return _then(_value.copyWith(localImage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GoodsDetailItemImplCopyWith<$Res>
    implements $GoodsDetailItemCopyWith<$Res> {
  factory _$$GoodsDetailItemImplCopyWith(
    _$GoodsDetailItemImpl value,
    $Res Function(_$GoodsDetailItemImpl) then,
  ) = __$$GoodsDetailItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LocalImage localImage, String name});

  @override
  $LocalImageCopyWith<$Res> get localImage;
}

/// @nodoc
class __$$GoodsDetailItemImplCopyWithImpl<$Res>
    extends _$GoodsDetailItemCopyWithImpl<$Res, _$GoodsDetailItemImpl>
    implements _$$GoodsDetailItemImplCopyWith<$Res> {
  __$$GoodsDetailItemImplCopyWithImpl(
    _$GoodsDetailItemImpl _value,
    $Res Function(_$GoodsDetailItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GoodsDetailItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? localImage = null, Object? name = null}) {
    return _then(
      _$GoodsDetailItemImpl(
        localImage: null == localImage
            ? _value.localImage
            : localImage // ignore: cast_nullable_to_non_nullable
                  as LocalImage,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$GoodsDetailItemImpl implements _GoodsDetailItem {
  const _$GoodsDetailItemImpl({required this.localImage, required this.name});

  @override
  final LocalImage localImage;
  @override
  final String name;

  @override
  String toString() {
    return 'GoodsDetailItem(localImage: $localImage, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoodsDetailItemImpl &&
            (identical(other.localImage, localImage) ||
                other.localImage == localImage) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, localImage, name);

  /// Create a copy of GoodsDetailItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoodsDetailItemImplCopyWith<_$GoodsDetailItemImpl> get copyWith =>
      __$$GoodsDetailItemImplCopyWithImpl<_$GoodsDetailItemImpl>(
        this,
        _$identity,
      );
}

abstract class _GoodsDetailItem implements GoodsDetailItem {
  const factory _GoodsDetailItem({
    required final LocalImage localImage,
    required final String name,
  }) = _$GoodsDetailItemImpl;

  @override
  LocalImage get localImage;
  @override
  String get name;

  /// Create a copy of GoodsDetailItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoodsDetailItemImplCopyWith<_$GoodsDetailItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
