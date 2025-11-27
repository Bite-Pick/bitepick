import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/features/admin/data/repositories/admin_repository.dart';
import 'package:magambell/src/features/admin/presentation/admin_banner_list_screen.controller.dart';
import 'package:magambell/src/features/admin/presentation/mixins/admin_banner_image_upload_mixin.dart';
import 'package:magambell/src/features/banner/domain/constants.dart';
import 'package:magambell/src/features/banner/domain/entities/banner_image.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';

class AdminBannerItem extends ConsumerWidget with AdminBannerImageUploadMixin {
  const AdminBannerItem(this.bannerImage, {super.key});
  final BannerImage bannerImage;

  void _handleRemoveBanner(BuildContext context, WidgetRef ref) async {
    final res = await ref
        .read(adminRepositoryProvider)
        .removeBanner(bannerImage.bannerId);

    if (!context.mounted) return;

    if (!res) {
      ToastPresentor.error(context, "삭제 실패");
      return;
    }
    ToastPresentor.success(context, "삭제 성공");
    ref.invalidate(bannerImagesProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploadState = ref.watch(adminBannerListScreenControllerProvider);
    final isUploading =
        uploadState.isProgress &&
        uploadState.uploadingId == bannerImage.bannerId;
    final List<(String, String)> menus = [('edit', '이미지 수정'), ('remove', '삭제')];
    return Row(
          children: [
            Text(bannerImage.bannerId.toString()),
            Gaps.w16,
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: bannerImage.url,
                  width: BANNER_SIZE.width * 0.7,
                  height: BANNER_SIZE.height * 0.7,
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
            Spacer(),
            PopupMenuButton<String>(
              icon: BaseSvgIcon.moreVertical(),
              onSelected: (value) {
                if (isUploading) return;

                switch (value) {
                  case 'edit':
                    handleBannerImageUpload(
                      context,
                      ref,
                      bannerId: bannerImage.bannerId,
                      onUpload: ref
                          .read(
                            adminBannerListScreenControllerProvider.notifier,
                          )
                          .editBanner,
                      toastMessage: "배너 이미지 수정",
                    );
                  case 'remove':
                    _handleRemoveBanner(context, ref);
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              offset: const Offset(0, 36), // 클릭 위치로부터 아래로 띄움
              itemBuilder: (context) => [
                for (final (value, label) in menus) ...[
                  PopupMenuItem<String>(
                    value: value,
                    child: Center(child: Text(label)),
                  ),
                  if (value != menus.last.$1) const PopupMenuDivider(),
                ],
              ],
            ),
          ],
        )
        .margin(all: MgSizes.sm)
        .decorated(
          borderRadius: BorderRadius.circular(MgRadius.md),
          border: Border.all(width: 1, color: MgColorScheme.gray8),
        );
  }
}
