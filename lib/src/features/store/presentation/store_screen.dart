import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/features/goods/domain/entities/goods.dart';
import 'package:magambell/src/features/order/presentation/order_caution_screen.dart';
import 'package:magambell/src/features/order/presentation/order_pay_screen.controller.dart';
import 'package:magambell/src/features/store/presentation/widget/store_bite_bag_view.dart';
import 'package:magambell/src/features/store/presentation/widget/store_info_view.dart';
import 'package:magambell/src/features/store/presentation/widget/store_review_list_view.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/quantity_picker.dart';

class StoreRoute extends GoRouteData {
  const StoreRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return StoreScreen(id: id);
  }
}

class StoreScreen extends ConsumerStatefulWidget {
  const StoreScreen({super.key, required this.id});

  final String id;

  @override
  ConsumerState<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends ConsumerState<StoreScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int count = 1;
  void setCount(int newCount) => setState(() => count = newCount);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final store = ref.watch(storeGoodsDetailProvider(id));
    final goods = mockGoods;
    return BaseScaffold(
      appBar: BaseAppBar(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(child: StoreInfoView(goods: goods)),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              TabBar(
                dividerColor: Colors.transparent,
                controller: _tabController,
                labelColor: MgColorScheme.text,
                unselectedLabelColor: MgColorScheme.gray5,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: MgColorScheme.gray1, width: 2),
                ),
                labelStyle: context.textTheme.titleLarge,
                unselectedLabelStyle: context.textTheme.bodyLarge,
                tabs: [
                  Tab(text: '상품 정보').margin(horizontal: MgSizes.md),
                  Tab(text: '리뷰'),
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [StoreBiteBagView(), StoreReviewListView(widget.id)],
        ),
      ),
      bottomNavigationBar: _buildBottomButton(goods),
    );
  }

  Widget _buildBottomButton(Goods goods) {
    return SafeArea(
          child: Row(
            children: [
              Expanded(
                child: QuantityPicker(count: count, onCountChanged: setCount),
              ),
              Gaps.w10,
              Expanded(
                child: MgButton(
                  onPressed: () async {
                    // 주문 정보 저장
                    ref
                        .read(orderPayScreenControllerProvider.notifier)
                        .setOrderInfo(
                          goodsId: widget.id,
                          quantity: count,
                          totalPrice: goods.salePrice * count,
                          salePrice: goods.salePrice,
                          originalPrice: goods.originPrice.toDouble(),
                        );
                    // 주문 확인 화면으로 이동
                    await const OrderCautionRoute().push(context);
                  },
                  content: Text('구매하기'),
                ).primary(),
              ),
            ],
          ),
        )
        .constrained(height: 85)
        .margin(horizontal: MgSizes.md, vertical: MgSizes.md);
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: MgColorScheme.white, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
