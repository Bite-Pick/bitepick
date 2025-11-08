import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_meta_data.freezed.dart';
part 'image_meta_data.g.dart';

@freezed
class ImageMetadata with _$ImageMetadata {
  const factory ImageMetadata({
    required int id,
    required String key,
  }) = _ImageMetadata;

  factory ImageMetadata.fromJson(Map<String, dynamic> json) =>
      _$ImageMetadataFromJson(json);
}
