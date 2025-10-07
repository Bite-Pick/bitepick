import 'package:flutter/material.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
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
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    FavoriteScreen(),
    SplashScreen(),
    OrderScreen(),
    MypageScreen(),
  ];

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
          ),
          _buildBottomNavigationBarItem(
            iconPath: R.ASSETS_ICONS_HEART_PNG,
            label: '즐겨찾기',
            index: 1,
          ),
          _buildBottomNavigationBarItem(
            iconPath: R.ASSETS_ICONS_MAP_PIN_PNG,
            label: '내주변',
            index: 2,
          ),
          _buildBottomNavigationBarItem(
            iconPath: R.ASSETS_ICONS_ORDER_HISTORY_PNG,
            label: '주문내역',
            index: 3,
          ),
          _buildBottomNavigationBarItem(
            iconPath: R.ASSETS_ICONS_USER_PNG,
            label: 'MY',
            index: 4,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required String iconPath,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        iconPath,
        width: 24,
        height: 24,
        color: _selectedIndex == index
            ? MgColorScheme.black
            : MgColorScheme.gray5,
      ),
      label: label,
    );
  }
}
