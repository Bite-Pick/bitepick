import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_goods_item_data.freezed.dart';

// TODO: refact ui data는 어디 레이어 위치 시켜야할지?
@freezed
class HomeGoodsItemData with _$HomeGoodsItemData {
  const factory HomeGoodsItemData({
    required String storeId,
    required String storeName,
    required List<String> imageUrl,
    required int discount,
    required int salePrice,
    required String startTime,
    required String endTime,
    required double distance,
    required int quantity,
    required String saleStatus,
  }) = _HomeGoodsItemData;

  const HomeGoodsItemData._();

  
}
