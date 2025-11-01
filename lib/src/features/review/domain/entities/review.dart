import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.freezed.dart';
part 'review.g.dart';

@freezed
class Review with _$Review {
  const factory Review({
    required String reviewId,
    required int rating,
    required List<String> satisfactionReasons,
    required String description,
    required DateTime createdAt,
    required List<String> imageUrls,
    required String nickName,
    required String goodsId,
    required String storeId,
    required String storeName,
  }) = _Review;

  const Review._();
    factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}
