import 'package:freezed_annotation/freezed_annotation.dart';

part 'goods.freezed.dart';
part 'goods.g.dart';

@freezed
class Goods with _$Goods {
  const factory Goods({
    required String storeId,
    required String storeName,
    required List<String> imageUrl,
    required double latitude,
    required double longitude,
    required String address,
    required String goodsName,
    required String startTime,
    required String endTime,
    required int originPrice,
    required double discount,
    required double salePrice,
    required double quantity,
    required double distance,
    required String saleStatus,
  }) = _Goods;
  const Goods._();

  factory Goods.fromJson(Map<String, dynamic> json) => _$GoodsFromJson(json);
}

final mockData = Goods(
  storeId: "1",
  storeName: "test",
  imageUrl: ["", "", "", ""],
  latitude: 0,
  longitude: 0,
  address: "dd",
  goodsName: "dd",
  startTime: "2025-10-12T00:40:57.096Z",
  endTime: "2025-10-12T00:40:57.096Z",
  originPrice: 0,
  discount: 0,
  salePrice: 0,
  quantity: 0,
  distance: 0,
  saleStatus: "ON",
);
