import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/list_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/navigator/navigator_controller.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/utils/kakao_share_util.dart';
import 'package:magambell/src/features/address/domain/entities/address.dart';
import 'package:magambell/src/features/address/presentation/select_service_region_screen.dart';
import 'package:magambell/src/features/home/presentation/widgets/home_banners_view.dart';
import 'package:magambell/src/features/home/presentation/widgets/home_unsupported_area_view.dart';
import 'package:magambell/src/features/home/presentation/widgets/home_update_banner.dart';
import 'package:magambell/src/features/user/presentation/widgets/login_user_alert_dialog.dart';
import 'package:magambell/src/features/user/providers/user.provider.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/features/home/presentation/home_screen.controller.dart';
import 'package:magambell/src/features/home/presentation/widgets/home_goods_item.dart';
import 'package:magambell/src/features/store/domain/sort_type.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';
import 'package:magambell/src/widgets/mg_bottomsheet.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/mg_checkbox.dart';
import 'package:magambell/src/widgets/mg_tag.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final controllerStateAsync = ref.watch(homeScreenControllerProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        final tabIndex = ref.read(navigatorControllerProvider).tabIndex;
        if (tabIndex == 0) {
          SystemNavigator.pop();
        } else {
          ref.read(navigatorControllerProvider.notifier).changeTabIndex(0);
        }
      },
      child: MgAsyncAnimatedSwitcher(
        asyncValue: controllerStateAsync,
        builder: (controllerState) {
          return SafeArea(
            // TODO: BaseCustomScrollView refact
            child: RefreshIndicator(
              onRefresh: () async {
                ref.refresh(homeScreenControllerProvider);
              },
              child: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: _HomeAppBar(
                      controllerState.serviceAddresses,
                      controllerState.defaultAddress,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Column(
                        children: [
                          HomeBannersView(),
                          HomeUpdateBanner(),
                          _buildFilterSection(
                            controllerState.onlyAvailable,
                            controllerState.sortType,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controllerState.storeGoodsList.length,
                            separatorBuilder: (context, index) => Gaps.h16,
                            itemBuilder: (context, index) {
                              final item = controllerState.storeGoodsList[index];
                              return HomeGoodsItem(goods: item.toHomeGoodsItem())
                                  .margin(bottom: MgSizes.xs)
                                  .margin(horizontal: MgSizes.md);
                            },
                          ),
                        ],
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
    
    

  Widget _buildFilterSection(bool onlyAvailable, SortType sortType) {
    return Row(
      children: [
        MgCheckbox(
          initialValue: onlyAvailable,
          onChanged: (value) => ref
              .read(homeScreenControllerProvider.notifier)
              .toggleOnlyAvailable(),
          trailing: Text("예약가능").sm().margin(left: MgSizes.xs),
        ).margin(all: MgSizes.md),

        Spacer(),
        GestureDetector(
          onTap: () async {
            await MgBottomsheet.show(context, (context, bottomState) {
              return _buildSortBottomSheet(sortType);
            });
          },
          child: MgTag(
            // paddingWidth: 0,
            paddingWidth: MgSizes.md,
            suffix: BaseSvgIcon.down(size: 16),
            child: Text(sortType.name).sm(),
          ).transparent(),
        ),
      ],
    );
  }

  Widget _buildSortBottomSheet(SortType currentSortType) {
    final List<String> sorts = SortType.values
        .where((e) => e != SortType.distanceAsc && e != SortType.ratingDesc)
        .map((e) => e.name)
        .toList();
    return MgBottomsheet(
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("정렬").md().bold().margin(vertical: MgSizes.md),
          ...sorts
              .map(
                (e) => _buildSortBottomSheetItem(
                  e,
                  isSelect: currentSortType.name == e,
                ),
              )
              .joinWithWidget(Divider()),
        ],
      ),
    );
  }

  Widget _buildSortBottomSheetItem(String title, {bool isSelect = false}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        ref
            .read(homeScreenControllerProvider.notifier)
            .setSortType(SortType.values.firstWhere((e) => e.name == title));
        Navigator.of(context).pop();
      },
      child: Stack(
        children: [
          Center(child: Text(title).sm()),
          if (isSelect)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: BaseSvgIcon.check(size: 20),
            ),
        ],
      ).margin(vertical: MgSizes.sm, horizontal: MgSizes.md),
    );
  }
}

class _HomeAppBar extends SliverPersistentHeaderDelegate {
  _HomeAppBar(this.serviceAddresses, this.defaultAddress);

