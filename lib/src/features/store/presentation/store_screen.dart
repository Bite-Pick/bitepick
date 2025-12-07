import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/features/goods/data/dtos/goods_detail.dto.dart';
import 'package:magambell/src/features/goods/presentation/widgets/time_picker_bottomsheet.dart';
import 'package:magambell/src/features/order/presentation/order_caution_screen.dart';
import 'package:magambell/src/features/order/presentation/order_pay_screen.controller.dart';
import 'package:magambell/src/features/store/data/repositories/store_repository.dart';
import 'package:magambell/src/features/store/presentation/widget/store_bite_bag_view.dart';
import 'package:magambell/src/features/store/presentation/widget/store_info_view.dart';
import 'package:magambell/src/features/store/presentation/widget/store_review_list_view.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/quantity_picker.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';

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
    final storeAsync = ref.watch(storeGoodsDetailProvider(widget.id));
    return MgAsyncAnimatedSwitcher<GoodsDetailDto?>(
      asyncValue: storeAsync,
      builder: (store) {
        if (store == null) return Center(child: Text("에러가 발생했습니다"));
        return BaseScaffold(
          appBar: BaseAppBar(),
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(child: StoreInfoView(store.toStoreInfoData())),
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
                      borderSide: BorderSide(
                        color: MgColorScheme.gray1,
                        width: 2,
                      ),
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
              children: [
                StoreBiteBagView(store.goodsImageList ?? []),
                StoreReviewListView(store.goodsId),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomButton(store),
        );
      },
    );
  }

  Widget _buildBottomButton(GoodsDetailDto goods) {
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
                    final _pickUpTime = await showTimeSelector(
                      // TODO: min(goods.startTime,DateTime.now()),
                      goods.startTime,
                      goods.endTime,
                    );
                    if (_pickUpTime == null) {
                      ToastPresentor.error(context, "픽업시간을 지정해주세요");
                      return;
                    }
                    // 주문 정보 저장
                    ref
                        .read(orderPayScreenControllerProvider.notifier)
                        .setOrderInfo(
                          storeName: goods.storeName,
                          storeAddress: goods.address,
                          storeId: goods.storeId,
                          goodsId: goods.goodsId,
                          quantity: count,
                          totalPrice: goods.salePrice * count,
                          salePrice: goods.salePrice,
                          originalPrice: goods.originalPrice,
                          pickupTime: _pickUpTime.toIso8601String(),
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

  Future<DateTime?> showTimeSelector(
    DateTime startTime,
    DateTime endTime,
  ) async {
    DateTime? _time;
    await TimePickerBottomSheet.show(
      context,
      initialTime: DateTime.now(),
      startTime: startTime,
      endTime: endTime,
      onTimeSelected: (selected, error) {
        if (error != null) {
          // 이론상 disabled라 안 들어오지만, 안전망으로 남겨둘 수 있음
          ToastPresentor.error(context, error);
          return;
        }

        // 정상 처리
        _time = selected;
      },
      // onSelectionChanged: (selected, errorMessage) {
      //   if (errorMessage != null) ToastPresentor.error(context, errorMessage);
      // },
    );
    return _time;
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
