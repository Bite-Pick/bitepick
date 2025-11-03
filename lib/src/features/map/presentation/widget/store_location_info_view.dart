import 'package:flutter/material.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/utils/map_launcher.dart';
import 'package:magambell/src/widgets/base_map_view.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_bottomsheet.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:package_info_plus/package_info_plus.dart';

class StoreLocationInfoView extends StatelessWidget {
  const StoreLocationInfoView({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.storeName,
    this.mapHeight = 100,
  });

  final double latitude;
  final double longitude;
  final String storeName;
  final double mapHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: MgSizes.md,
      children: [
        BaseMapView(
          latitude: latitude,
          longitude: longitude,
        ).constrained(height: mapHeight),
        MgButton(
          onPressed: () async {
            await MgBottomsheet.show(context, (context, bottomState) {
              return _buildFindRouteBottomSheet(context);
            });
          },
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BaseSvgIcon.mapPin(size: MgSizes.lg),
              Gaps.w4,
              Text("길찾기"),
            ],
          ),
          borderColor: MgColorScheme.gray7,
        ),
      ],
    );
  }

  Widget _buildFindRouteBottomSheet(BuildContext context) {
    return MgBottomsheet(
      Column(
        children: [
          Text("길찾기").md().bold().margin(vertical: MgSizes.md),
          _buildBottomSheetItem(
            context,
            "네이버지도",
            R.ASSETS_IMAGES_NAVERMAP_PNG,
            () async {
              final packageInfo = await PackageInfo.fromPlatform();
              await MapLauncher.openNaverMapRoute(
                latitude: latitude,
                longitude: longitude,
                destinationName: storeName,
                appPackageName: packageInfo.packageName,
              );
              if (context.mounted) Navigator.of(context).pop();
            },
          ),
          Divider(),
          _buildBottomSheetItem(
            context,
            "카카오맵",
            R.ASSETS_IMAGES_KAKAOMAP_PNG,
            () async {
              await MapLauncher.openKakaoMapRoute(
                latitude: latitude,
                longitude: longitude,
              );
              if (context.mounted) Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheetItem(
    BuildContext context,
    String label,
    String iconUrl,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipOval(
            child: Image.asset(iconUrl),
          ).constrained(height: MgSizes.size24),
          Gaps.w12,
          Text(label).md(),
        ],
      ).margin(vertical: MgSizes.md, horizontal: MgSizes.xl),
    );
  }
}
