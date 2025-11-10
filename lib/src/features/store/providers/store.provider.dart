import 'package:magambell/src/features/goods/domain/entities/goods.dart';
import 'package:magambell/src/features/store/domain/entities/store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'store.provider.g.dart';

@Riverpod(keepAlive: true)
class StoreState extends _$StoreState {
  @override
  Store? build() {
    // Mock data - API가 준비되면 실제 API 호출로 대체
    return mockStore;
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
