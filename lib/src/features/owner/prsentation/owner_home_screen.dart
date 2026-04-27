import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/core/utils/inquiry_button.dart';
import 'package:magambell/src/features/auth/utils/auth_utils.dart';
import 'package:magambell/src/features/goods/data/repositories/goods_repository.dart';
import 'package:magambell/src/features/goods/domain/entities/goods.dart';
import 'package:magambell/src/features/owner/prsentation/owner_goods_view.dart';
import 'package:magambell/src/features/owner/prsentation/owner_order_list_view.dart';
import 'package:magambell/src/features/owner/prsentation/widgets/owner_more_button.dart';
import 'package:magambell/src/features/store/data/repositories/store_repository.dart';
import 'package:magambell/src/features/store/providers/store.provider.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_alert_dialog.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:dio/dio.dart';
import 'package:magambell/src/features/home/presentation/widgets/home_update_banner.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';

class OwnerHomeRoute extends GoRouteData {
  const OwnerHomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return OwnerHomeScreen();
  }
}

class OwnerHomeScreen extends ConsumerStatefulWidget {
  const OwnerHomeScreen({super.key});

  @override
  ConsumerState<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends ConsumerState<OwnerHomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  bool _isTogglingStatus = false;
  bool? _optimisticSaleStatus;

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
    final storeAsync = ref.watch(storeStateProvider);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) SystemNavigator.pop();
      },
      child: MgAsyncAnimatedSwitcher(
      asyncValue: storeAsync,
      onRetry: () => ref.invalidate(storeStateProvider),
      builder: (store) {
        return BaseScaffold(
          canSwipeBack:false,
          appBar: BaseAppBar(
            // leading: _buildDaySelectButton(), // TODO: 스프린트 종료후 추가
            // leadingWidth: 120,
            leading: SizedBox.shrink(),
            action: Row(
              children: [
                _buildServiceSwitch(
                  store?.goodsList[0].goodsId ?? "",
                  _optimisticSaleStatus ?? (store?.goodsList[0].saleStatus == "ON"),
                  store?.goodsList[0],
                ),
                OwnerMoreButton(),
              ],
            ),
            bottom: TabBar(
              dividerColor: Colors.transparent,
              controller: _tabController,
              labelColor: MgColorScheme.gray1,
              unselectedLabelColor: MgColorScheme.gray5,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: MgColorScheme.gray1, width: 2),
              ),
              labelStyle: context.textTheme.titleLarge,
              unselectedLabelStyle: context.textTheme.bodyLarge,
              tabs: [
                Tab(text: '주문'),
                Tab(text: '판매'),
              ],
            ),
          ),
          body: Stack(
            children: [
              TabBarView(
                controller: _tabController,
                children: [OwnerOrderListView(), OwnerGoodsView()],
              ),
              HomeUpdateBanner(),
            ],
          ),
        );
      },
    ),
    );
  }

  Widget _buildDaySelectButton() {
    return GestureDetector(
      onTap: () {
        // TODO[store]: 날짜 변경
      },
      child: Row(
        children: [
          Text(DateTime.now().format("M월 d일")).bold().md(),
          Gaps.w4,
          BaseSvgIcon.down(),
        ],
      ).margin(horizontal: MgSizes.sm),
    );
  }

  Widget _buildServiceSwitch(String id, bool saleStatus, Goods? goods) {
    void onToggle() {
      if (_isTogglingStatus) return;
      final newValue = !saleStatus;
      if (!newValue) {
        // OFF: 다이얼로그 확인 후 UI 전환
        showDialog(
          context: context,
          builder: (context) => _buildAlertDialog(id, newValue),
        );
      } else {
        // ON: 재고 확인 팝업
        if (goods != null) {
          _showQuantityConfirmDialog(id, goods);
        } else {
          setState(() => _optimisticSaleStatus = newValue);
          changeSaleStatus(id, newValue);
        }
      }
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onToggle,
      child: Row(
        children: [
          Text("영업중").bold().md(),
          Gaps.w8,
          IgnorePointer(
            child: Switch(
              value: saleStatus,
              onChanged: (_) {},
              activeThumbColor: MgColorScheme.gray11,
              activeTrackColor: MgColorScheme.systemSuccess, // 활성화(ON) 시 트랙 색상
              inactiveThumbColor: MgColorScheme.gray11, // 비활성화 원 색
              inactiveTrackColor: MgColorScheme.gray5, // 비활성화(OFF) 시 트랙 색상
              trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }

  MgAlertDialog _buildAlertDialog(String id, bool saleStatus) {
    return MgAlertDialog.basic(
      title: "영업을 종료하시겠어요?",
      content: Text("다시 영업재개를 위해서는 영업중으로\n전환해주셔야해요!").center(),
      onConfirm: () async => changeSaleStatus(id, saleStatus),
      confirmText: "확인",
      hasCancel: false,
    );
  }

  void _showQuantityConfirmDialog(String id, Goods goods) {
    showDialog(
      context: context,
      builder: (_) => _QuantityConfirmDialog(
        goods: goods,
        onConfirm: (newQuantity) async {
          setState(() => _optimisticSaleStatus = true);
          if (newQuantity != goods.stockQuantity) {
            try {
              await ref.read(goodsRepositoryProvider).editGoodsQuantity(
                goodsId: goods.goodsId!,
                quantity: newQuantity,
              );
            } catch (_) {}
          }
          await changeSaleStatus(id, true);
        },
      ),
    );
  }

  Future<void> changeSaleStatus(String id, bool saleStatus) async {
    if (_isTogglingStatus) return;
    setState(() {
      _isTogglingStatus = true;
      _optimisticSaleStatus = saleStatus;
    });
    try {
      await ref
          .read(goodsRepositoryProvider)
          .setGoodsSaleStatus(id: id, saleStatus: saleStatus);
      ref.invalidate(storeStateProvider);
      ref.invalidate(ownerStoreProvider);
      // provider 재로딩 완료까지 기다린 후 낙관적 상태 해제
      await ref.read(storeStateProvider.future);
    } on DioException catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("네트워크 오류가 발생했습니다. 다시 시도해주세요.")),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isTogglingStatus = false;
          // 성공 시엔 provider 값이 준비됐으므로 낙관적 상태 해제, 실패 시엔 롤백
          _optimisticSaleStatus = null;
        });
      }
    }
  }
}

