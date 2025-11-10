import 'package:freezed_annotation/freezed_annotation.dart';

part 'goods.freezed.dart';
part 'goods.g.dart';

@freezed
class Goods with _$Goods {
  const factory Goods({
    required String storeId,
    required String storeName,
    required List<String> ImageUrl,
    required double latitude,
    required double longitude,
    required String address,
    String? goodsName,
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

final mockGoods = Goods(
  storeId: "1",
  storeName: "test",
  ImageUrl: [
    "https://d1xe26zpyg8fzv.cloudfront.net/STORE/OWNER/758244341543821802/1_b02.jpg",
    "https://d1xe26zpyg8fzv.cloudfront.net/STORE/OWNER/758244341543821802/2_b03.jpg",
    "https://d1xe26zpyg8fzv.cloudfront.net/STORE/OWNER/758244341543821802/3_bakery01.jpeg",
  ],
  latitude: 0,
  longitude: 0,
  address: "dd",
  goodsName: "dd",
  startTime: "2025-10-12T00:40:57.096Z",
  endTime: "2025-10-12T00:40:57.096Z",
  originPrice: 5800,
  discount: 10,
  salePrice: 5220,
  quantity: 0,
  distance: 0,
  saleStatus: "ON",
);
