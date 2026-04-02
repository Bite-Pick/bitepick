import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/features/goods/data/dtos/goods_detail.dto.dart';
import 'package:magambell/src/features/notification/data/repositories/notification_repository.dart';
import 'package:magambell/src/features/order/presentation/order_caution_screen.dart';
import 'package:magambell/src/features/order/presentation/order_pay_screen.controller.dart';
import 'package:magambell/src/features/review/data/repositories/review_repository.dart';
import 'package:magambell/src/features/store/data/repositories/store_repository.dart';
import 'package:magambell/src/features/store/presentation/widget/store_bite_bag_view.dart';
import 'package:magambell/src/features/store/presentation/widget/store_info_view.dart';
import 'package:magambell/src/features/store/presentation/widget/store_review_list_view.dart';
import 'package:magambell/src/features/user/presentation/widgets/login_user_alert_dialog.dart';
import 'package:magambell/src/features/user/providers/user.provider.dart';
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

class _StoreScreenState extends ConsumerState<StoreScreen> {
  final _tabIndex = ValueNotifier<int>(0);

  @override
  void dispose() {
    _tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storeAsync = ref.watch(storeGoodsDetailProvider(widget.id));

    return MgAsyncAnimatedSwitcher<GoodsDetailDto?>(
      asyncValue: storeAsync,
      onRetry: () => ref.invalidate(storeGoodsDetailProvider(widget.id)),
      builder: (store) {
        if (store == null) return Center(child: Text("에러가 발생했습니다"));
        return BaseScaffold(
          appBar: BaseAppBar(),
          bottomNavigationBar: _BottomOrderBar(
            goods: store,
            storeId: widget.id,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              ref.refresh(storeGoodsDetailProvider(widget.id));
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: StoreInfoView(store.toStoreInfoData()),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                    ValueListenableBuilder<int>(
                      valueListenable: _tabIndex,
                      builder: (context, index, _) => _StoreTabBar(
                        goodsId: store.goodsId,
                        selectedIndex: index,
                        onTabChanged: (i) => _tabIndex.value = i,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ValueListenableBuilder<int>(
                    valueListenable: _tabIndex,
                    builder: (context, index, _) => IndexedStack(
                      index: index,
                      children: [
                        StoreBiteBagView(store.goodsImages ?? []),
                        StoreReviewListView(store.goodsId),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BottomOrderBar extends ConsumerStatefulWidget {
  const _BottomOrderBar({required this.goods, required this.storeId});

  final GoodsDetailDto goods;
  final String storeId;

  @override
  ConsumerState<_BottomOrderBar> createState() => _BottomOrderBarState();
}

class _BottomOrderBarState extends ConsumerState<_BottomOrderBar> {
  int count = 1;

  void setCount(int newCount) {
    setState(() {
      count = newCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final goods = widget.goods;
    final saleStatus = goods.saleStatus == "ON";
    final subscribedAsync = ref.watch(
      storeNotificationSubscribedProvider(storeId: widget.storeId),
    );
    final isSubscribed = subscribedAsync.asData?.value ?? false;
    final now = DateTime.now();
    final endTime = goods.endTime;
    final goodsStartTime = goods.startTime;
    final startTime =
        (now.hour * 3600 + now.minute * 60 + now.second) >
            (goodsStartTime.hour * 3600 +
                goodsStartTime.minute * 60 +
                goodsStartTime.second)
        ? now
        : goodsStartTime;

    return SafeArea(
      child: Row(
        children: [
          if (saleStatus) ...[
            Expanded(
              child: QuantityPicker(
                count: count,
                onCountChanged: setCount,
                maxCount: goods.quantity,
                onMaxReached: () {
                  ToastPresentor.error(
                    context,
                    "재고가 부족합니다. (남은 수량: ${goods.quantity}개)",
                  );
                },
              ),
            ),
            Gaps.w10,
          ],
          Expanded(
            child: MgButton(
              onPressed: () async {
                if (count > goods.quantity) {
                  ToastPresentor.error(
                    context,
                    "재고가 부족합니다. (남은 수량: ${goods.quantity}개)",
                  );
                  return;
                }
                final user = ref.read(userStateProvider).asData!.value;
                final isLogin = user != null;

                if (!isLogin) {
                  unawaited(showLoginAlerDialog(context));
                  return;
                }

                if (!saleStatus) {
                  if (isSubscribed) {
                    final res = await ref
                        .read(notificationRepositoryProvider)
                        .deleteNotificationToken(widget.storeId);
                    if (res && context.mounted) {
                      ToastPresentor.success(context, "알림 신청이 취소되었습니다");
                      ref.invalidate(storeNotificationSubscribedProvider(storeId: widget.storeId));
                    }
                  } else {
                    final res = await ref
                        .read(notificationRepositoryProvider)
                        .registerStoreNotification(storeId: widget.storeId);
                    if (res && context.mounted) {
                      ToastPresentor.success(context, "알림 신청 성공");
                      ref.invalidate(storeNotificationSubscribedProvider(storeId: widget.storeId));
                    }
                  }
                  return;
                }

                ref
                    .read(
                      orderPayScreenControllerProvider(goods.storeId).notifier,
                    )
                    .setOrderInfo(
                      storeName: goods.storeName,
                      storeAddress: goods.address,
                      storeId: goods.storeId,
                      goodsId: goods.goodsId,
                      quantity: count,
                      totalPrice: goods.salePrice * count,
                      salePrice: goods.salePrice,
                      originalPrice: goods.originalPrice,
                      startTime: startTime,
                      endTime: endTime,
                    );

                await OrderCautionRoute(storeId: goods.storeId).push(context);
              },
              content: Text(!saleStatus ? (isSubscribed ? '오픈 알림 취소하기' : '오픈 알림 신청하기') : '구매하기'),
            ).primary().copyWith(
              backgroundColor: !saleStatus && isSubscribed ? MgColorScheme.gray8 : null,
              textColor: !saleStatus && isSubscribed ? MgColorScheme.gray4 : null,
            ),
          ),
        ],
      ),
    ).margin(horizontal: MgSizes.md, vertical: MgSizes.md);
  }
}

class _StoreTabBar extends ConsumerWidget {
  const _StoreTabBar({
    required this.goodsId,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  final String goodsId;
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(
      reviewsProvider(goodsId: goodsId, imageCheck: false),
    );

    return MgAsyncAnimatedSwitcher(
      asyncValue: reviewsAsync,
      onRetry: () => ref.invalidate(reviewsProvider(goodsId: goodsId, imageCheck: false)),
      emptyBuilder: () => _buildTabBar(context, 0),
      builder: (reviews) => _buildTabBar(context, reviews.length),
    );
  }

  Widget _buildTabBar(BuildContext context, int reviewCount) {
    return DefaultTabController(
      length: 2,
      initialIndex: selectedIndex,
      child: TabBar(
        dividerColor: MgColorScheme.gray8,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        labelColor: MgColorScheme.gray1,
        unselectedLabelColor: MgColorScheme.gray5,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: MgColorScheme.gray1, width: 2),
        ),
        labelStyle: context.textTheme.titleLarge,
        unselectedLabelStyle: context.textTheme.bodyLarge,
        onTap: onTabChanged,
        tabs: [
          Tab(text: '상품 정보').margin(horizontal: MgSizes.md),
          Tab(text: '리뷰 $reviewCount'),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._child);

  final Widget _child;

  @override
  double get minExtent => 48.0;

  @override
  double get maxExtent => 48.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: MgColorScheme.gray11, child: _child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
