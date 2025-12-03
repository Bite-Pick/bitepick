import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/image/domain/entities/local_image.dart';
import 'package:magambell/src/features/image/utils/image_requester.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class ImageUploadSection extends ConsumerStatefulWidget {
  final List<LocalImage> images;
  final Function(List<File>) onAddImages;
  final Function(int) onRemoveImage;

  const ImageUploadSection({
    super.key,
    required this.images,
    required this.onAddImages,
    required this.onRemoveImage,
  });

  static const int MAX_IMAGE_COUNT = 5;

  @override
  ConsumerState<ImageUploadSection> createState() => _ImageUploadSectionState();
}

class _ImageUploadSectionState extends ConsumerState<ImageUploadSection> {
  @override
  Widget build(BuildContext context) {
    final localImages = widget.images;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (localImages.length >= ImageUploadSection.MAX_IMAGE_COUNT)
          Padding(
            padding: const EdgeInsets.only(bottom: MgSizes.xs),
            child: Text("이미지는 최대 5장까지 첨부가능해요").red(),
          ),
        if (localImages.isEmpty) _buildImageUploadArea(),
        if (localImages.isNotEmpty) _buildImageList(),
      ],
    );
  }

  Widget _buildImageUploadArea() {
    final canAddMore =
        widget.images.length < ImageUploadSection.MAX_IMAGE_COUNT;

    return GestureDetector(
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(MgRadius.md),
        ),
        child: MgButton(
          onPressed: canAddMore ? _pickImages : null,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BaseSvgIcon.camera(color: MgColorScheme.gray4),
              Gaps.w8,
              Text(
                    "사진추가(${widget.images.length}/${ImageUploadSection.MAX_IMAGE_COUNT})",
                  )
                  .textColor(
                    !canAddMore ? MgColorScheme.alertRed : MgColorScheme.gray4,
                  )
                  .regular(),
            ],
          ),
        ).gray(),
      ),
    );
  }

  Widget _buildImageList() {
    final localImages = widget.images;
    final canAddMore = localImages.length < ImageUploadSection.MAX_IMAGE_COUNT;

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: localImages.length + (canAddMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == 0 && canAddMore) {
            return _buildAddImageButton();
          }

          final imageIndex = canAddMore ? index - 1 : index;
          final localImage = localImages[imageIndex];
          if (localImage.file == null) return const SizedBox.shrink();

          return Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(right: MgSizes.sm),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(MgRadius.sm),
                  border: Border.all(color: MgColorScheme.gray7),
                  image: DecorationImage(
                    image: FileImage(localImage.file!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 4,
                right: 4 + MgSizes.sm,
                child: GestureDetector(
                  onTap: () => widget.onRemoveImage(imageIndex),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
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

  Widget _buildAddImageButton() {
    return GestureDetector(
      onTap: _pickImages,
      child: Container(
        width: 100,
        height: 100,
        margin: const EdgeInsets.only(right: MgSizes.sm),
        child: DottedBorder(
          options: RoundedRectDottedBorderOptions(
            radius: Radius.circular(MgRadius.sm),
            dashPattern: const [6, 3],
            strokeWidth: 1.5,
            color: MgColorScheme.gray5,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add, size: 32, color: MgColorScheme.gray5),
                Gaps.h4,
                Text(
                  '${widget.images.length}/${ImageUploadSection.MAX_IMAGE_COUNT}',
                ).textColor(MgColorScheme.gray5).xs(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImages() async {
    try {
      final remainingSlots =
          ImageUploadSection.MAX_IMAGE_COUNT - widget.images.length;

      if (remainingSlots <= 0) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('최대 5장까지만 업로드할 수 있습니다')));
        }
        return;
      }

      final pickedFiles = await ImageRequester().pickMultipleFilesFromGallery(
        quality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (pickedFiles.isEmpty) return;

      final filesToAdd = pickedFiles.take(remainingSlots).toList();
      if (filesToAdd.isEmpty) return;

      widget.onAddImages(filesToAdd);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('이미지 ${filesToAdd.length}장 추가됨')),
        );
      }
    } catch (e) {
      if (mounted) {
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
