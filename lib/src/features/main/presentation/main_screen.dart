import 'dart:async';

import 'package:flutter/material.dart' hide NavigatorState;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/navigator/navigator_controller.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/features/home/presentation/home_screen.dart';
import 'package:magambell/src/features/order/presentation/order_list_screen.dart';
import 'package:magambell/src/features/user/presentation/mypage_screen.dart';
import 'package:magambell/src/features/user/presentation/widgets/login_user_alert_dialog.dart';
import 'package:magambell/src/features/user/providers/user.provider.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';

class MainRoute extends GoRouteData {
  const MainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MainScreen();
  }
}

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  static const List<Widget> _screens = [
    HomeScreen(),
    OrderListScreen(),
    MypageScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navState = ref.watch(navigatorControllerProvider);

    return BaseScaffold(
      body: IndexedStack(index: navState.tabIndex, children: _screens),
      bottomNavigationBar: _buildBottomNavigationBar(context, ref, navState),
    );
  }

  Widget _buildBottomNavigationBar(
    BuildContext context,
    WidgetRef ref,
    MgDefaultNavigatorState navState,
  ) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: navState.tabIndex,
      onTap: (index) {
        // TODO: user domain 로직으로 분리
        final user = ref.read(userStateProvider).asData!.value;
        final isLogin = user != null;
        if (!isLogin && index != 0) {
          unawaited(showLoginAlerDialog(context));
          return;
        }

        ref.read(navigatorControllerProvider.notifier).changeTabIndex(index);
      },
      selectedItemColor: MgColorScheme.gray0,
      unselectedItemColor: MgColorScheme.gray5,
      selectedLabelStyle: Theme.of(context).textTheme.bodySmall,
      unselectedLabelStyle: Theme.of(
        context,
      ).textTheme.bodySmall!.copyWith(color: MgColorScheme.gray6),
      backgroundColor: MgColorScheme.gray11,
      items: [
        _buildBottomNavigationBarItem(
          iconName: 'home',
          label: '메인',
          index: 0,
          currentIndex: navState.tabIndex,
        ),
        _buildBottomNavigationBarItem(
          iconName: 'order',
          label: '주문내역',
          index: 1,
          currentIndex: navState.tabIndex,
        ),
        _buildBottomNavigationBarItem(
          iconName: 'mypage',
          label: '마이페이지',
          index: 2,
          currentIndex: navState.tabIndex,
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required String iconName,
    required String label,
    required int index,
    required int currentIndex,
  }) {
    final isSelected = currentIndex == index;
    final assetName = isSelected ? iconName : '${iconName}_gray';

    return BottomNavigationBarItem(
      icon: BaseSvgIcon(assetName: 'filled/$assetName.svg', size: MgSizes.xxl),
      label: label,
    );
  }
}
