import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/admin/data/repositories/admin_repository.dart';
import 'package:magambell/src/features/admin/presentation/admin_banner_list_screen.controller.dart';
import 'package:magambell/src/features/admin/presentation/mixins/admin_banner_image_upload_mixin.dart';
import 'package:magambell/src/features/admin/presentation/widgets/admin_banner_item.dart';
import 'package:magambell/src/features/banner/domain/constants.dart';
import 'package:magambell/src/features/image/domain/entities/local_image.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class AdminBannerListRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminBannerListScreen();
  }
}

class AdminBannerListScreen extends ConsumerStatefulWidget {
  const AdminBannerListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminBannerListScreen();
}

class _AdminBannerListScreen extends ConsumerState<AdminBannerListScreen>
    with AdminBannerImageUploadMixin {
  @override
  Widget build(BuildContext context) {
    final bannerImagesAsync = ref.watch(bannerImagesProvider);
    final controllerState = ref.watch(adminBannerListScreenControllerProvider);
    final controller = ref.watch(
      adminBannerListScreenControllerProvider.notifier,
    );
    return BaseScaffold(
      backgroundColor: MgColorScheme.gray10,
      appBar: BaseAppBar(title: Text("배너 관리")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "(${BANNER_SIZE.width}x${BANNER_SIZE.height})배율로 이미지를 등록해주세요",
          ).textGray().bold(),
          Gaps.h20,
          Column(
                children: [
                  Text("배너 등록").lg().bold(),
                  Gaps.h12,
                  MgButton(
                    disabled: controllerState.isProgress,
                    onPressed: () async {
                      await handleBannerImageUpload(
                        context,
                        ref,
                        bannerId: getId(),
                        onUpload: ref
                            .read(
                              adminBannerListScreenControllerProvider.notifier,
                            )
                            .registerBanner,
                        toastMessage: "배너 업로드",
                      );
                    },
                    content: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BaseSvgIcon.upload(),
                        Gaps.w8,
                        const Text("이미지 선택"),
                      ],
                    ),
                  ).gray(),
                ],
              )
              .margin(vertical: MgSizes.md, horizontal: MgSizes.sm)
              .decorated(
                color: MgColorScheme.lightest,
                borderRadius: BorderRadius.circular(MgRadius.md),
              ),
          Gaps.h20,
          Expanded(
            child: MgAsyncAnimatedSwitcher(
              asyncValue: bannerImagesAsync,
              emptyBuilder: () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("등록된 배너(0)"),
                  Expanded(child: Center(child: Text("등록된 배너가 없습니다"))),
                ],
              ),
              builder: (bannerImages) {
                final totalCount = bannerImages.length;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("등록된 배너($totalCount)"),
                    Gaps.h20,
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final bannerImage = bannerImages[index];
                          return AdminBannerItem(bannerImage);
                        },
                        separatorBuilder: (context, index) => Gaps.h12,
                        itemCount: totalCount,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ).margin(horizontal: MgSizes.md),
    );
  }
}
