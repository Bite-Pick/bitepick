import 'package:flutter/material.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/list_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/home/presentation/widgets/home_banners_view.dart';
import 'package:magambell/src/features/home/presentation/widgets/home_goods_item.dart';
import 'package:magambell/src/widgets/mg_bottomsheet.dart';
import 'package:magambell/src/widgets/mg_tag.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return HomeGoodsItem().margin(all: MgSizes.md);
                },
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
    final List<String> sorts = ["가격 낮은순", "가까운 거리순", "리뷰많은순"];
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
      children: [_buildAddress(), _buildSearch()],
    ).margin(all: MgSizes.md);
  }

  @override
  double get minExtent => kToolbarHeight;
  @override
  double get maxExtent => minExtent;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  Widget _buildAddress() {
    return Row(
      children: [
        Image.asset(R.ASSETS_ICONS_MAP_PIN_BORDER_PNG),
        Gaps.w8,
        Text("fdsfsfs"), // TODO: addreess
      ],
    );
  }

  Widget _buildSearch() {
    return GestureDetector(
      onTap: () {
        // TODO: goto Search Page
      },
      child: Image.asset(R.ASSETS_ICONS_SEARCH_PNG),
    );
  }
}
