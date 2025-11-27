import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/features/admin/data/repositories/admin_repository.dart';
import 'package:magambell/src/features/admin/presentation/banner_list_screen.controller.dart';
import 'package:magambell/src/features/admin/presentation/mixins/banner_image_upload_mixin.dart';
import 'package:magambell/src/features/banner/domain/entities/banner_image.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';

class AdminBannerItem extends ConsumerWidget with BannerImageUploadMixin {
  const AdminBannerItem(this.bannerImage, {super.key});
  final BannerImage bannerImage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploadState = ref.watch(bannerListScreenControllerProvider);
    final isUploading =
        uploadState.isProgress &&
        uploadState.uploadingId == bannerImage.bannerId;

    return Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text("id : ${bannerImage.bannerId}"),
            ),
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: bannerImage.url,
                  width: 343,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                // 업로드 중 오버레이
                if (isUploading)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ).margin(vertical: MgSizes.sm),
            Row(
              children: [
                Flexible(
                  flex: 7,
                  child: MgButton(
                    onPressed: isUploading
                        ? null
                        : () async {
                            await handleBannerImageUpload(
                              context,
                              ref,
                              bannerId: bannerImage.bannerId,
                              onUpload: ref
                                  .read(
                                    bannerListScreenControllerProvider.notifier,
                                  )
                                  .editBanner,
                              toastMessage: "배너 이미지 수정",
                            );
                          },
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BaseSvgIcon.rotateCw(size: MgSizes.md),
                        Gaps.w8,
                        Text(isUploading ? "업로드 중..." : "이미지 변경"),
                      ],
                    ),
                    borderColor: MgColorScheme.gray7,
                    padding: Gutter.hxs,
                  ),
                ),
                Gaps.w12,
                Flexible(
                  flex: 3,
                  child: MgButton(
                    onPressed: isUploading
                        ? null
                        : () async {
                            final res = await ref
                                .read(adminRepositoryProvider)
                                .removeBanner(bannerImage.bannerId);

                            if (!res) {
                              ToastPresentor.error(context, "삭제 실패");
                              return;
                            }
                            ToastPresentor.success(context, "삭제 성공");
                            ref.invalidate(bannerImagesProvider);
                          },
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BaseSvgIcon.trash(size: MgSizes.md),
                        Gaps.w8,
                        const Text("삭제"),
                      ],
                    ),
                    padding: Gutter.hxs,
                  ).red(),
                ),
              ],
            ),
          ],
        )
        .margin(all: MgSizes.sm)
        .decorated(
          color: MgColorScheme.gray8,
          borderRadius: BorderRadius.circular(MgRadius.md),
        );
  }
}
