import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/admin/data/repositories/admin_repository.dart';
import 'package:magambell/src/features/admin/domain/entities/admin_stats.dart';
import 'package:magambell/src/features/admin/presentation/admin_banner_list_screen.dart';
import 'package:magambell/src/features/admin/presentation/admin_pending_store_list_screen.dart';
import 'package:magambell/src/features/owner/prsentation/widgets/owner_more_button.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';

class AdminHomeRoute extends GoRouteData {
  const AdminHomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminHomeScreen();
  }
}

class AdminHomeScreen extends ConsumerWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingStoreListAsync = ref.watch(pendingStoreListProvider());
    final adminStatsAsync = ref.watch(adminStatsProvider);
    return BaseScaffold(
      canSwipeBack: false,
      appBar: BaseAppBar(
        action: OwnerMoreButton(),
        leading: SizedBox.shrink(),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              R.ASSETS_ICONS_SVG_HOME_LOGO_SVG,
              height: MgSizes.xl,
            ),
            Text(" Admin").md(),
          ],
        ),
      ),
      body: Column(
        spacing: MgSizes.sm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStats(adminStatsAsync),
          Gaps.h8,
          Text("매장관리").bold().md(),
          MgAsyncAnimatedSwitcher(
            asyncValue: pendingStoreListAsync,
            emptyBuilder: () => Text("가입 대기 중인 매장이 없습니다").sm(),
            builder: (pendingStores) {
              return _buildMenu(
                leadingIconPath: 'user-check.svg',
                title: "가입 매장 승인",
                onTap: () async {
                  await AdminPendingStoreListRoute().push(context);
                  // TODO: 라우팅 돌아와서 counting 업데이트
                },
                badgeCount: pendingStores.length,
              );
            },
          ),
          // _buildMenu(
          //   leadingIconPath: 'store-alt.svg',
          //   title: "입점 매장 관리",
          //   onTap: () async {
          //     // TODO: 입점 매장 화면 추가
          //   },
          // ),
          Gaps.h2, //12+2+12
          Text("서비스 관리").bold().md(),
          _buildMenu(
            leadingIconPath: 'gallery-vertical.svg',
            title: "배너 관리",
            onTap: () async => AdminBannerListRoute().push(context),
          ),
        ],
      ).margin(horizontal: MgSizes.lg),
    );
  }

  Widget _buildStats(AsyncValue<AdminStats?> adminStatsAsync) {
    return MgAsyncAnimatedSwitcher(
      asyncValue: adminStatsAsync,
      builder: (stats) {
        if (stats == null) return const SizedBox.shrink();
        return Row(
          children: [
            Expanded(
              child: _buildStatCard(
                title: "가입 유저수",
                count: stats.totalUserCount,
              ),
            ),
            Gaps.w12,
            Expanded(
              child: _buildStatCard(
                title: "가입 매장수",
                count: stats.totalStoreCount,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard({required String title, required int count}) {
    return Column(
          children: [
            Text(title).sm().textGray(),
            Gaps.h4,
            Text(count.toString()).bold().xl(),
          ],
        )
        .margin(vertical: MgSizes.md)
        .decorated(
          borderRadius: BorderRadius.circular(MgSizes.sm),
          border: Border.all(color: MgColorScheme.gray8),
        );
  }

  Widget _buildMenu({
    required VoidCallback onTap,
    required String leadingIconPath,
    required String title,
    int? badgeCount,
  }) {
    return GestureDetector(
      onTap: onTap,
      child:
          Row(
                children: [
                  BaseSvgIcon(assetName: leadingIconPath),
                  Gaps.w8,
                  Text(title).md(),
                  if (badgeCount != null && badgeCount > 0)
                    Text(badgeCount.toString())
                        .white()
                        .bold()
                        .xs()
                        .margin(all: MgSizes.xss)
                        .decorated(color: Colors.red, shape: BoxShape.circle)
                        .margin(left: MgSizes.xs),
                  const Spacer(),

                  BaseSvgIcon.right(color: MgColorScheme.gray6),
                ],
              )
              .margin(vertical: MgSizes.sm, horizontal: MgSizes.md)
              .decorated(
                borderRadius: BorderRadius.circular(MgSizes.sm),
                border: Border.all(color: MgColorScheme.gray8),
              ),
    );
  }
}
