import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/features/image/domain/entities/local_image.dart';

part 'goods_detail_item.freezed.dart';

/// 상품 상세 정보
@freezed
class GoodsDetailItem with _$GoodsDetailItem {
  const factory GoodsDetailItem({
    required LocalImage localImage,
    required String name, // 상품명
  }) = _GoodsDetailItem;
}
