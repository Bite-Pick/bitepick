import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/goods/presentation/widgets/image_upload_section.dart';
import 'package:magambell/src/features/review/presentation/review_register_screen.controller.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/mg_textfield.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';

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
      appBar: BaseAppBar(title: const Text("리뷰 작성")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.h16,
          // 별점 선택
          Text("상품은 어떠셨나요?").bold().md(),
          _buildRatingSection(
            controller.rating,
            notifier,
          ).margin(top: MgSizes.md, bottom: MgSizes.xl),

          // 리뷰 내용
          Text("상품은 만족하셨나요?").bold().md(),
          Gaps.h16,
          _buildDescriptionField(notifier),

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
            disabled:
                controller.isSubmitting ||
                controller.description.isEmpty ||
                controller.rating == 0,
            content: Text("작성완료"),
          ).primary(),
        ],
      ).margin(horizontal: MgSizes.md),
    );
  }

  Widget _buildRatingSection(
    int currentRating,
    ReviewRegisterScreenController notifier,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: _buildRatingButton(
            text: "최고에요",
            isSelect: currentRating == 3,
            onTap: () => notifier.setRating(3),
            selectImagePath: 'good_select.svg',
            unSelectImagePath: 'good_unselect.svg',
          ),
        ),
        Expanded(
          child: _buildRatingButton(
            text: "좋아요",
            isSelect: currentRating == 2,
            onTap: () => notifier.setRating(2),
            selectImagePath: 'notbad_select.svg',
            unSelectImagePath: 'notbad_unselect.svg',
          ),
        ),
        Expanded(
          child: _buildRatingButton(
            text: "아쉬워요",
            isSelect: currentRating == 1,
            onTap: () => notifier.setRating(1),
            selectImagePath: 'bad_select.svg',
            unSelectImagePath: 'bad_unselect.svg',
          ),
        ),
      ],
    );
  }

  Widget _buildRatingButton({
    required String selectImagePath,
    required String unSelectImagePath,
    required bool isSelect,
    required VoidCallback onTap,
    required String text,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          BaseSvgIcon(
            assetName: isSelect ? selectImagePath : unSelectImagePath,
            size: 50,
          ),
          Gaps.h4,
          Text(text).md(),
        ],
      ).margin(vertical: MgSizes.size10),
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
        onChanged: notifier.setDescription,
      ),
    );
    return MgTextField(
      hintText: '구매하신 바이트백에 대한 후기를 20자 이상 남겨주시면\n다른 구매자들에게도 도움이 됩니다',
      maxLines: 6,
      onChanged: (value) {
        notifier.setDescription(value);
      },
      prefixIcon: SizedBox.shrink(),
    );
  }

  Future<void> _handleSubmit() async {
    final notifier = ref.read(
      reviewRegisterScreenControllerProvider(widget.orderGoodsId).notifier,
    );

    final success = await notifier.submit();

    if (success && mounted) {
      ToastPresentor.success(context, '리뷰가 등록되었습니다');
      context.pop(true);
    }
  }
}
