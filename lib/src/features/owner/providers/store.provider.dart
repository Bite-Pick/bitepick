import 'package:magambell/src/features/home/domain/entities/goods.dart';
import 'package:magambell/src/features/store/domain/entities/store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'store.provider.g.dart';

@Riverpod(keepAlive: true)
class StoreState extends _$StoreState {
  @override
  Store? build() {
    // Mock data - API가 준비되면 실제 API 호출로 대체
    return Store(
      storeId: 'store-123',
      storeName: '맛있는 빵집',
      address: '서울시 강남구 테헤란로 123',
      storeImageUrls: [
        'https://d1xe26zpyg8fzv.cloudfront.net/STORE/OWNER/758244341543821802/1_b02.jpg',
        'https://d1xe26zpyg8fzv.cloudfront.net/STORE/OWNER/758244341543821802/2_b03.jpg',
      ],
      goodsList: [
        Goods(
          storeId: 'store-123',
          storeName: '맛있는 빵집',
          ImageUrl: [
            'https://d1xe26zpyg8fzv.cloudfront.net/STORE/OWNER/758244341543821802/1_b02.jpg',
          ],
          latitude: 37.5012,
          longitude: 127.0396,
          address: '서울시 강남구 테헤란로 123',
          goodsName: '크로와상',
          startTime: DateTime.now()
              .subtract(const Duration(hours: 1))
              .toIso8601String(),
          endTime: DateTime.now()
              .add(const Duration(hours: 5))
              .toIso8601String(),
          originPrice: 5000,
          discount: 30,
          salePrice: 3500,
          quantity: 15,
          distance: 0,
          saleStatus: 'ON',
        ),
      ],
    );
  }

  // 매장 정보 설정
  void setStore(Store store) {
    state = store;
  }

  // 매장 정보 초기화
  void clearStore() {
    state = null;
  }

  // 상품 추가
  void addGoods(Goods goods) {
    if (state == null) return;
    state = state!.copyWith(goodsList: [...state!.goodsList, goods]);
  }

  // 상품 수정
  void updateGoods(String goodsName, Goods updatedGoods) {
    if (state == null) return;
    final updatedList = state!.goodsList.map((goods) {
      return goods.goodsName == goodsName ? updatedGoods : goods;
    }).toList();
    state = state!.copyWith(goodsList: updatedList);
  }

  // 상품 삭제
  void removeGoods(String goodsName) {
    if (state == null) return;
    final updatedList = state!.goodsList
        .where((goods) => goods.goodsName != goodsName)
        .toList();
    state = state!.copyWith(goodsList: updatedList);
  }

  // 상품 재고 업데이트
  void updateStock(String goodsName, double newStock) {
    if (state == null) return;
    final updatedList = state!.goodsList.map((goods) {
      if (goods.goodsName == goodsName) {
        return goods.copyWith(quantity: newStock);
      }
      return goods;
    }).toList();
    state = state!.copyWith(goodsList: updatedList);
  }

  // 상품 판매 상태 변경
  void updateSaleStatus(String goodsName, String newStatus) {
    if (state == null) return;
    final updatedList = state!.goodsList.map((goods) {
      if (goods.goodsName == goodsName) {
        return goods.copyWith(saleStatus: newStatus);
      }
      return goods;
    }).toList();
    state = state!.copyWith(goodsList: updatedList);
  }
}
