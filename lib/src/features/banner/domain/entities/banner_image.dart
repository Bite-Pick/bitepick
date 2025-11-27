import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'banner_image.freezed.dart';
part 'banner_image.g.dart';

@freezed
class BannerImage with _$BannerImage {
  const factory BannerImage({
    required int bannerId,
    required int id,
    required String url,
  }) = _BannerImage;
  factory BannerImage.fromJson(Map<String, dynamic> json) => _$BannerImageFromJson(json);
}
