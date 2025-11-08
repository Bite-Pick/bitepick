// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$LocalImage {
  int get id => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;
  File get file => throw _privateConstructorUsedError;
  String? get uploadedUrl => throw _privateConstructorUsedError;

  /// Create a copy of LocalImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocalImageCopyWith<LocalImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalImageCopyWith<$Res> {
  factory $LocalImageCopyWith(
    LocalImage value,
    $Res Function(LocalImage) then,
  ) = _$LocalImageCopyWithImpl<$Res, LocalImage>;
  @useResult
  $Res call({int id, String key, File file, String? uploadedUrl});
}

/// @nodoc
class _$LocalImageCopyWithImpl<$Res, $Val extends LocalImage>
    implements $LocalImageCopyWith<$Res> {
  _$LocalImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocalImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? key = null,
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
abstract class _$$LocalImageImplCopyWith<$Res>
    implements $LocalImageCopyWith<$Res> {
  factory _$$LocalImageImplCopyWith(
    _$LocalImageImpl value,
    $Res Function(_$LocalImageImpl) then,
  ) = __$$LocalImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String key, File file, String? uploadedUrl});
}

/// @nodoc
class __$$LocalImageImplCopyWithImpl<$Res>
    extends _$LocalImageCopyWithImpl<$Res, _$LocalImageImpl>
    implements _$$LocalImageImplCopyWith<$Res> {
  __$$LocalImageImplCopyWithImpl(
    _$LocalImageImpl _value,
    $Res Function(_$LocalImageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocalImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? key = null,
    Object? file = null,
    Object? uploadedUrl = freezed,
  }) {
    return _then(
      _$LocalImageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        key: null == key
            ? _value.key
            : key // ignore: cast_nullable_to_non_nullable
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

class _$LocalImageImpl implements _LocalImage {
  const _$LocalImageImpl({
    required this.id,
    required this.key,
    required this.file,
    this.uploadedUrl,
  });

  @override
  final int id;
  @override
  final String key;
  @override
  final File file;
  @override
  final String? uploadedUrl;

  @override
  String toString() {
    return 'LocalImage(id: $id, key: $key, file: $file, uploadedUrl: $uploadedUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalImageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.file, file) || other.file == file) &&
            (identical(other.uploadedUrl, uploadedUrl) ||
                other.uploadedUrl == uploadedUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, key, file, uploadedUrl);

  /// Create a copy of LocalImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalImageImplCopyWith<_$LocalImageImpl> get copyWith =>
      __$$LocalImageImplCopyWithImpl<_$LocalImageImpl>(this, _$identity);
}

abstract class _LocalImage implements LocalImage {
  const factory _LocalImage({
    required final int id,
    required final String key,
    required final File file,
    final String? uploadedUrl,
  }) = _$LocalImageImpl;

  @override
  int get id;
  @override
  String get key;
  @override
  File get file;
  @override
  String? get uploadedUrl;

  /// Create a copy of LocalImage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocalImageImplCopyWith<_$LocalImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
