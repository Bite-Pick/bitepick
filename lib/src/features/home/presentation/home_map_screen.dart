import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/features/address/presentation/select_service_region_screen.dart';
import 'package:magambell/src/features/home/presentation/home_screen.controller.dart';
import 'package:magambell/src/features/home/presentation/home_screen.dart';
import 'package:magambell/src/features/home/presentation/widgets/map_icon_floating_button.dart';
import 'package:magambell/src/features/home/presentation/widgets/my_location_marker.dart';
import 'package:magambell/src/features/home/presentation/widgets/map_view_floating_button.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';

class HomeMapRoute extends GoRouteData {
  const HomeMapRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeMapScreen();
  }
}

class HomeMapScreen extends ConsumerStatefulWidget {
  const HomeMapScreen({
    super.key,
    this.onListPressed,
  });

  final VoidCallback? onListPressed;

  @override
  ConsumerState<HomeMapScreen> createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends ConsumerState<HomeMapScreen> {
  NaverMapController? _mapController;

  static const _myLocationMarkerId = 'my_location';

  void _onMapReady(NaverMapController controller) {
    _mapController = controller;
  }

  Future<void> _onGpsPressed() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('위치 권한이 필요합니다. 설정에서 허용해주세요.'),
          ),
        );
      }
      return;
    }

    final Position position;
    try {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('현재 위치를 가져올 수 없습니다.')),
        );
      }
      return;
    }

    final controller = _mapController;
    if (controller == null) return;

    final target = NLatLng(position.latitude, position.longitude);

    await controller.updateCamera(
      NCameraUpdate.withParams(target: target, zoom: 15),
    );

    try {
      await controller.deleteOverlay(
        NOverlayInfo(type: NOverlayType.marker, id: _myLocationMarkerId),
      );
    } catch (_) {}

    if (!mounted) return;
    // ignore: use_build_context_synchronously
    final icon = await NOverlayImage.fromWidget(
      widget: const MyLocationMarker(),
      size: const Size(52, 52),
      context: context,
    );
    await controller.addOverlay(
      NMarker(id: _myLocationMarkerId, position: target)..setIcon(icon),
    );
  }

  Widget _buildAvailableChip(bool onlyAvailable) {
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
  Widget build(BuildContext context) {
    final controllerState = ref.watch(homeScreenControllerProvider).valueOrNull;
    final defaultAddress = controllerState?.defaultAddress;

    return BaseScaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                HomeAppBarContent(
                  defaultAddress: defaultAddress,
                  serviceAddresses: controllerState?.serviceAddresses ?? [],
                ),
                _buildAvailableChip(controllerState?.onlyAvailable ?? false),
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
                    onMapReady: _onMapReady,
                  ),
                ),
              ],
            ),
            if (widget.onListPressed != null)
              Positioned(
                bottom: MgSizes.md,
                left: 0,
                right: 0,
                child: Center(
                  child: MapViewFloatingButton(
                    label: '목록보기',
                    icon: BaseSvgIcon.listView(size: 16),
                    onPressed: widget.onListPressed!,
                    variant: MapViewFloatingButtonVariant.light,
                  ),
                ),
              ),
            Positioned(
              bottom: 16,
              left: 16,
              child: MapIconFloatingButton(
                icon: BaseSvgIcon.gps(size: 20, color: NewColorScheme.gray1),
                onPressed: _onGpsPressed,
              ),
            ),
            Positioned(
              bottom: 16 + 36 + 8,
              left: 16,
              child: MapIconFloatingButton(
                icon: BaseSvgIcon.store(size: 20, color: NewColorScheme.gray1),
                onPressed: () =>
                    SelectServiceRegionRoute().push<bool>(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
