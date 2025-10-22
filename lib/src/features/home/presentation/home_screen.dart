import 'package:flutter/material.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/features/home/presentation/widgets/home_banners_view.dart';
import 'package:magambell/src/features/home/presentation/widgets/home_goods_item.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          // SliverToBoxAdapter(
          //   child: Column(
          //     children: [
          //       Row(children: [Checkbox(value: true, onChanged: (value) => {})]),
          //       Expanded(
          //         child: ListView.builder(
          //           itemCount: 3,
          //           itemBuilder: (context, index) {
          //             return HomeGoodsItem().margin(all: MgSizes.md);
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          SliverList(
            delegate: SliverChildListDelegate([
              HomeBannersView(),
              // TODO[home]: 2.필터
              Row(children: [Checkbox(value: true, onChanged: (value) => {})]),
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
        // TODO: checkbox
      ],
    );
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
