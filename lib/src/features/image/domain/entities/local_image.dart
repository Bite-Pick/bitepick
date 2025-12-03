import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_image.freezed.dart';

/// 로컬 이미지 파일 정보
@freezed
class LocalImage with _$LocalImage {
  const factory LocalImage({
    required int id,
    required String key,
    File? file, // 이미 업로드된 이미지의 경우 null일 수 있음
    String? uploadedUrl, // S3 업로드 완료 후 URL
  }) = _LocalImage;

  const LocalImage._();
}

int getId() => DateTime.now().microsecondsSinceEpoch;
String getFileName(File file) => file.path.split('/').last;
