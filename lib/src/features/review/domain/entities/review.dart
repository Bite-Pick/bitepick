import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.freezed.dart';
part 'review.g.dart';

enum SatisfactionType {
  @JsonValue('VARIETY')
  variety,
  @JsonValue('AFFORDABLE')
  affordable,
  @JsonValue('FRIENDLY')
  friendly,
  @JsonValue('ZERO')
  zero;

  String get label {
    switch (this) {
      case SatisfactionType.variety:
        return '다양한 구성';
      case SatisfactionType.affordable:
        return '저렴한 가격';
      case SatisfactionType.friendly:
        return '친절한 사장님';
      case SatisfactionType.zero:
        return 'Zero Food Waste 기여';
    }
  }
}

@freezed
class Review with _$Review {
  const factory Review({
    required String reviewId,
    required int rating,
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

  // TODO: 서버 로직 확인 필요
  String get ratingLabel {
    if (rating == 5) {
      return '최고에요';
    } else if (rating >= 2) {
      return '좋아요';
    } else {
      return '별로에요';
    }
  }
}

// // Mock data for testing
// final mockReviews = [
//   Review(
//     reviewId: '1',
//     rating: 5,
//     satisfactionReasons: [
//       SatisfactionType.variety,
//       SatisfactionType.friendly,
//       SatisfactionType.zero,
//     ],
//     description: '정말 맛있었어요! 빵도 신선하고 사장님도 친절하셔서 기분 좋게 구매했습니다. 다음에도 또 올게요~',
//     createdAt: DateTime(2024, 10, 28),
//     imageUrls: [
//       'https://picsum.photos/200/300?random=1',
//       'https://picsum.photos/200/300?random=2',
//     ],
//     nickName: '김**',
//     goodsId: '748441939065438706',
//     storeId: '1',
//     storeName: '맛있는 베이커리',
//   ),
//   Review(
//     reviewId: '2',
//     rating: 4,
//     satisfactionReasons: [
//       SatisfactionType.affordable,
//       SatisfactionType.variety,
//     ],
//     description: '가격 대비 양도 많고 맛도 좋아요. 다만 매장이 좀 작아서 대기 시간이 길었어요.',
//     createdAt: DateTime(2024, 10, 25),
//     imageUrls: [
//       'https://picsum.photos/200/300?random=3',
//     ],
//     nickName: '이**',
//     goodsId: '748441939065438706',
//     storeId: '1',
//     storeName: '맛있는 베이커리',
//   ),
//   Review(
//     reviewId: '3',
//     rating: 5,
//     satisfactionReasons: [
//       SatisfactionType.variety,
//       SatisfactionType.friendly,
//       SatisfactionType.zero,
//     ],
//     description: '마감 시간에 구매했는데도 빵이 정말 신선했어요! 포장도 꼼꼼하게 해주셔서 좋았습니다. 강추합니다!',
//     createdAt: DateTime(2024, 10, 20),
//     imageUrls: [],
//     nickName: '박**',
//     goodsId: '748441939065438706',
//     storeId: '1',
//     storeName: '맛있는 베이커리',
//   ),
// ];
