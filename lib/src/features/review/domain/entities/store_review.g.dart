// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoreReviewSummaryImpl _$$StoreReviewSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$StoreReviewSummaryImpl(
  averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
  totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
  noReplyCount: (json['noReplyCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$StoreReviewSummaryImplToJson(
  _$StoreReviewSummaryImpl instance,
) => <String, dynamic>{
  'averageRating': instance.averageRating,
  'totalCount': instance.totalCount,
  'noReplyCount': instance.noReplyCount,
};

_$StoreReviewReplyImpl _$$StoreReviewReplyImplFromJson(
  Map<String, dynamic> json,
) => _$StoreReviewReplyImpl(
  replyId: json['replyId'] as String,
  content: json['content'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$StoreReviewReplyImplToJson(
  _$StoreReviewReplyImpl instance,
) => <String, dynamic>{
  'replyId': instance.replyId,
  'content': instance.content,
  'createdAt': instance.createdAt.toIso8601String(),
};

_$StoreReviewItemImpl _$$StoreReviewItemImplFromJson(
  Map<String, dynamic> json,
) => _$StoreReviewItemImpl(
  reviewId: json['reviewId'] as String,
  rating: (json['rating'] as num).toInt(),
  description: json['description'] as String,
  imageUrls: (json['imageUrls'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  nickName: json['nickName'] as String,
  orderedAt: DateTime.parse(json['orderedAt'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  productName: json['productName'] as String,
  reply: json['reply'] == null
      ? null
      : StoreReviewReply.fromJson(json['reply'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$StoreReviewItemImplToJson(
  _$StoreReviewItemImpl instance,
) => <String, dynamic>{
  'reviewId': instance.reviewId,
  'rating': instance.rating,
  'description': instance.description,
  'imageUrls': instance.imageUrls,
  'nickName': instance.nickName,
  'orderedAt': instance.orderedAt.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'productName': instance.productName,
  'reply': instance.reply,
};

_$StoreReviewListResponseImpl _$$StoreReviewListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$StoreReviewListResponseImpl(
  summary: StoreReviewSummary.fromJson(json['summary'] as Map<String, dynamic>),
  items: (json['items'] as List<dynamic>)
      .map((e) => StoreReviewItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  nextCursor: (json['nextCursor'] as num?)?.toInt() ?? 0,
  hasNext: json['hasNext'] as bool,
);

Map<String, dynamic> _$$StoreReviewListResponseImplToJson(
  _$StoreReviewListResponseImpl instance,
) => <String, dynamic>{
  'summary': instance.summary,
  'items': instance.items,
  'nextCursor': instance.nextCursor,
  'hasNext': instance.hasNext,
};
