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
import 'package:magambell/src/features/home/presentation/widgets/home_filter_bar.dart';
import 'package:magambell/src/features/home/presentation/widgets/home_goods_item.dart';
import 'package:magambell/src/features/store/domain/sort_type.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';
import 'package:magambell/src/widgets/mg_bottomsheet.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      ref.read(homeScreenControllerProvider.notifier).loadMore();
    }
  }

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
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        child: MgAsyncAnimatedSwitcher(
          asyncValue: controllerStateAsync,
          onRetry: () => ref.invalidate(homeScreenControllerProvider),
          builder: (controllerState) {
            return SafeArea(
              // TODO: BaseCustomScrollView refact
              child: RefreshIndicator(
                onRefresh: () async {
                  ref.refresh(homeScreenControllerProvider);
                },
                child: CustomScrollView(
                  controller: _scrollController,
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
                            const SizedBox(height: 4),
                            HomeBannersView(),
                            HomeUpdateBanner(),
                            HomeFilterBar(
                              onlyAvailable: controllerState.onlyAvailable,
                              sortType: controllerState.sortType,
                              showFilter: true,
                              onToggleAvailable: () => ref
                                  .read(homeScreenControllerProvider.notifier)
                                  .toggleOnlyAvailable(),
                              onSortTap: () async {
                                await MgBottomsheet.show(
                                  context,
                                  (context, bottomState) =>
                                      _buildSortBottomSheet(
                                        controllerState.sortType,
                                      ),
                                );
                              },
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controllerState.storeGoodsList.length,
                              separatorBuilder: (context, index) => Gaps.h4,
                              itemBuilder: (context, index) {
                                final item =
                                    controllerState.storeGoodsList[index];
                                return HomeGoodsItem(
                                      goods: item.toHomeGoodsItem(),
                                    )
                                    .margin(bottom: MgSizes.xs)
                                    .margin(horizontal: MgSizes.md);
                              },
                            ),
                            if (controllerState.isLoadingMore)
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            if (!controllerState.hasMore &&
                                controllerState.storeGoodsList.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                child: Center(
                                  child: Text('bitepick').sm().textGray(),
                                ),
                              ),
                            const _BusinessInfoSection(),
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
      ),
    );
  }

  Widget _buildSortBottomSheet(SortType currentSortType) {
    final List<String> sorts = SortType.values
        .where((e) => e != SortType.distanceAsc)
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

class _BusinessInfoSection extends StatelessWidget {
  const _BusinessInfoSection();

  @override
  Widget build(BuildContext context) {
    const infoStyle = TextStyle(fontSize: 13, color: Color(0xFF888888));
    const labelStyle = TextStyle(
      fontSize: 13,
      color: Color(0xFF888888),
      fontWeight: FontWeight.w600,
    );

    Widget row(String label, String value) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: '$label: ', style: labelStyle),
              TextSpan(text: value, style: infoStyle),
            ],
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      color: const Color(0xFFF5F5F5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '사업자 정보',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 16),
          row('상호', '바이트픽'),
          row('대표자', '김강민'),
          row('사업자등록번호', '515-62-00946'),
          row('통신판매업', '2025-용인수지-1423'),
          row('고객센터', '010-8859-9948'),
          row('사업장', '경기도 용인시 수지구 죽전로 152 글로컬산학협력관 B211호'),
        ],
      ),
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
    return HomeAppBarContent(
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

class HomeAppBarContent extends ConsumerStatefulWidget {
  const HomeAppBarContent({
    super.key,
    required this.defaultAddress,
    required this.serviceAddresses,
  });

  final List<Address> serviceAddresses;
  final Address? defaultAddress;

  @override
  ConsumerState<HomeAppBarContent> createState() => _HomeAppBarContentState();
}

class _HomeAppBarContentState extends ConsumerState<HomeAppBarContent> {
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

  String _shortAddressName(String fullName) {
    final parts = fullName.split(' ');
    final city = parts.firstWhere(
      (p) => p.endsWith('시'),
      orElse: () => parts.first,
    );
    return '$city ${parts.last}';
  }

  // TODO[tooltip]: 주소 변경시 tooltip 표시
  Widget _buildAddress(List<Address> serviceAreas) {
    final addressText = widget.defaultAddress != null
        ? _shortAddressName(widget.defaultAddress!.name)
        : '주소를 설정해주세요';
    return GestureDetector(
      onTap: () async => showAddressBottomSheet(serviceAreas),
      child: Row(
        children: [
          Text(
            addressText,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1.5,
              letterSpacing: -0.4,
            ),
          ),
          Gaps.w4,
          BaseSvgIcon.down(size: 16),
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
