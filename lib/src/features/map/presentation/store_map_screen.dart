import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_map_view.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';

class StoreMapRoute extends GoRouteData {
  const StoreMapRoute({required this.id, required this.$extra});

  final String id;
  final StoreMapExtra $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return StoreMapScreen(
      id: id,
      storeName: $extra.storeName,
      latitude: $extra.latitude,
      longitude: $extra.longitude,
      address: $extra.address,
    );
  }
}

class StoreMapExtra {
  const StoreMapExtra({
    required this.storeName,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  final String storeName;
  final double latitude;
  final double longitude;
  final String address;
}

class StoreMapScreen extends StatelessWidget {
  const StoreMapScreen({
    super.key,
    required this.id,
    required this.storeName,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  final String id;
  final String storeName;
  final double latitude;
  final double longitude;
  final String address;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            // 전체 화면 지도
            BaseMapView(
              latitude: latitude,
              longitude: longitude,
              buildingName: storeName,
            ),
            // 하단 정보 카드
            Positioned(
              bottom: MgSizes.lg,
              left: 0,
              right: 0,
              child: _buildBottomInfoCard(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomInfoCard(BuildContext context) {
    return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(storeName).md().bold(),
            Gaps.h8,
            // 주소
            Text(address).sm().textGray(),
          ],
        )
        .margin(all: MgSizes.md)
        .decorated(
          color: MgColorScheme.white,
          borderRadius: BorderRadius.circular(MgSizes.lg),
        )
        .margin(horizontal: MgSizes.md);
  }
}
