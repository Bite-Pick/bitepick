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
  int get id => throw _privateConstructorUsedError;
  String get key =>
      throw _privateConstructorUsedError; // 이미지 파일명 (presigned URL 요청용)
  String get name => throw _privateConstructorUsedError; // 상품명
  File get file => throw _privateConstructorUsedError; // 로컬 이미지 파일
  String? get uploadedUrl => throw _privateConstructorUsedError;

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
  $Res call({int id, String key, String name, File file, String? uploadedUrl});
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
  $Res call({
    Object? id = null,
    Object? key = null,
    Object? name = null,
    Object? file = null,
    Object? uploadedUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            key: null == key
                ? _value.key
                : key // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            file: null == file
                ? _value.file
                : file // ignore: cast_nullable_to_non_nullable
                      as File,
            uploadedUrl: freezed == uploadedUrl
                ? _value.uploadedUrl
                : uploadedUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
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
  $Res call({int id, String key, String name, File file, String? uploadedUrl});
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
  $Res call({
    Object? id = null,
    Object? key = null,
    Object? name = null,
    Object? file = null,
    Object? uploadedUrl = freezed,
  }) {
    return _then(
      _$GoodsDetailItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        key: null == key
            ? _value.key
            : key // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        file: null == file
            ? _value.file
            : file // ignore: cast_nullable_to_non_nullable
                  as File,
        uploadedUrl: freezed == uploadedUrl
            ? _value.uploadedUrl
            : uploadedUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$GoodsDetailItemImpl implements _GoodsDetailItem {
  const _$GoodsDetailItemImpl({
    required this.id,
    required this.key,
    required this.name,
    required this.file,
    this.uploadedUrl,
  });

  @override
  final int id;
  @override
  final String key;
  // 이미지 파일명 (presigned URL 요청용)
  @override
  final String name;
  // 상품명
  @override
  final File file;
  // 로컬 이미지 파일
  @override
  final String? uploadedUrl;

  @override
  String toString() {
    return 'GoodsDetailItem(id: $id, key: $key, name: $name, file: $file, uploadedUrl: $uploadedUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoodsDetailItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.file, file) || other.file == file) &&
            (identical(other.uploadedUrl, uploadedUrl) ||
                other.uploadedUrl == uploadedUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, key, name, file, uploadedUrl);

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
    required final int id,
    required final String key,
    required final String name,
    required final File file,
    final String? uploadedUrl,
  }) = _$GoodsDetailItemImpl;

  @override
  int get id;
  @override
  String get key; // 이미지 파일명 (presigned URL 요청용)
  @override
  String get name; // 상품명
  @override
  File get file; // 로컬 이미지 파일
  @override
  String? get uploadedUrl;

  /// Create a copy of GoodsDetailItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoodsDetailItemImplCopyWith<_$GoodsDetailItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
