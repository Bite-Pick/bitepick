import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/goods/presentation/widgets/image_upload_section.dart';
import 'package:magambell/src/features/review/presentation/review_register_screen.controller.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class ReviewRegisterRoute extends GoRouteData {
  final String orderGoodsId;

  const ReviewRegisterRoute({required this.orderGoodsId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ReviewRegisterScreen(orderGoodsId: orderGoodsId);
  }
}

class ReviewRegisterScreen extends ConsumerStatefulWidget {
  final String orderGoodsId;

  const ReviewRegisterScreen({super.key, required this.orderGoodsId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReviewRegisterScreenState();
}

class _ReviewRegisterScreenState extends ConsumerState<ReviewRegisterScreen> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(
      reviewRegisterScreenControllerProvider(widget.orderGoodsId),
    );
    final notifier = ref.read(
      reviewRegisterScreenControllerProvider(widget.orderGoodsId).notifier,
    );

    return BaseScaffold(
      appBar: BaseAppBar(title: const Text("리뷰 등록")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 별점 선택
          Text("상품은 어떠셨나요?").bold().md(),
          Gaps.h16,
          _buildRatingSection(controller.rating, notifier),
          Gaps.h32,

          // 리뷰 내용
          Text("상품은 만족하셨나요?").bold().md(),
          Gaps.h16,
          _buildDescriptionField(notifier),
          Gaps.h8,
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "${_descriptionController.text.length} / 최소 10자",
            ).textColor(MgColorScheme.gray4).xs(),
          ),
          Gaps.h32,

          // 이미지 업로드
          ImageUploadSection(
            images: controller.images,
            onAddImages: notifier.addImages,
            onRemoveImage: notifier.removeImage,
          ),
          Spacer(),
          MgButton(
            onPressed: controller.isSubmitting ? null : _handleSubmit,
            content: controller.isSubmitting
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                      Gaps.w8,
                      Text(
                        "업로드 중... ${(controller.uploadProgress * 100).toInt()}%",
                      ).white().bold(),
                    ],
                  )
                : const Text("작성완료").white().bold(),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSection(
    int currentRating,
    ReviewRegisterScreenController notifier,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildRatingButton(
          emoji: "😆",
          label: "최고에요",
          rating: 5,
          isSelected: currentRating == 5,
          onTap: () => notifier.setRating(5),
        ),
        _buildRatingButton(
          emoji: "🙂",
          label: "좋아요",
          rating: 4,
          isSelected: currentRating == 4,
          onTap: () => notifier.setRating(4),
        ),
        _buildRatingButton(
          emoji: "😕",
          label: "아쉬워요",
          rating: 3,
          isSelected: currentRating == 3,
          onTap: () => notifier.setRating(3),
        ),
      ],
    );
  }

  Widget _buildRatingButton({
    required String emoji,
    required String label,
    required int rating,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: MgSizes.md,
          vertical: MgSizes.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? MgColorScheme.primary : MgColorScheme.gray8,
          borderRadius: BorderRadius.circular(MgRadius.lg),
          border: Border.all(
            color: isSelected ? MgColorScheme.primary : MgColorScheme.gray6,
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            // TODO badSelect,good,notbad
            Gaps.h8,
            Text(label)
                .textColor(
                  isSelected ? MgColorScheme.black : MgColorScheme.gray4,
                )
                .sm()
                .medium(),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionField(ReviewRegisterScreenController notifier) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MgColorScheme.gray6),
        borderRadius: BorderRadius.circular(MgRadius.md),
      ),
      child: TextField(
        controller: _descriptionController,
        maxLines: 6,
        maxLength: 200,
        decoration: InputDecoration(
          hintText: "구매하신 바이트백에 대한 후기를 20자 이상 남겨주시면\n다른 구매자들에게도 도움이 됩니다!",
          hintStyle: TextStyle(color: MgColorScheme.gray4, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(MgSizes.md),
          counterText: "",
        ),
        onChanged: (value) {
          notifier.setDescription(value);
          setState(() {}); // 글자 수 업데이트를 위해
        },
      ),
    );
  }

  Future<void> _handleSubmit() async {
    final notifier = ref.read(
      reviewRegisterScreenControllerProvider(widget.orderGoodsId).notifier,
    );

    final success = await notifier.submit();

    if (success && mounted) {
      // 리뷰 등록 성공
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('리뷰가 등록되었습니다')));
      context.pop(); // 이전 화면으로 돌아가기
    }
  }
}
