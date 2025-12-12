import 'package:freezed_annotation/freezed_annotation.dart';

part 'goods.freezed.dart';
part 'goods.g.dart';

@freezed
class Goods with _$Goods {
  const factory Goods({
    String? goodsId,
    String? storeId,
    String? storeName,
    String? goodsName,
    List<String>? ImageUrl,
    double? latitude,
    double? longitude,
    double? distance,
    String? address,
    String? description,
    required String startTime,
    required String endTime,
    required int originPrice,
    required int discount,
    required int salePrice,
    required int stockQuantity,
    required String saleStatus,
  }) = _Goods;
  const Goods._();

  factory Goods.fromJson(Map<String, dynamic> json) => _$GoodsFromJson(json);
}


// TODO: GoodsImagesList 파일 분리 필요
// TODO: 현재 Null로 들어간값들이 있어 임시처리, required로 타입 강제 필요
@freezed
class GoodsImagesList with _$GoodsImagesList {
  const factory GoodsImagesList({
    int? id,
    String? goodsName,
    String? imageUrl,
    String? key,
  }) = _GoodsImagesList;
  const GoodsImagesList._();

  factory GoodsImagesList.fromJson(Map<String, dynamic> json) =>
      _$GoodsImagesListFromJson(json);
}
