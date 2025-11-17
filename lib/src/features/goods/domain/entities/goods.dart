import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/features/store/domain/entities/store_info_ui_data.dart';

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

  StoreInfoUiData toStoreInfoData() {
    return StoreInfoUiData(
      storeId: storeId ?? '',
      storeName: storeName ?? '',
      address: address ?? '',
      imageUrls: ImageUrl ?? [],
      latitude: latitude,
      longitude: longitude,
      stockQuantity: stockQuantity,
      saleStatus: saleStatus,
      discount: discount,
      salePrice: salePrice,
      originPrice: originPrice,
      startTime: startTime,
      endTime: endTime,
      description: description ?? "",
    );
  }
}

final mockGoods = Goods(
  goodsId: "1",
  storeName: "test",
  storeId: "test",
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
  stockQuantity: 0,
  distance: 0,
  saleStatus: "ON",
);
