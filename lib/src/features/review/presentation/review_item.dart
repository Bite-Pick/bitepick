import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/features/review/data/repositories/review_repository.dart';
import 'package:magambell/src/features/review/domain/entities/review.dart';
import 'package:magambell/src/features/review/presentation/review_card_view.dart';
import 'package:magambell/src/features/user/providers/user.provider.dart';
import 'package:magambell/src/widgets/mg_alert_dialog.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';

enum ReviewItemButtonType { report, delete, none }

class _ImageViewerDialog extends StatefulWidget {
  const _ImageViewerDialog({
    required this.imageUrls,
    required this.initialIndex,
  });

  final List<String> imageUrls;
  final int initialIndex;

  @override
  State<_ImageViewerDialog> createState() => _ImageViewerDialogState();
}

class _ImageViewerDialogState extends State<_ImageViewerDialog> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Colors.black,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: widget.imageUrls.length,
            controller: PageController(initialPage: widget.initialIndex),
            onPageChanged: (i) => setState(() => _currentIndex = i),
            itemBuilder: (_, index) => InteractiveViewer(
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrls[index],
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close, color: Colors.white),
              ),
            ),
          ),
          if (widget.imageUrls.length > 1)
            Positioned(
              bottom: MgSizes.xl,
              left: 0,
              right: 0,
              child: Text(
                '${_currentIndex + 1} / ${widget.imageUrls.length}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}

class ReviewItem extends ConsumerStatefulWidget {
  const ReviewItem(
    this.review, {
    this.buttonType = ReviewItemButtonType.none,
    super.key,
  });

  final Review review;
  final ReviewItemButtonType buttonType;

  factory ReviewItem.userReview(Review review) {
    return ReviewItem(review, buttonType: ReviewItemButtonType.report);
  }

  factory ReviewItem.myReview(Review review) {
    return ReviewItem(review, buttonType: ReviewItemButtonType.delete);
  }

  @override
  ConsumerState<ReviewItem> createState() => _ReviewItemState();
}

class _ReviewItemState extends ConsumerState<ReviewItem> {
  @override
  Widget build(BuildContext context) {
    final user = ref.read(userStateProvider).asData!.value;
    final isLogin = user != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: MgSizes.md),
          child: ReviewCardView(
            nickName: widget.review.nickName,
            createdAt: widget.review.createdAt,
            description: widget.review.description,
            imageUrls: widget.review.imageUrls,
            replyContent: widget.review.reply?.content,
            replyCreatedAt: widget.review.reply?.createdAt,
            trailing: isLogin ? _buildActionButton() : null,
          ),
        ),
        Container(
          height: 1,
          color: MgColorScheme.gray8,
          margin: const EdgeInsets.symmetric(horizontal: MgSizes.md),
        ),
      ],
    );
  }


  Widget _buildActionButton() {
    return switch (widget.buttonType) {
      ReviewItemButtonType.report => MgButton(
        onPressed: () async => _showReportDialog(),
        content: Text("신고하기").xs(),
        padding: EdgeInsets.symmetric(horizontal: MgSizes.sm),
      ),
      ReviewItemButtonType.delete => MgButton(
        onPressed: () async => _showDeleteDialog(),
        content: Text("삭제").xs().textGray(),
        padding: EdgeInsets.symmetric(horizontal: MgSizes.sm),
      ),
      ReviewItemButtonType.none => const SizedBox.shrink(),
    };
  }

  void _showImageViewer(int initialIndex) {
    showDialog(
      context: context,
      builder: (_) => _ImageViewerDialog(
        imageUrls: widget.review.imageUrls,
        initialIndex: initialIndex,
      ),
    );
  }

  // TODO[review]: 테스트 필요
  Future<void> _showReportDialog() async {
    await showDialog(
      context: context,
      builder: (context) => MgAlertDialog.basic(
        title: '이 리뷰를 신고할까요?',
        content: Text('신고하면 리뷰가 보이지 않아요.'),
        onConfirm: () async => ref
            .read(reviewRepositoryProvider)
            .reportReview(widget.review.reviewId),
      ),
    );
  }

  Future<void> _showDeleteDialog() async {
    await showDialog(
      context: context,
      builder: (context) => MgAlertDialog.basic(
        title: '리뷰 삭제',
        content: Text('리뷰를 삭제하시겠습니까?'),
        onConfirm: () async {
          final res = await ref
              .read(reviewRepositoryProvider)
              .deleteReview(widget.review.reviewId);
          if (res) {
            ToastPresentor.success(context, "리뷰가 삭제되었습니다.");
            // TODO: refactor 각 화면에서 사용하는 provider만 invalidate하도록
            ref.invalidate(reviewsProvider(goodsId: widget.review.goodsId));
            ref.invalidate(myReviewsProvider);
          } else {
            ToastPresentor.error(context, "리뷰 삭제에 실패했습니다. 문의해주세요");
          }
        },
      ),
    );
  }
}
