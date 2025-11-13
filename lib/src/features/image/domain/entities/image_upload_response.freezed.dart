// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_upload_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PresignedUrlImage _$PresignedUrlImageFromJson(Map<String, dynamic> json) {
  return _PresignedUrlImage.fromJson(json);
}

/// @nodoc
mixin _$PresignedUrlImage {
  int get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  /// Serializes this PresignedUrlImage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PresignedUrlImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PresignedUrlImageCopyWith<PresignedUrlImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresignedUrlImageCopyWith<$Res> {
  factory $PresignedUrlImageCopyWith(
    PresignedUrlImage value,
    $Res Function(PresignedUrlImage) then,
  ) = _$PresignedUrlImageCopyWithImpl<$Res, PresignedUrlImage>;
  @useResult
  $Res call({int id, String url});
}

/// @nodoc
class _$PresignedUrlImageCopyWithImpl<$Res, $Val extends PresignedUrlImage>
    implements $PresignedUrlImageCopyWith<$Res> {
  _$PresignedUrlImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PresignedUrlImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? url = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PresignedUrlImageImplCopyWith<$Res>
    implements $PresignedUrlImageCopyWith<$Res> {
  factory _$$PresignedUrlImageImplCopyWith(
    _$PresignedUrlImageImpl value,
    $Res Function(_$PresignedUrlImageImpl) then,
  ) = __$$PresignedUrlImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String url});
}

/// @nodoc
class __$$PresignedUrlImageImplCopyWithImpl<$Res>
    extends _$PresignedUrlImageCopyWithImpl<$Res, _$PresignedUrlImageImpl>
    implements _$$PresignedUrlImageImplCopyWith<$Res> {
  __$$PresignedUrlImageImplCopyWithImpl(
    _$PresignedUrlImageImpl _value,
    $Res Function(_$PresignedUrlImageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PresignedUrlImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? url = null}) {
    return _then(
      _$PresignedUrlImageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PresignedUrlImageImpl implements _PresignedUrlImage {
  const _$PresignedUrlImageImpl({required this.id, required this.url});

  factory _$PresignedUrlImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$PresignedUrlImageImplFromJson(json);

  @override
  final int id;
  @override
  final String url;

  @override
  String toString() {
    return 'PresignedUrlImage(id: $id, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresignedUrlImageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, url);

  /// Create a copy of PresignedUrlImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PresignedUrlImageImplCopyWith<_$PresignedUrlImageImpl> get copyWith =>
      __$$PresignedUrlImageImplCopyWithImpl<_$PresignedUrlImageImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PresignedUrlImageImplToJson(this);
  }
}

abstract class _PresignedUrlImage implements PresignedUrlImage {
  const factory _PresignedUrlImage({
    required final int id,
    required final String url,
  }) = _$PresignedUrlImageImpl;

  factory _PresignedUrlImage.fromJson(Map<String, dynamic> json) =
      _$PresignedUrlImageImpl.fromJson;

  @override
  int get id;
  @override
  String get url;

  /// Create a copy of PresignedUrlImage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PresignedUrlImageImplCopyWith<_$PresignedUrlImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
