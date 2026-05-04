import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/features/home/presentation/home_screen.controller.dart';
import 'package:magambell/src/features/home/presentation/home_screen.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';

class HomeMapRoute extends GoRouteData {
  const HomeMapRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeMapScreen();
  }
}

class HomeMapScreen extends ConsumerWidget {
  const HomeMapScreen({super.key});

  @override
  Widget _buildAvailableChip(
    BuildContext context,
    WidgetRef ref,
    bool onlyAvailable,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: MgSizes.md,
        vertical: MgSizes.xs,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () => ref
              .read(homeScreenControllerProvider.notifier)
              .toggleOnlyAvailable(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: onlyAvailable ? MgColorScheme.gray1 : Colors.transparent,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: onlyAvailable
                    ? MgColorScheme.gray1
                    : MgColorScheme.gray7,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 14,
                  color: onlyAvailable
                      ? MgColorScheme.gray11
                      : MgColorScheme.gray1,
                ),
                const SizedBox(width: 4),
                Text(
                  '예약가능',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: onlyAvailable
                        ? MgColorScheme.gray11
                        : MgColorScheme.gray1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerState = ref.watch(homeScreenControllerProvider).valueOrNull;
    final defaultAddress = controllerState?.defaultAddress;

    return BaseScaffold(
      body: SafeArea(
        child: Column(
          children: [
            HomeAppBarContent(
              defaultAddress: defaultAddress,
              serviceAddresses: controllerState?.serviceAddresses ?? [],
            ),
            _buildAvailableChip(
              context,
              ref,
              controllerState?.onlyAvailable ?? false,
            ),
            Expanded(
              child: NaverMap(
                options: NaverMapViewOptions(
                  initialCameraPosition: NCameraPosition(
                    target: defaultAddress != null
                        ? NLatLng(
                            defaultAddress.latitude,
                            defaultAddress.longitude,
                          )
                        : const NLatLng(37.5666102, 126.9783881),
                    zoom: 14,
                  ),
                  mapType: NMapType.basic,
                  activeLayerGroups: [
                    NLayerGroup.building,
                    NLayerGroup.transit,
                  ],
                ),
                onMapReady: (_) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
