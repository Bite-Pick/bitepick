import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/features/goods/domain/entities/goods.dart';

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

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
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
      storeId: "store-001",
      storeName: "마감벨 테스트 가게",
      ImageUrl: [
        "https://d1xe26zpyg8fzv.cloudfront.net/STORE/OWNER/758244341543821802/1_b02.jpg",
      ],
      latitude: 37.5012743,
      longitude: 127.0396597,
      address: "서울시 강남구 테헤란로 123",
      goodsName: "베이커리 마감백",
      startTime: "2025-11-10T18:00:00.000Z",
      endTime: "2025-11-10T20:00:00.000Z",
      originPrice: 15000,
      discount: 30,
      salePrice: 10500,
      quantity: 5,
      distance: 0,
      saleStatus: "ON",
    ),
    Goods(
      storeId: "store-001",
      storeName: "마감벨 테스트 가게",
      ImageUrl: [
        "https://d1xe26zpyg8fzv.cloudfront.net/STORE/OWNER/758244341543821802/2_b03.jpg",
      ],
      latitude: 37.5012743,
      longitude: 127.0396597,
      address: "서울시 강남구 테헤란로 123",
      goodsName: "샐러드 마감백",
      startTime: "2025-11-10T17:00:00.000Z",
      endTime: "2025-11-10T19:00:00.000Z",
      originPrice: 12000,
      discount: 40,
      salePrice: 7200,
      quantity: 3,
      distance: 0,
      saleStatus: "ON",
    ),
  ],
);
