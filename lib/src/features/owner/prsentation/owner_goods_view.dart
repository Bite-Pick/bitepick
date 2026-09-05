import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/features/goods/presentation/goods_edit_screen.dart';
import 'package:magambell/src/features/image/data/repositories/presigned_image_repository.dart';
import 'package:magambell/src/features/image/domain/entities/local_image.dart';
import 'package:magambell/src/features/image/utils/image_requester.dart';
import 'package:magambell/src/features/owner/prsentation/owner_goods_empty_screen.dart';
import 'package:magambell/src/features/store/data/repositories/store_repository.dart';
import 'package:magambell/src/features/store/domain/entities/store.dart';
import 'package:magambell/src/features/store/presentation/widget/store_bite_bag_view.dart';
import 'package:magambell/src/features/store/presentation/widget/store_info_view.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';

class OwnerGoodsView extends ConsumerWidget {
  const OwnerGoodsView({super.key, this.store});
  final Store? store;

  static const int _maxImages = 5;

  void _showPhotoEditBottomSheet(
    BuildContext context,
    WidgetRef ref,
    Store store,
  ) {
    // 기존 서버 이미지를 LocalImage 리스트로 변환
    final images = store.storeImageUrls
        .asMap()
        .entries
        .map((e) => LocalImage(id: e.key + 1, key: '', uploadedUrl: e.value))
        .toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        // StatefulBuilder로 바텀시트 내부 상태 관리
        return StatefulBuilder(
          builder: (context, setState) {
            final canAddMore = images.length < _maxImages;
            bool isSubmitting = false;

            Future<void> pickImages() async {
              final remaining = _maxImages - images.length;
              if (remaining <= 0) return;
              final files = await ImageRequester().pickMultipleFilesFromGallery();
              if (files.isEmpty) return;
              setState(() {
                for (final file in files.take(remaining)) {
                  images.add(LocalImage(
                    id: images.length + 1,
                    key: file.path.split('/').last,
                    file: file,
                  ));
                }
              });
            }

            Future<void> submit() async {
              if (images.isEmpty) {
                ToastPresentor.error(context, '사진을 1장 이상 선택해주세요');
                return;
              }
              setState(() => isSubmitting = true);
              try {
                final existingCount =
                    images.where((img) => img.uploadedUrl != null).length;
                int newIndex = existingCount + 1;

                final imageUploads = images.map((img) {
                  if (img.uploadedUrl != null) {
                    return {'id': 0, 'key': '', 'imageUrl': img.uploadedUrl!};
                  } else {
                    return {
                      'id': newIndex++,
                      'key': img.key,
                      'imageUrl': '',
                    };
                  }
                }).toList();

                final presignedUrls = await ref
                    .read(storeRepositoryProvider)
                    .updateStoreImages(
                      storeId: store.storeId,
                      images: imageUploads,
                    );

                await ref
                    .read(presignedImageRepositoryProvider)
                    .uploadLocalImagesInOrder(
                      localImages: images,
                      presignedUrls: presignedUrls,
                    );

                if (sheetContext.mounted) {
                  Navigator.of(sheetContext).pop();
                  ToastPresentor.success(context, '매장 사진이 변경되었습니다');
                  ref.invalidate(ownerStoreProvider);
                }
              } catch (_) {
                if (context.mounted) {
                  ToastPresentor.error(context, '사진 변경에 실패했습니다');
                }
              } finally {
                setState(() => isSubmitting = false);
              }
            }

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  MgSizes.md,
                  MgSizes.md,
                  MgSizes.md,
                  MgSizes.md,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 32,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAEBEC),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 타이틀 + 닫기 버튼
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '매장 사진 변경',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(Icons.close, size: 22),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    // 이미지 목록 (가로 스크롤)
                    SizedBox(
                      height: 78,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length + (canAddMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          const borderColor = Color(0xFFDBDCDF);
                          final isFull = images.length >= _maxImages;

                          // 첫 번째 아이템: 추가 버튼
                          if (index == 0 && canAddMore) {
                            return GestureDetector(
                              onTap: pickImages,
                              child: Container(
                                width: 78,
                                height: 78,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(MgRadius.sm),
                                  border: Border.all(color: borderColor),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 26,
                                      height: 24,
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Color(0xFF989BA2),
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(height: 1),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '${images.length}',
                                            style: TextStyle(
                                              color: isFull
                                                  ? const Color(0xFF989BA2)
                                                  : MgColorScheme.primary,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: '/$_maxImages',
                                            style: TextStyle(
                                              color: Color(0xFF757575),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          // 이미지 아이템
                          final imageIndex = canAddMore ? index - 1 : index;
                          final image = images[imageIndex];
                          final isFirst = imageIndex == 0;
                          final imageDecoration = image.file != null
                              ? DecorationImage(
                                  image: FileImage(image.file!),
                                  fit: BoxFit.cover,
                                )
                              : image.uploadedUrl != null
                                  ? DecorationImage(
                                      image: NetworkImage(image.uploadedUrl!),
                                      fit: BoxFit.cover,
                                    )
                                  : null;

                          return Stack(
                            children: [
                              Container(
                                width: 78,
                                height: 78,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(MgRadius.sm),
                                  border: Border.all(color: borderColor),
                                  image: imageDecoration,
                                  color: MgColorScheme.gray2,
                                ),
                              ),
                              // 첫 번째 이미지에 "대표 사진" 레이블
                              if (isFirst)
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 10,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.55),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(MgRadius.sm),
                                        bottomRight: Radius.circular(MgRadius.sm),
                                      ),
                                    ),
                                    child: const Text(
                                      '대표 사진',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ),
                              // X 버튼
                              Positioned(
                                top: 2,
                                right: 2 + 10,
                                child: GestureDetector(
                                  onTap: () =>
                                      setState(() => images.removeAt(imageIndex)),
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.6),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 71),
                    MgButton(
                      onPressed: isSubmitting ? null : submit,
                      content: Text(isSubmitting ? '변경 중...' : '매장 사진 변경하기'),
                    ).primary(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ownerStoreAsync = ref.watch(ownerStoreProvider);
    return MgAsyncAnimatedSwitcher(
      asyncValue: ownerStoreAsync,
      onRetry: () => ref.invalidate(ownerStoreProvider),
      builder: (store) {
        if (store == null) return OwnerGoodsEmptyScreen();
        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  try {
                    ref.invalidate(ownerStoreProvider);
                    await ref.read(ownerStoreProvider.future);
                  } catch (_) {}
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      StoreInfoView(
                        store.toStoreInfoData(),
                        hasFavorite: false,
                        onPhotoChangeTap: () =>
                            _showPhotoEditBottomSheet(context, ref, store),
                      ),
                      StoreBiteBagView(store.goodsImageList ?? []),
                    ],
                  ),
                ),
              ),
            ),
            MgButton(
              onPressed: () async {
                await GoodsEditRoute(
                  $extra: {
                    "goods": store.goodsList[0],
                    "goodsImageList": store.goodsImageList,
                  },
                ).push(context);
              },
              content: Text("상품 관리하기"),
            ).primary().margin(vertical: MgSizes.lg, horizontal: MgSizes.md),
          ],
        ).padding(bottom: BaseScaffold.getBottomMargin(context));
      },
    );
  }
}