  final Address? defaultAddress;
  final List<Address> serviceAddresses;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return _HomeAppBarContent(
      defaultAddress: defaultAddress,
      serviceAddresses: serviceAddresses,
    );
  }

  @override
  double get minExtent => kToolbarHeight;
  @override
  double get maxExtent => minExtent;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class _HomeAppBarContent extends ConsumerStatefulWidget {
  const _HomeAppBarContent({
    required this.defaultAddress,
    required this.serviceAddresses,
  });

  final List<Address> serviceAddresses;
  final Address? defaultAddress;

  @override
  ConsumerState<_HomeAppBarContent> createState() => _HomeAppBarContentState();
}

class _HomeAppBarContentState extends ConsumerState<_HomeAppBarContent> {
  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SvgPicture.asset(R.ASSETS_ICONS_SVG_HOME_LOGO_SVG, height: 30),
            _buildAddress(widget.serviceAddresses),
            // TODO: 런칭 이후 추가
            //  _buildSearch(),
          ],
        )
        .margin(vertical: MgSizes.md)
        .margin(horizontal: MgSizes.md)
        .colored(MgColorScheme.gray11);
  }

  // TODO[tooltip]: 주소 변경시 tooltip 표시
  Widget _buildAddress(List<Address> serviceAreas) {
    return GestureDetector(
      onTap: () async => showAddressBottomSheet(serviceAreas),
      child: Row(
        children: [
          BaseSvgIcon.mapPin(size: 20),
          Gaps.w8,
          Text(widget.defaultAddress?.name ?? '주소를 설정해주세요'),
        ],
      ),
    );
  }

  Future<void> showAddressBottomSheet(List<Address> serviceAreas) async {
    final user = ref.read(userStateProvider).asData!.value;
    final isLogin = user != null;
    if (!isLogin) {
      unawaited(showLoginAlerDialog(context));
      return;
    }
    final shouldOpenRegionRequest = await MgBottomsheet.show<bool>(
      context,
      (context, bottomState) => _buildAddressBottomSheet(serviceAreas),
    );

    if (shouldOpenRegionRequest == true && mounted) {
      final result = await SelectServiceRegionRoute().push<bool>(context);
      if (result == true && mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (!mounted) return;
          await showDialog(
            context: context,
            builder: (context) => HomeUnsupportedAreaView.share(
              onPressed: KakaoShareUtil.shareOpenRegionRequest,
            ),
          );
        });
      }
    }
  }

  Widget _buildAddressBottomSheet(List<Address> serviceAreas) {
    return MgBottomsheet(
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("픽업 가능한 지역").md().bold().margin(vertical: MgSizes.xl),

          // 서비스 가능 지역만 표시
          ...serviceAreas.map(
            (address) => _buildAddressBottomSheetItem(
              address,
              isSelect: widget.defaultAddress?.label == address.label,
            ),
          ),

          Gaps.h16,
          MgButton(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BaseSvgIcon.helpCirlce(
                  color: MgColorScheme.gray5,
                  size: MgSizes.lg,
                ),
                Gaps.w4,
                Text("원하는 지역이 없어요").sm().textGray().regular(),
              ],
            ),
            onPressed: () => Navigator.pop(context, true),
          ).transparent(),
        ],
      ).margin(all: MgSizes.md),
    );
  }

  Widget _buildAddressBottomSheetItem(
    Address address, {
    bool isSelect = false,
  }) {
    return GestureDetector(
      onTap: () {
        ref.read(homeScreenControllerProvider.notifier).saveToStorage(address);
        context.pop();
      },
      child:
          Row(
                children: [
                  BaseSvgIcon.mapPin(size: 20),
                  Text(
                    address.label,
                  ).md().margin(left: MgSizes.sm, right: MgSizes.xs),
                  if (isSelect) ...[Spacer(), BaseSvgIcon.check(size: 20)],
                ],
              )
              .margin(all: MgSizes.md)
              .decorated(
                border: isSelect
                    ? Border.all(color: MgColorScheme.gray4, width: 1)
                    : null,
                borderRadius: BorderRadius.circular(16),
                color: isSelect ? MgColorScheme.gray10 : null,
              ),
    );
  }

  // Widget _buildSearch() {
  //   return GestureDetector(
  //     onTap: () async => SearchRoute().push(context),
  //     child: BaseSvgIcon.search(size: 24),
  //   );
  // }
}
