import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'goods_detail_item.freezed.dart';

/// 상품 상세 정보
@freezed
class GoodsDetailItem with _$GoodsDetailItem {
  const factory GoodsDetailItem({
    required int id,
    required String key, // 이미지 파일명 (presigned URL 요청용)
    required String name, // 상품명
    required File file, // 로컬 이미지 파일
    String? uploadedUrl, // S3 업로드 완료 후 URL
  }) = _GoodsDetailItem;
}
