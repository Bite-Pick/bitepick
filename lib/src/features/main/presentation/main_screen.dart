import 'dart:async';

import 'package:flutter/material.dart' hide NavigatorState;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/navigator/navigator_controller.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/features/home/presentation/home_map_screen.dart';
import 'package:magambell/src/features/home/presentation/home_screen.dart';
import 'package:magambell/src/features/home/presentation/widgets/map_view_floating_button.dart';
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
    return const MainScreen();
  }
}

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  static const List<Widget> _screens = [
    HomeScreen(),
    OrderListScreen(),
    MypageScreen(),
  ];

  static const int _mapTabIndex = 3;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navState = ref.watch(navigatorControllerProvider);
    final isMapTab = navState.tabIndex == _mapTabIndex;

    return BaseScaffold(
      body: Stack(
        children: [
          if (isMapTab)
            HomeMapScreen(
              onListPressed: () => ref
                  .read(navigatorControllerProvider.notifier)
                  .changeTabIndex(0),
            )
          else
            IndexedStack(index: navState.tabIndex, children: _screens),
          if (navState.tabIndex == 0)
            Positioned(
              bottom: MgSizes.md,
              left: 0,
              right: 0,
              child: Center(
                child: MapViewFloatingButton(
                  label: '지도보기',
                  icon: BaseSvgIcon.mapView(size: 16),
                  onPressed: () => ref
                      .read(navigatorControllerProvider.notifier)
                      .changeTabIndex(_mapTabIndex),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context, ref, navState),
    );
  }

  Widget _buildBottomNavigationBar(
    BuildContext context,
    WidgetRef ref,
    MgDefaultNavigatorState navState,
  ) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 0.5, color: NewColorScheme.gray11),
          MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              child: SizedBox(
                height: 80,
                child: BottomNavigationBar(
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  currentIndex:
                      navState.tabIndex == _mapTabIndex ? 0 : navState.tabIndex,
                  onTap: (index) {
                    // TODO: user domain 로직으로 분리
                    final user = ref.read(userStateProvider).asData!.value;
                    final isLogin = user != null;
                    if (!isLogin && index != 0) {
                      unawaited(showLoginAlerDialog(context));
                      return;
                    }
                    ref
                        .read(navigatorControllerProvider.notifier)
                        .changeTabIndex(index);
                  },
                  selectedItemColor: MgColorScheme.gray0,
                  unselectedItemColor: MgColorScheme.gray5,
                  selectedLabelStyle: Theme.of(context).textTheme.bodySmall,
                  unselectedLabelStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: MgColorScheme.gray6),
                  backgroundColor: MgColorScheme.gray11,
                  items: [
                    _buildBottomNavigationBarItem(
                      iconName: 'home',
                      label: '홈',
                      index: 0,
                      currentIndex:
                          navState.tabIndex == _mapTabIndex ? 0 : navState.tabIndex,
                    ),
                    _buildBottomNavigationBarItem(
                      iconName: 'order',
                      label: '주문내역',
                      index: 1,
                      currentIndex:
                          navState.tabIndex == _mapTabIndex ? 0 : navState.tabIndex,
                    ),
                    _buildBottomNavigationBarItem(
                      iconName: 'mypage',
                      label: '나의바픽',
                      index: 2,
                      currentIndex:
                          navState.tabIndex == _mapTabIndex ? 0 : navState.tabIndex,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: BaseSvgIcon(assetName: 'filled/$assetName.svg', size: MgSizes.xxl),
      ),
      label: label,
    );
  }
}
