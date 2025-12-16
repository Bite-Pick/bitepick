import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/config/environment.dart';
import 'package:magambell/src/core/extensions/list_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/utils/inquiry_button.dart';
import 'package:magambell/src/core/utils/shorebird_manager.dart';
import 'package:magambell/src/core/utils/visual_logger_provider.dart';
import 'package:magambell/src/features/auth/utils/auth_utils.dart';
import 'package:magambell/src/features/favorite/presentation/favorite_screen.dart';
import 'package:magambell/src/features/review/presentation/my_review_list_screen.dart';
import 'package:magambell/src/features/user/data/repositories/user_repository.dart';
import 'package:magambell/src/features/user/presentation/user_profile_item.dart';
import 'package:magambell/src/features/user/providers/user.provider.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/mg_text_rich.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MypageScreen extends ConsumerStatefulWidget {
  const MypageScreen({super.key});

  @override
  ConsumerState<MypageScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends ConsumerState<MypageScreen> {
  String _version = '';
  int? _patchNumber;

  @override
  void initState() {
    super.initState();
    _loadVersionInfo();
  }

  Future<void> _loadVersionInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final patchNumber = await ShorebirdManager.getCurrentPatchNumber();

    if (mounted) {
      setState(() {
        _version = packageInfo.version;
        _patchNumber = patchNumber;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final myPageAsync = ref.watch(mypageProvider);
    return BaseScaffold(
      body: SafeArea(
        child: Column(
          children: [
            Gaps.h16,
            _buildProfileSection(),
            Gaps.h16,
            MgAsyncAnimatedSwitcher(
              asyncValue: myPageAsync,
              builder: (myPage) {
                if (myPage == null) return SizedBox.shrink();
                return _buildKgSection(
                  myPage.savedKg,
                ).margin(bottom: MgSizes.md);
              },
            ),
            _buildMenuList(),
            _buildAuthSection(),
            _buildVersionSection(),
            // _buildVersionSection(),
            if (Environment.instance.isDev) ...[
              Gaps.h16,
              _buildDeveloperSection(),
            ],
            Gaps.h16,
          ],
        ).margin(horizontal: MgSizes.md),
      ),
    );
  }

  Widget _buildKgSection(int savedKg) {
    final maxWidth = MediaQuery.sizeOf(context).width - MgSizes.md * 2;
    int maxKg = 30;
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("탄소절감량").bold().md(),
                Gaps.w4,
                BaseSvgIcon.helpCircle(
                  color: MgColorScheme.gray4,
                  size: MgSizes.lg,
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  height: MgSizes.size6,
                  width: maxWidth * (savedKg / maxKg),
                  decoration: BoxDecoration(
                    color: MgColorScheme.systemSuccess,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(MgRadius.md),
                      bottomLeft: Radius.circular(MgRadius.md),
                    ),
                  ),
                ),
                Container(
                  height: MgSizes.size6,
                  width: maxWidth,
                  decoration: BoxDecoration(
                    color: MgColorScheme.gray7,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ).margin(vertical: MgSizes.xs),
            MgTextRich(
              textAlign: TextAlign.start,
              children: [
                TextSpan(text: "지금까지 ").textGray(),
                TextSpan(text: "${savedKg}kg").subpointGreen().bold(),
                TextSpan(text: "의 탄소가 절감되었습니다").textGray(),
              ],
            ),
          ],
        )
        .margin(vertical: MgSizes.lg, horizontal: MgSizes.md)
        .decorated(
          color: MgColorScheme.gray10,
          borderRadius: BorderRadius.circular(MgRadius.sm),
        );
  }

  Widget _buildProfileSection() {
    final userState = ref.read(userStateProvider).asData!.value;
    if (userState == null) return SizedBox.shrink();

    return Row(
      children: [
        UserProfileItem(),
        Gaps.w16,
        Column(
          children: [
            Text(userState!.nickName),
            // TODO[mypage]:전화번호
          ],
        ),
      ],
    ).margin(vertical: MgSizes.size10);
  }

  Widget _buildMenuList() {
    return Column(
      children: [
        _buildMenuListItem(
          title: "관심목록",
          leading: BaseSvgIcon.heart(),
          onTap: () async => FavoriteRoute().push(context),
        ),
        _buildMenuListItem(
          title: "리뷰관리",
          leading: BaseSvgIcon.messageCircle(),
          onTap: () => MyReviewListRoute().push(context),
        ),
        _buildMenuListItem(
          title: "1:1 문의하기",
          leading: BaseSvgIcon.heart(),
          onTap: () => InquiryButton.showInquiryBottomSheet(context),
        ),
      ].joinWithWidget(const Divider()),
    );
  }

  Widget _buildMenuListItem({
    required String title,
    required Widget leading,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          leading,
          Gaps.w12,
          Text(title).md().regular(),
          const Spacer(),
          BaseSvgIcon.right(color: MgColorScheme.gray6),
        ],
      ).margin(vertical: MgSizes.md, horizontal: MgSizes.sm),
    );
  }

  Widget _buildAuthSection() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MgButton(
          onPressed: () => logout(ref, context),
          content: Text("로그아웃").textGray().regular().sm(),
        ),
        Text("|").textGray().margin(horizontal: MgSizes.xss),
        MgButton(
          onPressed: () => withDraw(ref, context),
          content: Text("회원탈퇴").textGray().regular().sm(),
        ),
      ],
    );
  }

  Widget _buildVersionSection() {
    return Column(
      children: [
        Text('v$_version').sm().textGray(),
        if (!ShorebirdManager.isAvailable && Environment.instance.isDev) ...[
          Gaps.h8,
          Text('코드 푸시가 비활성화되어 있습니다.').sm().textGray().regular(),
          if (_patchNumber != null) ...[Gaps.h8, Text('Patch #$_patchNumber')],
        ],
      ],
    );
  }

  Widget _buildDeveloperSection() {
    final showVisualLoggerAsync = ref.watch(visualLoggerVisibilityProvider);

    return Container(
      decoration: BoxDecoration(
        color: MgColorScheme.gray10,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text('개발자 옵션').lg().bold(),
          Gaps.h12,
          MgAsyncAnimatedSwitcher<bool>(
            asyncValue: showVisualLoggerAsync,
            loadingBuilder: () => const SizedBox.shrink(),
            errorBuilder: (_, __) => const SizedBox.shrink(),
            builder: (showVisualLogger) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Visual Logger').md(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(showVisualLogger ? '보임' : '안보임').sm().textGray(),
                    Gaps.w8,
                    Switch(
                      value: showVisualLogger,
                      onChanged: (value) {
                        ref
                            .read(visualLoggerVisibilityProvider.notifier)
                            .setVisible(value);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ).margin(all: MgSizes.md),
    );
  }
}
