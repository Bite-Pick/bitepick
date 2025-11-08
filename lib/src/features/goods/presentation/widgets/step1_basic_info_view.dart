import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/goods/domain/entities/local_image.dart';
import 'package:magambell/src/features/goods/presentation/goods_register_screen.controller.dart';
import 'package:magambell/src/features/goods/presentation/widgets/goods_register_form_title.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step_view_wrapper.dart';
import 'package:magambell/src/features/image/utils/image_requester.dart';
import 'package:magambell/src/widgets/mg_reactive_textfield.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Step1BasicInfoView extends ConsumerWidget {
  const Step1BasicInfoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(goodsRegisterScreenControllerProvider);
    final controllerNotifier =
        ref.read(goodsRegisterScreenControllerProvider.notifier);

    // ReactiveForm의 FormGroup은 상위에서 제공되므로 ReactiveFormConsumer 사용
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        final localImages = controller.localImages;

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
            _buildImageUploadArea(context, ref, controllerNotifier, localImages),
            if (localImages.isNotEmpty) ...[
              Gaps.h16,
              _buildImageList(localImages, controllerNotifier),
            ],
          ],
        );
      },
    );
  }

  Widget _buildImageUploadArea(
    BuildContext context,
    WidgetRef ref,
    GoodsRegisterScreenController controllerNotifier,
    List<LocalImage> localImages,
  ) {
    final canAddMore = localImages.length < 5;

    return GestureDetector(
      onTap: canAddMore ? () => _pickImages(context, ref, controllerNotifier) : null,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(
            color: canAddMore ? MgColorScheme.gray3 : MgColorScheme.gray7,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(MgRadius.md),
          color: MgColorScheme.gray1.withOpacity(0.3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt_outlined,
              size: 48,
              color: canAddMore ? MgColorScheme.gray5 : MgColorScheme.gray7,
            ),
            Gaps.h12,
            Text(
              '사진추가 (${localImages.length}/5)',
            ).md().textColor(
              canAddMore ? MgColorScheme.gray5 : MgColorScheme.gray7,
            ),
            if (!canAddMore) ...[
              Gaps.h8,
              Text('최대 5장까지 추가 가능합니다')
                  .sm()
                  .textColor(MgColorScheme.subpointRed),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildImageList(
    List<LocalImage> localImages,
    GoodsRegisterScreenController controllerNotifier,
  ) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: localImages.length,
        itemBuilder: (context, index) {
          final localImage = localImages[index];
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
                  onTap: () => controllerNotifier.removeImage(index),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
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
      final currentImages = ref.read(goodsRegisterScreenControllerProvider).localImages;
      final remainingSlots = 5 - currentImages.length;

      if (remainingSlots <= 0) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('최대 5장까지만 업로드할 수 있습니다')),
          );
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
