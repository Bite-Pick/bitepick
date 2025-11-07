import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/goods/presentation/widgets/goods_register_form_title.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step_view_wrapper.dart';
import 'package:magambell/src/widgets/mg_reactive_textfield.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Step1BasicInfoView extends ConsumerWidget {
  const Step1BasicInfoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ReactiveForm의 FormGroup은 상위에서 제공되므로 ReactiveFormConsumer 사용
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        final images = form.control('images').value as List<String>? ?? [];

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
            _buildImageUploadArea(context, form, images),
          ],
        );
      },
    );
  }

  Widget _buildImageUploadArea(
    BuildContext context,
    FormGroup form,
    List<String> images,
  ) {
    return GestureDetector(
      onTap: () => _pickImages(context, form),
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: MgColorScheme.gray3, width: 1.5),
          borderRadius: BorderRadius.circular(MgRadius.md),
          color: MgColorScheme.gray1.withOpacity(0.3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt_outlined,
              size: 48,
              color: MgColorScheme.gray5,
            ),
            Gaps.h12,
            Text(
              '사진추가 (${images.length}/5)',
            ).md().textColor(MgColorScheme.gray5),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImages(BuildContext context, FormGroup form) async {
    // TODO: 이미지 피커 구현
    // 예시: 이미지 선택 후 FormControl에 추가
    // final images = form.control('images').value as List<String>? ?? [];
    // images.add('new_image_url');
    // form.control('images').value = images;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('이미지 선택 기능은 추후 구현 예정입니다')));
  }
}
