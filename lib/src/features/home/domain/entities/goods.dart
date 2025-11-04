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

final mockStore = Goods(
  storeId: "758244809439404511",
  storeName: "라스트오븐",
  ImageUrl: [
    "https://d1xe26zpyg8fzv.cloudfront.net/STORE/OWNER/758244341543821802/1_b02.jpg",
    "https://d1xe26zpyg8fzv.cloudfront.net/STORE/OWNER/758244341543821802/2_b03.jpg",
    "https://d1xe26zpyg8fzv.cloudfront.net/STORE/OWNER/758244341543821802/3_bakery01.jpeg",
  ],
  latitude: 37.5185663,
  longitude: 127.0230599,
  address: "서울 강남구 가로수길 9",
  goodsName: "바이트박스",
  startTime: "2025-09-24T12:00:00",
  endTime: "2025-09-24T19:00:00",
  originPrice: 14000,
  discount: 40,
  salePrice: 8300,
  quantity: 2,
  distance: 2,
  saleStatus: "ON",
);
