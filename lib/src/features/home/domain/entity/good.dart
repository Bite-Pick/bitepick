import 'package:freezed_annotation/freezed_annotation.dart';

part 'good.freezed.dart';

@freezed
class Good with _$Good {
  const factory Good({
    required String storeId,
    required String storeName,
    required List<String> imageUrl,
    required double latitude,
    required double longitude,
    required double address,
    required double goodsName,
    required String startTime,
    required String endTime,
    required int originPrice,
    required double discount,
    required double salePrice,
    required double quantity,
    required double distance,
    required double saleStatus,
  }) = _Good;
}
