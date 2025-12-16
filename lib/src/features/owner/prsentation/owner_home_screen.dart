import 'package:flutter/material.dart';
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
import 'package:magambell/src/features/owner/prsentation/owner_goods_view.dart';
import 'package:magambell/src/features/owner/prsentation/owner_order_list_view.dart';
import 'package:magambell/src/features/owner/prsentation/widgets/owner_more_button.dart';
import 'package:magambell/src/features/store/providers/store.provider.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_alert_dialog.dart';
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
    return MgAsyncAnimatedSwitcher(
      asyncValue: storeAsync,
      builder: (store) {
        return BaseScaffold(
          appBar: BaseAppBar(
            // leading: _buildDaySelectButton(), // TODO: 스프린트 종료후 추가
            // leadingWidth: 120,
            leading: SizedBox.shrink(),
            action: Row(
              children: [
                _buildServiceSwitch(
                  store?.goodsList[0].goodsId ?? "",
                  store?.goodsList[0].saleStatus == "ON",
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
          body: TabBarView(
            controller: _tabController,
            children: [OwnerOrderListView(), OwnerGoodsView()],
          ),
        );
      },
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

  Widget _buildServiceSwitch(String id, bool saleStatus) {
    return Row(
      children: [
        Text("영업중").bold().md(),
        Gaps.w8,
        Switch(
          value: saleStatus,
          onChanged: (value) async {
            !value
                ? showDialog(
                    context: context,
                    builder: (context) => _buildAlertDialog(id, value),
                  )
                : changeSaleStatus(id, value);
          },
          activeThumbColor: MgColorScheme.gray11,
          activeTrackColor: MgColorScheme.systemSuccess, // 활성화(ON) 시 트랙 색상
          inactiveThumbColor: MgColorScheme.gray11, // 비활성화 원 색
          inactiveTrackColor: MgColorScheme.gray5, // 비활성화(OFF) 시 트랙 색상
          trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
        ),
      ],
    );
  }

  MgAlertDialog _buildAlertDialog(String id, bool saleStatus) {
    return MgAlertDialog(
      title: "영업을 종료하시겠어요?",
      content: Text("다시 영업재개를 위해서는 영업중으로\n전환해주셔야해요!").center(),
      onConfirm: () async => changeSaleStatus(id, saleStatus),
      confirmText: "확인",
      hasCancel: false,
    );
  }

  Future<void> changeSaleStatus(String id, bool saleStatus) async {
    await ref
        .read(goodsRepositoryProvider)
        .setGoodsSaleStatus(id: id, saleStatus: saleStatus);
    ref.invalidate(storeStateProvider);
  }
}
