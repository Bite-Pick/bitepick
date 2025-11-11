import 'package:freezed_annotation/freezed_annotation.dart';

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
    double? latitude,
    double? longitude,
  }) = _StoreInfoUiData;
}
