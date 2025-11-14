import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/features/goods/domain/entities/goods.dart';
import 'package:magambell/src/features/store/domain/entities/store_info_ui_data.dart';

part 'store.freezed.dart';
part 'store.g.dart';

@freezed
class Store with _$Store {
  const factory Store({
    required String storeId,
    required String storeName,
    required String address,
    required List<String> storeImageUrls,
    required List<Goods> goodsList,
  }) = _Store;
  const Store._();

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

  StoreInfoUiData toStoreInfoData() {
    // For a store, we might display info from the first available goods item
    final firstGoods = goodsList.isNotEmpty ? goodsList.first : null;
    return StoreInfoUiData(
      storeId: storeId,
      storeName: storeName,
      address: address,
      imageUrls: storeImageUrls,
      latitude: firstGoods?.latitude,
      longitude: firstGoods?.longitude,
      stockQuantity: firstGoods?.stockQuantity ?? 0,
      saleStatus: firstGoods?.saleStatus ?? "OFF",
      discount: firstGoods?.discount ?? 0,
      salePrice: firstGoods?.salePrice ?? 0,
      originPrice: firstGoods?.originPrice ?? 0,
      startTime: firstGoods?.startTime ?? "",
      endTime: firstGoods?.endTime ?? "",
      description: firstGoods?.description ?? "",
    );
  }
}

final mockStore = Store(
  storeId: "store-001",
  storeName: "마감벨 테스트 가게",
  address: "서울시 강남구 테헤란로 123",
  storeImageUrls: [
    "https://d1xe26zpyg8fzv.cloudfront.net/STORE/OWNER/758244341543821802/1_b02.jpg",
    "https://d1xe26zpyg8fzv.cloudfront.net/STORE/OWNER/758244341543821802/2_b03.jpg",
    "https://d1xe26zpyg8fzv.cloudfront.net/STORE/OWNER/758244341543821802/3_bakery01.jpeg",
  ],
  goodsList: [
    Goods(
      storeId: 'test',
      goodsId: "store-001",
      storeName: "마감벨 테스트 가게",
      ImageUrl: [
        "https://d1xe26zpyg8fzv.cloudfront.net/STORE/OWNER/758244341543821802/1_b02.jpg",
      ],
      latitude: 37.5012743,
      longitude: 127.0396597,
      address: "서울시 강남구 테헤란로 123",
      goodsName: "베이커리 바이트백",
      startTime: "2025-11-10T18:00:00.000Z",
      endTime: "2025-11-10T20:00:00.000Z",
      originPrice: 15000,
      discount: 30,
      salePrice: 10500,
      stockQuantity: 5,
      distance: 0,
      saleStatus: "ON",
    ),
    Goods(
      storeId: "",
      goodsId: "store-001",
      storeName: "마감벨 테스트 가게",
      ImageUrl: [
        "https://d1xe26zpyg8fzv.cloudfront.net/STORE/OWNER/758244341543821802/2_b03.jpg",
      ],
      latitude: 37.5012743,
      longitude: 127.0396597,
      address: "서울시 강남구 테헤란로 123",
      goodsName: "샐러드 바이트백",
      startTime: "2025-11-10T17:00:00.000Z",
      endTime: "2025-11-10T19:00:00.000Z",
      originPrice: 12000,
      discount: 40,
      salePrice: 7200,
      stockQuantity: 3,
      distance: 0,
      saleStatus: "ON",
    ),
  ],
);
