import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/widgets/mg_textfield.dart';

class Step1BasicInfo extends ConsumerStatefulWidget {
  const Step1BasicInfo({super.key});

  @override
  ConsumerState<Step1BasicInfo> createState() => _Step1BasicInfoState();
}

class _Step1BasicInfoState extends ConsumerState<Step1BasicInfo> {
  final TextEditingController _descriptionController = TextEditingController();
  final List<String> _selectedImages = [];

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: MgSizes.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 마감백 설명
          Text('마감백 설명').md().bold(),
          Gaps.h8,
          Text('마감백은 어떤빵으로 구성되어있나요??').sm().textGray(),
          MgTextField(),

          // 대표 이미지
          Text('대표 이미지').md().bold(),
          Gaps.h16,
          _buildImageUploadArea(),
        ],
      ),
    );
  }

  Widget _buildImageUploadArea() {
    return GestureDetector(
      onTap: _pickImages,
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
              '사진추가 (${_selectedImages.length}/5)',
            ).md().textColor(MgColorScheme.gray5),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImages() async {
    // TODO: 이미지 피커 구현
    // image_picker 패키지 사용
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('이미지 선택 기능은 추후 구현 예정입니다')));
  }
}
