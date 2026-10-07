import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_review.freezed.dart';
part 'store_review.g.dart';

@freezed
class StoreReviewSummary with _$StoreReviewSummary {
  const factory StoreReviewSummary({
    @JsonKey(defaultValue: 0.0) required double averageRating,
    @JsonKey(defaultValue: 0) required int totalCount,
    @JsonKey(defaultValue: 0) required int noReplyCount,
  }) = _StoreReviewSummary;

  factory StoreReviewSummary.fromJson(Map<String, dynamic> json) => 
      _$StoreReviewSummaryFromJson(json);
}

@freezed
class StoreReviewReply with _$StoreReviewReply {
  const factory StoreReviewReply({
    required String replyId,
    required String content,
    required DateTime createdAt,
  }) = _StoreReviewReply;

  factory StoreReviewReply.fromJson(Map<String, dynamic> json) => 
      _$StoreReviewReplyFromJson(json);
}

@freezed
class StoreReviewItem with _$StoreReviewItem {
  const factory StoreReviewItem({
    required String reviewId,
    required int rating,
    required String description,
    required List<String> imageUrls,
    required String nickName,
    required DateTime orderedAt,
    required DateTime createdAt,
    required String productName,
    StoreReviewReply? reply,
  }) = _StoreReviewItem;

  factory StoreReviewItem.fromJson(Map<String, dynamic> json) =>
      _$StoreReviewItemFromJson(json);
}

@freezed
class StoreReviewListResponse with _$StoreReviewListResponse {
  const factory StoreReviewListResponse({
    required StoreReviewSummary summary,
    required List<StoreReviewItem> items,
    @JsonKey(defaultValue: 0) required int nextCursor,
    required bool hasNext,
  }) = _StoreReviewListResponse;

  factory StoreReviewListResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreReviewListResponseFromJson(json);
}