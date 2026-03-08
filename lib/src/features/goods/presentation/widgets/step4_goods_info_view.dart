import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/features/goods/domain/entities/goods_detail_item.dart';
import 'package:magambell/src/features/goods/presentation/widgets/goods_detail_info_form_item.dart';
import 'package:magambell/src/features/goods/presentation/widgets/goods_register_form_title.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step_view_wrapper.dart';
import 'package:magambell/src/features/image/utils/image_requester.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Step4GoodsInfoView extends ConsumerWidget {
  const Step4GoodsInfoView({
    super.key,
    required this.goodsDetails,
    required this.onAddGoodsDetail,
    required this.onUpdateGoodsDetail,
    required this.onRemoveGoodsDetail,
  });

  final List<GoodsDetailItem> goodsDetails;
  final Function(File file, String name) onAddGoodsDetail;
  final Function(int index, File? file, String? name) onUpdateGoodsDetail;
  final Function(int index) onRemoveGoodsDetail;

  Future<void> _addItem(BuildContext context) async {
    // 사용자에게 이미지를 먼저 선택하도록 요청
    try {
      final file = await ImageRequester().pickFileFromGallery(
        quality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (file != null) {
        // 이미지가 선택되면 controller에 추가
        onAddGoodsDetail(file, ''); // 이름은 나중에 입력
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('이미지 선택 중 오류가 발생했습니다: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        return StoreRegisterViewWrapper(
          children: [
            GoodsRegisterFormTitle(
              title: "바이트백 메뉴 구성",
              subtitles: [TextSpan(text: "상세설명은 나중에도 추가 가능해요")],
            ),
            Gaps.h16,

            // 동적 상품 아이템 리스트
            ...goodsDetails.asMap().entries.map((entry) {
              final index = entry.key;
              final detail = entry.value;

              return GoodsDetailInfoFormItem(
                key: ValueKey(index),
                index: index,
                onRemove: () => onRemoveGoodsDetail(index),
                onImageChanged: (file) {
                  if (file != null) {
                    onUpdateGoodsDetail(index, file, null);
                  }
                },
                onNameChanged: (name) {
                  onUpdateGoodsDetail(index, null, name);
                },
                initialImage: detail.localImage.file,
                initialImageUrl: detail.localImage.uploadedUrl,
                initialName: detail.name,
              );
            }),

            // + 버튼 (아이템 추가)
            // TODO[UI]: 버튼 터치 영역 horizontal 확장 필요
            GestureDetector(
              onTap: () => _addItem(context),
              behavior: HitTestBehavior.opaque,
              child: DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  radius: Radius.circular(MgRadius.md),
                  dashPattern: [8, 4],
                  color: MgColorScheme.gray5,
                  strokeWidth: 1.5,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: Center(
                    child: BaseSvgIcon.plus().margin(vertical: MgSizes.sm),
                  ),
                ),
              ).constrained(width: double.infinity, height: 48),
            ),
          ],
        );
      },
    );
  }
}
