import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/features/review/domain/entities/review.dart';

class StoreReviewItem extends ConsumerStatefulWidget {
  const StoreReviewItem(this.review, {super.key});

  final Review review;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StoreReviewItemState();
}

class _StoreReviewItemState extends ConsumerState<StoreReviewItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ClipOval(
              // child: Image.network(""), // TODO: 이미지 확정 필요..
              child: Container(width: 50, color: Colors.red),
            ),
          ],
        ),
      ],
    );
  }
}