class _QuantityConfirmDialog extends StatefulWidget {
  const _QuantityConfirmDialog({required this.goods, required this.onConfirm});

  final Goods goods;
  final ValueChanged<int> onConfirm;

  @override
  State<_QuantityConfirmDialog> createState() => _QuantityConfirmDialogState();
}

class _QuantityConfirmDialogState extends State<_QuantityConfirmDialog> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.goods.stockQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 쇼핑백 아이콘
            Image.asset('assets/images/product.png', width: 40, height: 40),
            const SizedBox(height: 12),
            // 타이틀
            Text(
              '오늘 판매할 수량을\n확인해주세요!',
              textAlign: TextAlign.center,
            ).bold().lg(),
            const SizedBox(height: 20),
            // 수량 선택
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: MgColorScheme.gray7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _quantity > 1
                        ? () => setState(() => _quantity--)
                        : null,
                    icon: BaseSvgIcon.minus(),
                  ),
                  Expanded(
                    child: Text('$_quantity개', textAlign: TextAlign.center)
                        .bold()
                        .md(),
                  ),
                  IconButton(
                    onPressed: () => setState(() => _quantity++),
                    icon: BaseSvgIcon.plus(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // 안내 문구
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: MgColorScheme.gray9,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• 입력하신 수량만큼만 오늘 판매됩니다.')
                      .sm()
                      .regular()
                      .textColor(MgColorScheme.gray3),
                  const SizedBox(height: 4),
                  Text('• 오늘 남은 재고를 묶음으로 준비해주시면 됩니다.')
                      .sm()
                      .regular()
                      .textColor(MgColorScheme.gray3),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // 확인 버튼
            MgButton(
              onPressed: () {
                Navigator.of(context).pop();
                widget.onConfirm(_quantity);
              },
              content: const Text('영업 시작하기'),
            ).primary(),
          ],
        ),
      ),
    );
  }
}
