import 'package:flutter/material.dart' hide NavigatorState;
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/core/navigator/navigator_controller.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/features/favorite/presentation/favorite_screen.dart';
import 'package:magambell/src/features/home/presentation/home_screen.dart';
import 'package:magambell/src/features/order/presentation/order_screen.dart';
import 'package:magambell/src/features/splash/presentation/splash_screen.dart';
import 'package:magambell/src/features/user/presentation/mypage_screen.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final NavigatorController _navigatorController;

  final List<Widget> _screens = const [
    HomeScreen(),
    FavoriteScreen(),
    SplashScreen(),
    OrderScreen(),
    MypageScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _navigatorController = NavigatorController();
  }

  @override
  void dispose() {
    _navigatorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MgDefaultNavigatorState>(
      valueListenable: _navigatorController,
      builder: (context, navState, child) {
        return BaseScaffold(
          body: IndexedStack(index: navState.tabIndex, children: _screens),
          bottomNavigationBar: _buildBottomNavigationBar(navState),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(MgDefaultNavigatorState navState) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: navState.tabIndex,
      onTap: _navigatorController.changeTabIndex,
      selectedItemColor: MgColorScheme.black,
      unselectedItemColor: MgColorScheme.gray5,
      selectedLabelStyle: Theme.of(context).textTheme.bodySmall,
      unselectedLabelStyle: Theme.of(
        context,
      ).textTheme.bodySmall!.copyWith(color: MgColorScheme.gray6),
      backgroundColor: MgColorScheme.white,
      items: [
        _buildBottomNavigationBarItem(
          iconPath: R.ASSETS_ICONS_HOME_PNG,
          label: '메인',
          index: 0,
          currentIndex: navState.tabIndex,
        ),
        _buildBottomNavigationBarItem(
          iconPath: R.ASSETS_ICONS_HEART_PNG,
          label: '즐겨찾기',
          index: 1,
          currentIndex: navState.tabIndex,
        ),
        _buildBottomNavigationBarItem(
          iconPath: R.ASSETS_ICONS_MAP_PIN_PNG,
          label: '내주변',
          index: 2,
          currentIndex: navState.tabIndex,
        ),
        _buildBottomNavigationBarItem(
          iconPath: R.ASSETS_ICONS_ORDER_HISTORY_PNG,
          label: '주문내역',
          index: 3,
          currentIndex: navState.tabIndex,
        ),
        _buildBottomNavigationBarItem(
          iconPath: R.ASSETS_ICONS_USER_PNG,
          label: 'MY',
          index: 4,
          currentIndex: navState.tabIndex,
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required String iconPath,
    required String label,
    required int index,
    required int currentIndex,
  }) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        iconPath,
        width: 24,
        height: 24,
        color: currentIndex == index
            ? MgColorScheme.black
            : MgColorScheme.gray5,
      ),
      label: label,
    );
  }
}
