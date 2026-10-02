
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/list_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/navigator/navigator_controller.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/home/presentation/widgets/home_banners_view.dart';
import 'package:magambell/src/features/home/presentation/widgets/home_update_banner.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/features/home/presentation/home_screen.controller.dart';
import 'package:magambell/src/features/home/presentation/widgets/home_filter_bar.dart';
import 'package:magambell/src/features/home/presentation/widgets/home_goods_item.dart';
import 'package:magambell/src/features/store/domain/sort_type.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';
import 'package:magambell/src/widgets/mg_bottomsheet.dart';

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
                  try {
                    ref.invalidate(homeScreenControllerProvider);
                    await ref.read(homeScreenControllerProvider.future);
                  } catch (_) {
                    // 에러 상태는 MgAsyncAnimatedSwitcher가 표시한다.
                  }
                },
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
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
                              itemCount: controllerState.visibleStores.length,
                              separatorBuilder: (context, index) => Gaps.h4,
                              itemBuilder: (context, index) {
                                final item =
                                    controllerState.visibleStores[index];
                                return HomeGoodsItem(
                                      goods: item.toHomeGoodsItem(),
                                    )
                                    .margin(bottom: MgSizes.xs)
                                    .margin(horizontal: MgSizes.md);
                              },
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
        .where((e) => e == SortType.distanceAsc || e == SortType.priceAsc)
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

  static const double _mapViewButtonClearance = 52;

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
      padding: const EdgeInsets.fromLTRB(
        20,
        24,
        20,
        24 + _mapViewButtonClearance,
      ),
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
