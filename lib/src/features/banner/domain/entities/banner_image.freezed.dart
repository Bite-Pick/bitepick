// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'banner_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BannerImage _$BannerImageFromJson(Map<String, dynamic> json) {
  return _BannerImage.fromJson(json);
}

/// @nodoc
mixin _$BannerImage {
  int get bannerId => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  /// Serializes this BannerImage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BannerImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BannerImageCopyWith<BannerImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BannerImageCopyWith<$Res> {
  factory $BannerImageCopyWith(
    BannerImage value,
    $Res Function(BannerImage) then,
  ) = _$BannerImageCopyWithImpl<$Res, BannerImage>;
  @useResult
  $Res call({int bannerId, int id, String url});
}

/// @nodoc
class _$BannerImageCopyWithImpl<$Res, $Val extends BannerImage>
    implements $BannerImageCopyWith<$Res> {
  _$BannerImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BannerImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? bannerId = null, Object? id = null, Object? url = null}) {
    return _then(
      _value.copyWith(
            bannerId: null == bannerId
                ? _value.bannerId
                : bannerId // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$BannerImageImplCopyWith<$Res>
    implements $BannerImageCopyWith<$Res> {
  factory _$$BannerImageImplCopyWith(
    _$BannerImageImpl value,
    $Res Function(_$BannerImageImpl) then,
  ) = __$$BannerImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int bannerId, int id, String url});
}

/// @nodoc
class __$$BannerImageImplCopyWithImpl<$Res>
    extends _$BannerImageCopyWithImpl<$Res, _$BannerImageImpl>
    implements _$$BannerImageImplCopyWith<$Res> {
  __$$BannerImageImplCopyWithImpl(
    _$BannerImageImpl _value,
    $Res Function(_$BannerImageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BannerImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? bannerId = null, Object? id = null, Object? url = null}) {
    return _then(
      _$BannerImageImpl(
        bannerId: null == bannerId
            ? _value.bannerId
            : bannerId // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$BannerImageImpl implements _BannerImage {
  const _$BannerImageImpl({
    required this.bannerId,
    required this.id,
    required this.url,
  });

  factory _$BannerImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$BannerImageImplFromJson(json);

  @override
  final int bannerId;
  @override
  final int id;
  @override
  final String url;

  @override
  String toString() {
    return 'BannerImage(bannerId: $bannerId, id: $id, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BannerImageImpl &&
            (identical(other.bannerId, bannerId) ||
                other.bannerId == bannerId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, bannerId, id, url);

  /// Create a copy of BannerImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BannerImageImplCopyWith<_$BannerImageImpl> get copyWith =>
      __$$BannerImageImplCopyWithImpl<_$BannerImageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BannerImageImplToJson(this);
  }
}

abstract class _BannerImage implements BannerImage {
  const factory _BannerImage({
    required final int bannerId,
    required final int id,
    required final String url,
  }) = _$BannerImageImpl;

  factory _BannerImage.fromJson(Map<String, dynamic> json) =
      _$BannerImageImpl.fromJson;

  @override
  int get bannerId;
  @override
  int get id;
  @override
  String get url;

  /// Create a copy of BannerImage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BannerImageImplCopyWith<_$BannerImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
