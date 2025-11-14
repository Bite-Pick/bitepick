import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/list_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/address/domain/entities/address.dart';
import 'package:magambell/src/features/address/presentation/search_address_screen.dart';
import 'package:magambell/src/features/address/presentation/search_address_screen.controller.dart';
import 'package:magambell/src/features/home/presentation/widgets/home_unsupported_area_view.dart';
import 'package:magambell/src/features/home/presentation/widgets/home_update_banner.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/features/goods/domain/entities/goods.dart';
import 'package:magambell/src/features/home/presentation/home_screen.controller.dart';
import 'package:magambell/src/features/home/presentation/widgets/home_goods_item.dart';
import 'package:magambell/src/features/search/presentation/search_screen.dart';
import 'package:magambell/src/features/store/data/repositories/store_repository.dart';
import 'package:magambell/src/features/store/domain/sort_type.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';
import 'package:magambell/src/widgets/mg_bottomsheet.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/mg_tag.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final HomeScreenState(:onlyAvailable, :sortType) = ref.watch(
      homeScreenControllerProvider,
    );
    final defaultAddress = ref
        .watch(searchAddressScreenControllerProvider)
        .addresses
        .where((a) => a.isDefault)
        .firstOrNull;

    final storeGoodsAsync = ref.watch(
      storeGoodsListProvider(
        latitude: 37.5185663, // TODO: 기본 위치 설정 필요
        longitude: 127.0230599,
        // latitude: defaultAddress?.longitude ?? 37.5185663,
        // longitude: defaultAddress?.latitude ?? 127.0230599,
        onlyAvailable: onlyAvailable,
        sortType: sortType,
      ),
    );
    return SafeArea(
      // TODO: BaseCustomScrollView refact
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: _HomeAppBar(serviceAreas, defaultAddress),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              // HomeBannersView(),
              HomeUpdateBanner(),
              MgAsyncAnimatedSwitcher<List<Goods>>(
                asyncValue: storeGoodsAsync,
                builder: (goods) => Column(
                  children: [
                    _buildFilterSection(onlyAvailable, sortType),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: goods.length,
                      itemBuilder: (context, index) {
                        final item = goods[index];
                        return HomeGoodsItem(goods: item)
                            .margin(bottom: MgSizes.xs)
                            .margin(horizontal: MgSizes.md);
                      },
                    ),
                  ],
                ),
                emptyBuilder: () =>
                    HomeUnsupportedAreaView.openRequest(), // TODO[open]: flag에 따라 다른 화면
                loadingBuilder: () =>
                    const Center(child: CircularProgressIndicator()),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(bool onlyAvailable, SortType sortType) {
    return Row(
      children: [
        // TODO: icon padding 조정 필요
        Checkbox(
          value: onlyAvailable,
          onChanged: (value) => ref
              .read(homeScreenControllerProvider.notifier)
              .toggleOnlyAvailable(),
        ),
        Text("예약가능").sm(),
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
    final List<String> sorts = SortType.values.map((e) => e.name).toList();
    return MgBottomsheet(
      Column(
        children: sorts
            .map(
              (e) => _buildSortBottomSheetItem(
                e,
                isSelect: currentSortType.name == e,
              ),
            )
            .toList()
            .joinWithWidget(Divider()),
      ),
    );
  }

  Widget _buildSortBottomSheetItem(String title, {bool isSelect = false}) {
    return GestureDetector(
      onTap: () {
        ref
            .read(homeScreenControllerProvider.notifier)
            .setSortType(SortType.values.firstWhere((e) => e.name == title));
        Navigator.of(context).pop();
      },
      // TODO: 터치영역 확장 필요
      child: Center(
        child: Row(
          children: [
            Text(title).md(),
            if (isSelect) ...[Spacer(), BaseSvgIcon.check(size: 20)],
          ],
        ).margin(vertical: MgSizes.sm, horizontal: MgSizes.md),
      ).padding(all: MgSizes.md),
    );
  }
}

class _HomeAppBar extends SliverPersistentHeaderDelegate {
  _HomeAppBar(this.addresses, this.defaultAddress);

  final List<Address> addresses;
  final Address? defaultAddress;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return _HomeAppBarContent(
      addresses: addresses,
      defaultAddress: defaultAddress,
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
    required this.addresses,
    required this.defaultAddress,
  });

  final List<Address> addresses;
  final Address? defaultAddress;

  @override
  ConsumerState<_HomeAppBarContent> createState() => _HomeAppBarContentState();
}

class _HomeAppBarContentState extends ConsumerState<_HomeAppBarContent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildAddress(), _buildSearch()],
    ).margin(vertical: MgSizes.md).margin(horizontal: MgSizes.md);
  }

  // TODO[tooltip]: 주소 변경시 tooltip 표시
  Widget _buildAddress() {
    return GestureDetector(
      onTap: () async {
        await MgBottomsheet.show(
          context,
          (context, bottomState) => _buildAddressBottomSheet(),
        );
      },
      child: Row(
        children: [
          BaseSvgIcon.mapPin(size: 20),
          Gaps.w8,
          Text(widget.defaultAddress?.name ?? '주소를 설정해주세요'),
        ],
      ),
    );
  }

  Widget _buildAddressBottomSheet() {
    return MgBottomsheet(
      Column(
        children: [
          Text("선택가능한 주소").md().bold().margin(vertical: MgSizes.xl),
          ...widget.addresses.map(
            (address) => _buildAddressBottomSheetItem(
              address,
              isSelect: widget.defaultAddress?.label == address.label,
            ),
          ),
          Gaps.h16,
          MgButton(
            content: Text("주소 직접 설정하기").sm().textGray().regular(),
            onPressed: () {
              context.pop();
              SearchAddressRoute().push(context);
            },
          ).transparent(),
          Text("현재 데이터가 많지않아 주소를 바꿔도 데이터변동은 없도록 임시처리해뒀습니다!"),
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
        ref
            .read(searchAddressScreenControllerProvider.notifier)
            .selectFromSaved(address);
        Navigator.of(context).pop();
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

  Widget _buildSearch() {
    return GestureDetector(
      onTap: () async => SearchRoute().push(context),
      child: BaseSvgIcon.search(size: 24),
    );
  }
}
