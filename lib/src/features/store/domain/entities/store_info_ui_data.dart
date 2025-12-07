import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/features/goods/domain/entities/goods.dart';

part 'store_info_ui_data.freezed.dart';

@freezed
class StoreInfoUiData with _$StoreInfoUiData {
  const factory StoreInfoUiData({
    required String storeId,
    required String storeName,
    required String address,
    required List<String> imageUrls,
    required int stockQuantity,
    required String saleStatus,
    required int discount,
    required int salePrice,
    required int originPrice,
    required String startTime,
    required String endTime,
    required String description,
    String? parkingDescription, // TODO: parkingDescription 확인필요
    List<GoodsImagesList>? goodsImageList, // TODO: goodsImageList 확인필요
    double? latitude,
    double? longitude,
  }) = _StoreInfoUiData;
}
