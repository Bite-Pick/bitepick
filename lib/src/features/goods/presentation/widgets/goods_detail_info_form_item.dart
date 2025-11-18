import 'dart:io';

import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/features/image/utils/image_requester.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_textfield.dart';

/// 상품 상세 정보 아이템 (이미지 + 상품명 + 설명)
class GoodsDetailInfoFormItem extends StatefulWidget {
  const GoodsDetailInfoFormItem({
    super.key,
    required this.index,
    required this.onRemove,
    required this.onImageChanged,
    required this.onNameChanged,
    this.initialImage,
    this.initialName,
  });

  final int index;
  final VoidCallback onRemove;
  final Function(File?) onImageChanged;
  final Function(String) onNameChanged;
  final File? initialImage;
  final String? initialName;

  @override
  State<GoodsDetailInfoFormItem> createState() =>
      _GoodsDetailInfoFormItemState();
}

class _GoodsDetailInfoFormItemState extends State<GoodsDetailInfoFormItem> {
  File? _selectedImage;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.initialImage;
    _nameController = TextEditingController(text: widget.initialName);
    _nameController.addListener(() {
      widget.onNameChanged(_nameController.text);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final file = await ImageRequester().pickFileFromGallery(
        quality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (file != null) {
        setState(() => _selectedImage = file);
        widget.onImageChanged(file);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('이미지 선택 중 오류가 발생했습니다: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: MgSizes.md),
      padding: EdgeInsets.all(MgSizes.md),
      decoration: BoxDecoration(
        border: Border.all(color: MgColorScheme.gray7),
        borderRadius: BorderRadius.circular(MgRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 이미지 + 상품명 입력
          Row(
            children: [
              // 이미지 선택 영역
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(MgRadius.sm),
                    border: Border.all(color: MgColorScheme.gray7),
                    image: _selectedImage != null
                        ? DecorationImage(
                            image: FileImage(_selectedImage!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _selectedImage == null
                      ? BaseSvgIcon.camera().margin(all: MgSizes.size28)
                      : null,
                ),
              ),
              Gaps.w12,

              // 상품명 입력 필드
              // TODO[UI]: x 버튼 위치 수정 필요
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("상품명"),
                        GestureDetector(
                          onTap: widget.onRemove,
                          child: BaseSvgIcon.close(),
                        ),
                      ],
                    ),
                    Gaps.h8,

                    MgTextField(
                      controller: _nameController,
                      prefixIcon: SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
