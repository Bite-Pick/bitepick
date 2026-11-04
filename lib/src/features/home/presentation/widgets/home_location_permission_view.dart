import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';

/// 위치 권한이 없을 때 홈 목록 대신 보여주는 안내 화면
class HomeLocationPermissionView extends StatelessWidget {
  const HomeLocationPermissionView({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MgSizes.xl, bottom: 70.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            R.ASSETS_IMAGES_LOCATION_PERMISSION_PNG,
            width: 152,
            height: 128,
          ),
          Gaps.h16,
          const Text(
            '위치 권한을 허용하고\n내 주변 매장을 확인해보세요.',
            textAlign: TextAlign.center,
          ).md().bold(),
          Gaps.h8,
          const Text('가까운 매장을 쉽고 빠르게 찾아보세요.').sm().textGray(),
          Gaps.h16,
          // 보이는 모양은 작은 pill 그대로 두고, 터치 영역만 48px 이상으로 확보한다.
          Semantics(
            button: true,
            label: '위치 권한 허용하기',
            excludeSemantics: true,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onPressed,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
                child: Center(
                  widthFactor: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: MgColorScheme.gray1,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Text(
                      '위치 권한 허용하기',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
