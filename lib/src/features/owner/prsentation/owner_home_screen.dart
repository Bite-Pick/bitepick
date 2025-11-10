import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/features/owner/prsentation/owner_goods_view.dart';
import 'package:magambell/src/features/owner/prsentation/owner_order_list_view.dart';
import 'package:magambell/src/features/store/providers/store.provider.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';

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
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(storeStateProvider);
    return BaseScaffold(
      appBar: BaseAppBar(
        // leading: _buildDaySelectButton(),
        // leadingWidth: 120, // TODO[ui]:fix
        leading: SizedBox.shrink(),
        action: _buildServiceSwitch(),
        bottom: TabBar(
          dividerColor: Colors.transparent,
          controller: _tabController,
          labelColor: MgColorScheme.text,
          unselectedLabelColor: MgColorScheme.gray5,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: MgColorScheme.gray1, width: 2),
          ),
          labelStyle: context.textTheme.bodyLarge,
          unselectedLabelStyle: context.textTheme.bodyLarge,
          tabs: [
            Tab(text: '주문'),
            Tab(text: '판매'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [OwnerOrderListView(), OwnerGoodsView(null)],
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

  Widget _buildServiceSwitch() {
    return Row(
      children: [
        Text("영업중"),

        Switch(
          value: true,
          onChanged: (value) {
            // TODO[goods]: 마감백 saleStatue인지 확인필요
          },
        ),
      ],
    );
  }
}
