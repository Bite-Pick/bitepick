import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageRequester {
  factory ImageRequester() => _singleton;
  ImageRequester._internal();
  static final ImageRequester _singleton = ImageRequester._internal();

  /// 갤러리에서 단일 이미지 선택
  Future<File?> pickFileFromGallery({
    int quality = 85,
    double maxWidth = 1920,
    double maxHeight = 1920,
  }) async {
    final pickedFile = await _getPickedFileResized(
      ImageSource.gallery,
      quality: quality,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
    );

    return pickedFile;
  }

  /// 갤러리에서 여러 이미지 선택
  Future<List<File>> pickMultipleFilesFromGallery({
    int quality = 85,
    double maxWidth = 1920,
    double maxHeight = 1920,
  }) async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage(
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: quality,
    );

    if (pickedFiles.isEmpty) return [];

    return pickedFiles.map((xFile) => File(xFile.path)).toList();
  }

  /// 이미지 선택 및 리사이즈
  Future<File?> _getPickedFileResized(
    ImageSource source, {
    required int quality,
    required double maxWidth,
    required double maxHeight,
  }) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      imageQuality: quality,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
    );

    if (pickedFile == null) return null;

    return File(pickedFile.path);
  }
}
