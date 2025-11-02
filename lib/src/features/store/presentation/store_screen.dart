import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
import 'package:magambell/src/core/extensions/price_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/features/favorite/data/repositories/favorite_repository.dart';
import 'package:magambell/src/features/home/domain/entities/goods.dart';
import 'package:magambell/src/features/order/presentation/order_caution_screen.dart';
import 'package:magambell/src/features/order/presentation/order_pay_screen.controller.dart';
import 'package:magambell/src/features/store/presentation/widget/store_info_view.dart';
import 'package:magambell/src/features/store/presentation/widget/store_review_list_view.dart';
import 'package:magambell/src/features/store/presentation/widget/store_tags.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_map_view.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';
import 'package:magambell/src/widgets/mg_bottomsheet.dart';
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
    final store = mockData;
    return BaseScaffold(
      appBar: BaseAppBar(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildThumbnailImageView(store),
                _buildStoreDescriptionSection(store),
                Divider(thickness: MgSizes.size6).margin(vertical: MgSizes.lg),
                _buildStoreLocationInfoSection(store),
                Divider(thickness: MgSizes.size6).margin(vertical: MgSizes.lg),
              ],
            ),
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
          children: [StoreInfoView(), StoreReviewListView(widget.id)],
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
                    ref.read(orderPayScreenControllerProvider.notifier).setOrderInfo(
                          goodsId: widget.id,
                          quantity: count,
                          totalPrice: store.salePrice * count,
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

  Widget _buildThumbnailImageView(Goods store) {
    if (store.ImageUrl.isEmpty) {
      return Container(
        height: 300,
        color: MgColorScheme.gray2,
        child: Center(child: Text('이미지 없음').textGray()),
      );
    }

    return SizedBox(
      height: 240,
      child: Swiper(
        autoplay: true,
        autoplayDelay: 4000,
        loop: store.ImageUrl.length > 1,
        itemCount: store.ImageUrl.length,
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            activeColor: MgColorScheme.primary,
            color: MgColorScheme.gray4,
          ),
        ),
        itemBuilder: (context, index) {
          final imageUrl = store.ImageUrl[index];
          if (imageUrl.isEmpty) {
            return Container(
              color: MgColorScheme.gray2,
              child: Center(child: Text('이미지 없음').textGray()),
            );
          }
          return CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover);
        },
      ),
    );
  }

  Widget _buildStoreDescriptionSection(Goods store) {
    final favoriteAsync = ref.watch(favoriteProvider(storeId: widget.id));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            StoreTags(quantity: store.quantity, saleStatus: store.saleStatus),
            // TODO[review]: 리뷰영역으로 스크롤내리는 버튼 추가
            Spacer(),
            GestureDetector(
              onTap: () async {
                final repo = ref.read(favoriteRepositoryProvider);
                final currentFavorite = favoriteAsync.asData?.value;
                currentFavorite == true
                    ? await repo.removeFavorite(widget.id)
                    : await repo.addFavorite(widget.id);
                ref.invalidate(favoriteProvider(storeId: widget.id));
              },
              child: MgAsyncAnimatedSwitcher(
                asyncValue: favoriteAsync,
                builder: (isFavorite) {
                  return (isFavorite == true)
                      ? BaseSvgIcon.heartFilled(
                          color: MgColorScheme.navigationPrimary,
                        )
                      : BaseSvgIcon.heart();
                },
              ),
            ),
          ],
        ),
        Gaps.h12,
        Text(store.storeName).md().bold(),
        Text("ㅇㅇㅇㅇ").regular().textGray().margin(
          top: MgSizes.size4,
          bottom: MgSizes.size8,
        ), //store.description
        DefaultTextStyle(
          style: context.textTheme.titleLarge!,
          child: Row(
            children: [
              Text('${store.discount}%').red(),
              Text(
                '${store.salePrice.toPrice()}원',
              ).margin(left: MgSizes.size4, right: MgSizes.size8),
              Text(
                '${store.originPrice.toPrice()}원',
              ).underline().textColor(MgColorScheme.gray6), // TODO: 취소선
            ],
          ),
        ),
      ],
    ).margin(all: MgSizes.md);
  }

  Widget _buildStoreLocationInfoSection(Goods store) {
    return Column(
      spacing: MgSizes.size8,
      children: [
        _buildStoreInfoItem(
          '픽업시간',
          "${store.startTime.convertTime() ?? ''} ~ ${store.endTime.convertTime() ?? ''}",
        ),
        _buildStoreInfoItem('주차안내', "TODO"),
        _buildStoreInfoItem('가게 주소', store.address), //TODO: 복사 버튼 추가
        BaseMapView(
          latitude: store.latitude,
          longitude: store.longitude,
        ).constrained(height: 100).margin(vertical: MgSizes.md),
        MgButton(
          onPressed: () async {
            await MgBottomsheet.show(context, (context, bottomState) {
              return _buildFindRouteBottomSheet();
            });
          },
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [BaseSvgIcon.mapPin(), Gaps.w4, Text("길찾기")],
          ),
        ), //TODO: border
      ],
    ).margin(horizontal: MgSizes.md);
  }

  Widget _buildStoreInfoItem(String label, String value) {
    return Row(
      children: [
        Text(label).md().textGray().bold(),
        Gaps.w12,
        Text(value).md().regular(),
      ],
    );
  }

  Widget _buildFindRouteBottomSheet() {
    return MgBottomsheet(
      Column(
        children: [
          Text("길찾기").md().bold().margin(vertical: MgSizes.md),
          _buildBottomSheetItem("네이버지도", R.ASSETS_IMAGES_NAVERMAP_PNG, () {
            // TODO
          }),
          Divider(),
          _buildBottomSheetItem("카카오맵", R.ASSETS_IMAGES_KAKAOMAP_PNG, () {
            // TODO
          }),
        ],
      ),
    );
  }

  Widget _buildBottomSheetItem(
    String label,
    String iconUrl,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipOval(
            child: Image.asset(iconUrl),
          ).constrained(height: MgSizes.size24),
          Gaps.w12,
          Text(label).md(),
        ],
      ).margin(vertical: MgSizes.md, horizontal: MgSizes.xl),
    );
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
