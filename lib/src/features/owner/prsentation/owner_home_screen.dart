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
    _tabController = TabController(length: 2, vsync: this);
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
        // leading: _buildDaySelectButton(), // TODO: 스프린트 종료후 추가
        // leadingWidth: 120,
        leading: SizedBox.shrink(),
        action: Row(
          children: [
            _buildServiceSwitch(store?.goodsList[0].goodsId ?? ""),
            _buildMoreButton(),
          ],
        ),
        bottom: TabBar(
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

  Widget _buildServiceSwitch(String id) {
    return Row(
      children: [
        Text("영업중").bold().md(),
        Gaps.w8,
        // TODO: 스위치 색상 변경
        Switch(
          value: true,
          onChanged: (value) async {
            await ref
                .read(goodsRepositoryProvider)
                .setGoodsSaleStatus(id: id, saleStatus: value);
            ref.invalidate(storeStateProvider);
          },
        ),
      ],
    );
  }

  Widget _buildMoreButton() {
    return PopupMenuButton<String>(
      icon: BaseSvgIcon.moreVertical(),
      onSelected: (value) {
        return switch (value) {
          'logout' => logout(ref, context), // TODO: dialog로 묻기
          'support' => InquiryButton.showInquiryBottomSheet(context),
          _ => null,
        };
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      offset: const Offset(0, 36), // 클릭 위치로부터 아래로 띄움
      itemBuilder: (context) => [
        const PopupMenuItem<String>(
          value: 'logout',
          child: Center(child: Text('로그아웃')),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<String>(
          value: 'support',
          child: Center(child: Text('고객센터')),
        ),
      ],
    );
  }
}
