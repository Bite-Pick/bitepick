import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/list_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/home/domain/entity/goods.dart';
import 'package:magambell/src/features/home/presentation/widgets/home_banners_view.dart';
import 'package:magambell/src/features/home/presentation/widgets/home_goods_item.dart';
import 'package:magambell/src/features/store/data/repositories/store_repository.dart';
import 'package:magambell/src/features/store/domain/sort_type.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';
import 'package:magambell/src/widgets/mg_bottomsheet.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/mg_tag.dart';
// import 'package:magambell/src/core/router/app_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: _HomeAppBar(),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              HomeBannersView(),
              _buildFilterSection(),
              MgAsyncAnimatedSwitcher<List<Goods>>(
                asyncValue: ref.watch(
                  storeGoodsListProvider(
                    latitude: 37.5185663,
                    longitude: 127.0230599,
                  ),
                ),
                builder: (goods) => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: goods.length,
                  itemBuilder: (context, index) {
                    final item = goods[index];
                    return HomeGoodsItem(goods: item).margin(all: MgSizes.md);
                  },
                ),
                emptyBuilder: () => const Center(
                  child: Text('상품이 없습니다'),
                ).margin(all: MgSizes.md),
                loadingBuilder: () => const Center(
                  child: CircularProgressIndicator(),
                ).margin(all: MgSizes.md),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Row(
      children: [
        Checkbox(value: true, onChanged: (value) => {}),
        Text("예약가능").sm(),
        Spacer(),
        GestureDetector(
          onTap: () async {
            await MgBottomsheet.show(context, (context, bottomState) {
              return _buildSortBottomSheet();
            });
          },
          child: MgTag(
            suffix: Image.asset(R.ASSETS_ICONS_CHEVRON_DOWN_PNG),
            child: Text("정렬").sm(),
          ).transparent(),
        ),
      ],
    );
  }

  // TODO: class로 따로 빼기
  Widget _buildSortBottomSheet() {
    final List<String> sorts = SortType.values.map((e) => e.name).toList();
    return MgBottomsheet(
      Column(
        children: sorts
            .map((e) => _buildSortBottomSheetItem(e))
            .toList()
            .joinWithWidget(Divider()),
      ),
    );
  }

  Widget _buildSortBottomSheetItem(String title) {
    return Center(child: Text(title).md().margin(vertical: MgSizes.sm));
  }
}

class _HomeAppBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildAddress(context), _buildSearch(context)],
    ).margin(all: MgSizes.md);
  }

  @override
  double get minExtent => kToolbarHeight;
  @override
  double get maxExtent => minExtent;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  Widget _buildAddress(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await MgBottomsheet.show(
          context,
          (context, bottomState) => _buildAddressBottomSheet(),
        );
      },
      child: Row(
        children: [
          Image.asset(R.ASSETS_ICONS_MAP_PIN_BORDER_PNG),
          Gaps.w8,
          Text("fdsfsfs"), // TODO: addreess
        ],
      ),
    );
  }

  Widget _buildAddressBottomSheet() {
    List<String> address = ["대구 양천구 목동", "필라델피아 올드시티주F"];
    return MgBottomsheet(
      Column(
        children: [
          // TODO:isSelect 선택적으로 활성화
          ...address.map((e) => _buildAddressBottomSheetItem(e)),
          MgButton(
            content: Text("주소 직접 설정하기").sm().textGray(),
            onPressed: () {
              // TODO: 주소 설정 페이지로 이동
            },
          ).transparent(),
        ],
      ).margin(all: MgSizes.md),
    );
  }

  Widget _buildAddressBottomSheetItem(String address, {bool isSelect = false}) {
    return Row(
          children: [
            Image.asset(R.ASSETS_ICONS_MAP_PIN_BORDER_PNG),
            Text(address).md().margin(left: MgSizes.sm, right: MgSizes.xs),
            if (isSelect) ...[
              MgTag(child: Text("설정된주소")).primary(),
              Spacer(),
              Image.asset(R.ASSETS_ICONS_CHECK_PNG),
            ],
          ],
        )
        .margin(all: MgSizes.md)
        .decorated(
          border: isSelect
              ? Border.all(color: MgColorScheme.gray4, width: 1)
              : null,
          borderRadius: BorderRadius.circular(16),
        );
  }

  Widget _buildSearch(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // await SearchRoute().push(context);
      },
      child: Image.asset(R.ASSETS_ICONS_SEARCH_PNG),
    );
  }
}
