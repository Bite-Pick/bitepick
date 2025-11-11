import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/features/goods/presentation/goods_register_screen.controller.dart';
import 'package:magambell/src/features/goods/presentation/widgets/goods_register_form_title.dart';
import 'package:magambell/src/features/goods/presentation/widgets/image_upload_section.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step_view_wrapper.dart';
import 'package:magambell/src/widgets/mg_reactive_textfield.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Step1BasicInfoView extends ConsumerWidget {
  const Step1BasicInfoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(goodsRegisterScreenControllerProvider.notifier);
    final localImages = ref.watch(goodsRegisterScreenControllerProvider.select((s) => s.localImages));

    return ReactiveFormConsumer(
      builder: (context, form, child) {
        return StoreRegisterViewWrapper(
          children: [
            // 마감백 설명
            GoodsRegisterFormTitle(
              title: '마감백 설명',
              subtitles: [TextSpan(text: '마감백은 어떤빵으로 구성되어있나요?')],
            ),
            MgReactiveTextField(formControlName: 'description'),
            Gaps.h32,
            GoodsRegisterFormTitle(title: '대표 이미지'),
            ImageUploadSection(
              images: localImages,
              onAddImages: (files) => controller.addLocalImages(files),
              onRemoveImage: (index) => controller.removeImage(index),
            ),
          ],
        );
      },
    );
  }
}
