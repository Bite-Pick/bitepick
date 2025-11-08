import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/goods/domain/entities/local_image.dart';
import 'package:magambell/src/features/goods/presentation/goods_register_screen.controller.dart';
import 'package:magambell/src/features/goods/presentation/widgets/goods_register_form_title.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step_view_wrapper.dart';
import 'package:magambell/src/features/image/utils/image_requester.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/mg_reactive_textfield.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Step1BasicInfoView extends ConsumerWidget {
  const Step1BasicInfoView({super.key});
  static const MAX_IMAGE_COUNT = 5;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerState = ref.watch(goodsRegisterScreenControllerProvider);
    final controller = ref.read(goodsRegisterScreenControllerProvider.notifier);

    // ReactiveForm의 FormGroup은 상위에서 제공되므로 ReactiveFormConsumer 사용
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        final localImages = controllerState.localImages;

        return StoreRegisterViewWrapper(
          children: [
            // 마감백 설명
            GoodsRegisterFormTitle(
              title: '마감백 설명',
              subtitles: [TextSpan(text: '마감백은 어떤빵으로 구성되어있나요?')],
            ),
            MgReactiveTextField(
              formControlName: 'description',
              hintText: '마감백 설명 입력',
              maxLines: 4,
            ),
            Gaps.h32,
            GoodsRegisterFormTitle(title: '대표 이미지'),
            // 이미지가 0장일 때만 점선 테두리 버튼 표시
            if (localImages.length == MAX_IMAGE_COUNT)
              Text("이미지는 최대 5장까지 첨부가능해요").red().margin(vertical: MgSizes.xs),
            if (localImages.isEmpty)
              _buildImageUploadArea(context, ref, controller, localImages),
            // 이미지가 1장 이상일 때 이미지 리스트 + 추가 버튼 표시
            if (localImages.isNotEmpty)
              _buildImageList(context, ref, localImages, controller),
          ],
        );
      },
    );
  }

  Widget _buildImageUploadArea(
    BuildContext context,
    WidgetRef ref,
    GoodsRegisterScreenController controller,
    List<LocalImage> localImages,
  ) {
    final canAddMore = localImages.length < MAX_IMAGE_COUNT;

    return Column(
      children: [
        if (!canAddMore) Text("이미지는 최대 5장까지 추가 가능해요").red(),
        GestureDetector(
          child: DottedBorder(
            options: RoundedRectDottedBorderOptions(
              radius: Radius.circular(MgRadius.md),
            ),
            child: MgButton(
              onPressed: canAddMore
                  ? () => _pickImages(context, ref, controller)
                  : null,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseSvgIcon.camera(color: MgColorScheme.gray4),
                  Gaps.w8,
                  Text("사진추가(${localImages.length}/$MAX_IMAGE_COUNT)")
                      .textColor(
                        !canAddMore
                            ? MgColorScheme.alertRed
                            : MgColorScheme.gray4,
                      )
                      .regular(),
                ],
              ),
            ).gray(),
          ),
        ),
      ],
    );
  }

  Widget _buildImageList(
    BuildContext context,
    WidgetRef ref,
    List<LocalImage> localImages,
    GoodsRegisterScreenController controller,
  ) {
    final canAddMore = localImages.length < MAX_IMAGE_COUNT;

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: localImages.length + (canAddMore ? 1 : 0), // + 버튼 추가
        itemBuilder: (context, index) {
          // 마지막 아이템이고 추가 가능하면 + 버튼 표시
          if (index == 0 && canAddMore) {
            return _buildAddImageButton(context, ref, controller, localImages);
          }

          // 이미지 아이템
          final localImage = localImages[canAddMore ? index - 1 : index];
          return Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(right: MgSizes.sm),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(MgRadius.sm),
                  border: Border.all(color: MgColorScheme.gray7),
                  image: DecorationImage(
                    image: FileImage(localImage.file),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 4,
                right: 4 + MgSizes.sm,
                child: GestureDetector(
                  onTap: () => controller.removeImage(index),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, size: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAddImageButton(
    BuildContext context,
    WidgetRef ref,
    GoodsRegisterScreenController controller,
    List<LocalImage> localImages,
  ) {
    return GestureDetector(
      onTap: () => _pickImages(context, ref, controller),
      child: Container(
        width: 100,
        height: 100,
        margin: EdgeInsets.only(right: MgSizes.sm),
        child: DottedBorder(
          options: RoundedRectDottedBorderOptions(
            radius: Radius.circular(MgRadius.sm),
            dashPattern: [6, 3],
            strokeWidth: 1.5,
            color: MgColorScheme.gray5,
          ),

          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, size: 32, color: MgColorScheme.gray5),
                Gaps.h4,
                Text(
                  '${localImages.length}/$MAX_IMAGE_COUNT',
                ).textColor(MgColorScheme.gray5).xs(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImages(
    BuildContext context,
    WidgetRef ref,
    GoodsRegisterScreenController controllerNotifier,
  ) async {
    try {
      // 최대 5장 제한 확인
      final currentImages = ref
          .read(goodsRegisterScreenControllerProvider)
          .localImages;
      final remainingSlots = MAX_IMAGE_COUNT - currentImages.length;

      if (remainingSlots <= 0) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('최대 5장까지만 업로드할 수 있습니다')));
        }
        return;
      }

      // ImageRequester를 사용하여 갤러리에서 이미지 선택
      final pickedFiles = await ImageRequester().pickMultipleFilesFromGallery(
        quality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (pickedFiles.isEmpty) return;

      // 남은 슬롯만큼만 추가
      final filesToAdd = pickedFiles.take(remainingSlots).toList();

      if (filesToAdd.isEmpty) return;

      // 로컬 이미지 추가
      controllerNotifier.addLocalImages(filesToAdd);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('이미지 ${filesToAdd.length}장 추가됨')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('이미지 선택 중 오류가 발생했습니다: $e'),
            backgroundColor: MgColorScheme.subpointRed,
          ),
        );
      }
    }
  }
}
