import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/features/goods/presentation/widgets/goods_detail_info_form_item.dart';
import 'package:magambell/src/features/goods/presentation/widgets/goods_register_form_title.dart';
import 'package:magambell/src/features/goods/presentation/widgets/step_view_wrapper.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:reactive_forms/reactive_forms.dart';

class GoodsDetailItemData {
  File? image;
  String name;
  String description;

  GoodsDetailItemData({this.image, this.name = '', this.description = ''});
}

class Step4GoodsInfoView extends ConsumerStatefulWidget {
  const Step4GoodsInfoView({super.key});

  @override
  ConsumerState<Step4GoodsInfoView> createState() => _Step4GoodsInfoViewState();
}

class _Step4GoodsInfoViewState extends ConsumerState<Step4GoodsInfoView> {
  final List<GoodsDetailItemData> _items = [];

  @override
  void initState() {
    super.initState();
    // 초기 아이템 1개 추가
    _items.add(GoodsDetailItemData());
  }

  void _addItem() {
    setState(() {
      _items.add(GoodsDetailItemData());
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        return StoreRegisterViewWrapper(
          children: [
            GoodsRegisterFormTitle(
              title: "바이트백 상세설명",
              subtitles: [TextSpan(text: "상세설명은 나중에도 추가 가능해요")],
            ),
            Gaps.h16,

            // 동적 상품 아이템 리스트
            ..._items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;

              return GoodsDetailInfoFormItem(
                key: ValueKey(index),
                index: index,
                onRemove: () => _removeItem(index),
                onImageChanged: (file) => _items[index].image = file,
                onNameChanged: (name) => _items[index].name = name,
                initialImage: item.image,
                initialName: item.name,
              );
            }),

            // + 버튼 (아이템 추가)
            // TODO[UI]: 버튼 터치 영역 horizontal 확장 필요
            GestureDetector(
              onTap: _addItem,
              child: DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  radius: Radius.circular(MgRadius.md),
                  dashPattern: [8, 4],
                  color: MgColorScheme.gray5,
                  strokeWidth: 1.5,
                ),
                child: Center(
                  child: BaseSvgIcon.plus().margin(vertical: MgSizes.sm),
                ),
              ).constrained(width: double.infinity),
            ),
          ],
        );
      },
    );
  }
}
