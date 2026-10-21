import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/theme/mg_color.dart';

/// 홈/지도 화면 공통 상단바 ("내 주변 매장")
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: MgColorScheme.gray11,
      padding: const EdgeInsets.all(MgSizes.md),
      child: const Text(
        '내 주변 매장',
        style: TextStyle(
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
          fontSize: 16,
          height: 1.5,
          letterSpacing: -0.4,
        ),
      ),
    );
  }
}

class HomeAppBarDelegate extends SliverPersistentHeaderDelegate {
  const HomeAppBarDelegate();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return const HomeAppBar();
  }

  @override
  double get minExtent => kToolbarHeight;

  @override
  double get maxExtent => minExtent;

  @override
  bool shouldRebuild(covariant HomeAppBarDelegate oldDelegate) => false;
}
