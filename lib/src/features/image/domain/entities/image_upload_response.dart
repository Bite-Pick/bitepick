import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_upload_response.freezed.dart';
part 'image_upload_response.g.dart';

/// Presigned URL 응답 모델 (공통으로 사용)
@freezed
class PresignedUrlImage with _$PresignedUrlImage {
  const factory PresignedUrlImage({
    required String name,
    required String url,
  }) = _PresignedUrlImage;

  factory PresignedUrlImage.fromJson(Map<String, dynamic> json) =>
      _$PresignedUrlImageFromJson(json);
}
