import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/price_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/features/goods/domain/entities/goods.dart';
import 'package:magambell/src/features/order/presentation/order_caution_screen.dart';
import 'package:magambell/src/features/order/presentation/order_pay_screen.controller.dart';
import 'package:magambell/src/features/store/presentation/widget/store_bite_bag_view.dart';
import 'package:magambell/src/features/store/presentation/widget/store_info_view.dart';
import 'package:magambell/src/features/store/presentation/widget/store_review_list_view.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_button.dart';

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
  void setCount(bool isAdd) => setState(
    () => count = isAdd
        ? count + 1
        : count > 1
        ? count - 1
        : 1,
  );
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
    final store = mockStore;
    return BaseScaffold(
      appBar: BaseAppBar(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: StoreInfoView(store: store, id: widget.id),
          ),
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
      bottomNavigationBar: _buildBottomButton(store),
    );
  }

  Widget _buildBottomButton(Goods store) {
    return SafeArea(
          child: Row(
            children: [
              Expanded(
                child:
                    Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: BaseSvgIcon.minus(),
                              onTap: () => setCount(false),
                            ),
                            Text('$count').md().margin(
                              horizontal: MgSizes.xxl,
                            ), // NOTE: 다량 구매 고객 많을시 숫자 선택 bottomSheet 나오도록F
                            GestureDetector(
                              child: BaseSvgIcon.plus(),
                              onTap: () => setCount(true),
                            ),
                          ],
                        )
                        .margin(all: MgSizes.sm)
                        .decorated(
                          color: MgColorScheme.gray8,
                          borderRadius: BorderRadius.circular(8),
                        ),
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
                          totalPrice: store.salePrice * count,
                          salePrice: store.salePrice,
                          originalPrice: store.originPrice.toDouble(),
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
