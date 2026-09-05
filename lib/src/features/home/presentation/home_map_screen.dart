import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/features/address/presentation/select_service_region_screen.dart';
import 'package:magambell/src/features/goods/data/dtos/store_list.dto.dart';
import 'package:magambell/src/features/home/presentation/home_screen.controller.dart';
import 'package:magambell/src/features/home/presentation/home_screen.dart';
import 'package:magambell/src/features/store/data/repositories/store_repository.dart';
import 'package:magambell/src/features/home/presentation/widgets/map_icon_floating_button.dart';
import 'package:magambell/src/features/home/presentation/widgets/map_view_floating_button.dart';
import 'package:magambell/src/features/home/presentation/widgets/my_location_marker.dart';
import 'package:magambell/src/features/home/presentation/widgets/map_tooltip_marker.dart';
import 'package:magambell/src/features/home/presentation/widgets/non_service_area_banner.dart';
import 'package:magambell/src/features/home/presentation/widgets/home_filter_bar.dart';
import 'package:magambell/src/features/home/presentation/widgets/service_area_request_chip.dart';
import 'package:magambell/src/features/home/presentation/widgets/store_map_bottom_sheet.dart';
import 'package:magambell/src/features/home/presentation/widgets/store_pin_marker.dart';
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
  const HomeMapScreen({super.key, this.onListPressed});

  final VoidCallback? onListPressed;

  @override
  ConsumerState<HomeMapScreen> createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends ConsumerState<HomeMapScreen> {
  NaverMapController? _mapController;
  bool _mapReady = false; // NOverlayImage.fromWidget 가능 여부 플래그
  String? _selectedStoreId;
  double _currentZoom = 14.0;
  List<StoreListDTO> _currentStores = [];
  StoreListDTO? _bottomSheetStore;
  bool _tooltipVisible = false;

  // 비서비스 지역 UI 상태
  bool _bannerVisible = false;
  bool _serviceAreaChipDismissed = false;
  Timer? _bannerDebounceTimer;
  Timer? _tooltipTimer;
  Timer? _mapFetchDebounceTimer;

  static const _myLocationMarkerId = 'my_location';
  static const _tooltipMarkerId = 'service_tooltip';
  static const _tooltipPosition = NLatLng(37.3243773830569, 127.107505020642);
  static const _serviceAreaRadiusM = 5000.0;
  static const _labelHideZoom = 12.0;
  static const _storeMarkerPrefix = 'store_';
  static const double _selectedPinHeight = 43.0;
  static const double _unselectedPinHeight = 36.0;
  static const double _openStateOffset = 26.0;

  @override
  void dispose() {
    _bannerDebounceTimer?.cancel();
    _tooltipTimer?.cancel();
    _mapFetchDebounceTimer?.cancel();
    _mapReady = false;
    super.dispose();
  }

  bool _checkIsInServiceArea(NLatLng target) {
    final serviceAddresses =
        ref.read(homeScreenControllerProvider).valueOrNull?.serviceAddresses ??
        [];
    if (serviceAddresses.isEmpty) return true;
    return serviceAddresses.any((addr) {
      final dist = Geolocator.distanceBetween(
        target.latitude,
        target.longitude,
        addr.latitude,
        addr.longitude,
      );
      return dist <= _serviceAreaRadiusM;
    });
  }

  void _updateBannerVisibility(bool inServiceArea) {
    _bannerDebounceTimer?.cancel();
    _bannerDebounceTimer = Timer(const Duration(milliseconds: 200), () {
      if (mounted) setState(() => _bannerVisible = !inServiceArea);
    });
  }

  Future<void> _onBannerCtaTapped() async {
    if (_mapController == null) return;
    await _mapController!.updateCamera(
      NCameraUpdate.withParams(target: _tooltipPosition, zoom: 13),
    );
    await _showTooltip();
  }

  void _onMapReady(NaverMapController controller) {
    _mapReady = false;
    _mapController = controller;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await Future.wait([
        precacheImage(
          const AssetImage('assets/images/pin_store_default.png'),
          context,
        ),
        NOverlayImage.fromWidget(
          widget: const StorePinMarker(
            storeName: '',
            isSelected: true,
            isOpen: false,
            showLabel: false,
          ),
          size: const Size(80, 90),
          context: context,
        ),
        NOverlayImage.fromWidget(
          widget: const StorePinMarker(
            storeName: '',
            isSelected: true,
            isOpen: true,
            showLabel: false,
          ),
          size: const Size(80, 110),
          context: context,
        ),
      ]);
      if (!mounted) return;
      _mapReady = true;
      _showTooltip();
      _fetchMapStores();
      final stores = ref
          .read(homeScreenControllerProvider)
          .valueOrNull
          ?.storeGoodsList;
      if (stores != null && stores.isNotEmpty) {
        _refreshStoreMarkers(stores);
      }
    });
  }

  Future<void> _showTooltip() async {
    _tooltipTimer?.cancel();
    if (_tooltipVisible) {
      _tooltipTimer = Timer(const Duration(seconds: 3), _hideTooltip);
      return;
    }
    final controller = _mapController;
    if (controller == null || !_mapReady || !mounted) return;
    final icon = await NOverlayImage.fromWidget(
      widget: _lockTextScale(
        const MapTooltipMarker(label: '현재 죽전 지역 서비스 중'),
      ),
      size: const Size(165, 45),
      context: context,
    );
    if (!mounted || !_mapReady) return;
    _tooltipVisible = true;
    await controller.addOverlay(
      NMarker(id: _tooltipMarkerId, position: _tooltipPosition)
        ..setIcon(icon)
        ..setAnchor(const NPoint(0.5, 1.0))
        ..setGlobalZIndex(300000),
    );
    _tooltipTimer = Timer(const Duration(seconds: 3), _hideTooltip);
  }

  Future<void> _hideTooltip() async {
    if (!_tooltipVisible) return;
    _tooltipVisible = false;
    try {
      await _mapController?.deleteOverlay(
        NOverlayInfo(type: NOverlayType.marker, id: _tooltipMarkerId),
      );
    } catch (_) {}
  }

  Future<void> _refreshStoreMarkers(List<StoreListDTO> stores) async {
    final controller = _mapController;
    if (controller == null || !_mapReady) return;

    for (final store in _currentStores) {
      try {
        await controller.deleteOverlay(
          NOverlayInfo(
            type: NOverlayType.marker,
            id: '$_storeMarkerPrefix${store.storeId}',
          ),
        );
      } catch (_) {}
    }

    if (!mounted || !_mapReady) return;
    _currentStores = stores;

    for (final store in stores) {
      if (!mounted || !_mapReady) return;
      final marker = await _buildStoreMarker(store);
      if (!mounted || !_mapReady) return;
      marker.setOnTapListener((_) => _onStorePinTapped(store));
      await controller.addOverlay(marker);
    }
  }

  // NOverlayImage.fromWidget은 앱의 MediaQuery와 분리된 별도 렌더 트리에서
  // 위젯을 이미지로 그리기 때문에, 전역 글씨 크기 고정 설정이 적용되지 않는다.
  // 그 렌더 트리 안쪽에 현재 context의 MediaQuery를 다시 씌워서 강제로 적용시킨다.
  Widget _lockTextScale(Widget child) {
    return MediaQuery(data: MediaQuery.of(context), child: child);
  }

  Future<NMarker> _buildStoreMarker(StoreListDTO store) async {
    final isSelected = store.storeId == _selectedStoreId;
    final isOpen = store.saleStatus == 'ON';
    final showLabel = _currentZoom > _labelHideZoom;

    final imageSize = isSelected
        ? Size(80, isOpen ? 110 : 90)
        : Size(80, isOpen ? 90 : 70);

    final icon = await NOverlayImage.fromWidget(
      widget: _lockTextScale(
        StorePinMarker(
          storeName: store.storeName,
          isSelected: isSelected,
          isOpen: isOpen,
          showLabel: showLabel,
        ),
      ),
      size: imageSize,
      context: context,
    );

    final pinHeight = isSelected ? _selectedPinHeight : _unselectedPinHeight;
    final pinTipY = (isOpen ? _openStateOffset : 0.0) + pinHeight;
    final anchorY = pinTipY / imageSize.height;

    return NMarker(
      id: '$_storeMarkerPrefix${store.storeId}',
      position: NLatLng(store.latitude, store.longitude),
    )
      ..setIcon(icon)
      ..setAnchor(NPoint(0.5, anchorY));
  }

  void _onStorePinTapped(StoreListDTO store) {
    setState(() {
      _selectedStoreId = store.storeId;
      _bottomSheetStore = store;
    });
    _mapController?.updateCamera(
      NCameraUpdate.scrollAndZoomTo(
        target: NLatLng(store.latitude, store.longitude),
      )..setPivot(const NPoint(0.5, 0.35)),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _refreshStoreMarkers(_currentStores);
    });
  }

  void _onBottomSheetClose() {
    setState(() {
      _selectedStoreId = null;
      _bottomSheetStore = null;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _refreshStoreMarkers(_currentStores);
    });
  }

  void _onCameraChange(NCameraUpdateReason reason, bool animated) {
    _mapController?.getCameraPosition().then((position) {
      final wasAbove = _currentZoom > _labelHideZoom;
      final isAbove = position.zoom > _labelHideZoom;
      if (wasAbove != isAbove) {
        setState(() => _currentZoom = position.zoom);
      }

      final inServiceArea = _checkIsInServiceArea(position.target);
      _updateBannerVisibility(inServiceArea);

      _mapFetchDebounceTimer?.cancel();
      _mapFetchDebounceTimer = Timer(const Duration(milliseconds: 500), () {
        if (mounted) _fetchMapStores();
      });
    });
  }

  Future<void> _fetchMapStores() async {
    final controller = _mapController;
    if (controller == null || !_mapReady) return;

    final bounds = await controller.getContentBounds();
    final onlyAvailable =
        ref.read(homeScreenControllerProvider).valueOrNull?.onlyAvailable ??
        false;

    final stores = await ref
        .read(storeRepositoryProvider)
        .getStoreMapList(
          swLatitude: bounds.southWest.latitude,
          swLongitude: bounds.southWest.longitude,
          neLatitude: bounds.northEast.latitude,
          neLongitude: bounds.northEast.longitude,
          onlyAvailable: onlyAvailable,
        );

    if (mounted) _refreshStoreMarkers(stores);
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
          const SnackBar(content: Text('위치 권한이 필요합니다. 설정에서 허용해주세요.')),
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('현재 위치를 가져올 수 없습니다.')));
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
    if (!mounted) return;
    await controller.addOverlay(
      NMarker(id: _myLocationMarkerId, position: target)..setIcon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controllerState = ref.watch(homeScreenControllerProvider).valueOrNull;
    final defaultAddress = controllerState?.defaultAddress;

    ref.listen(homeScreenControllerProvider, (prev, next) {
      final prevAvailable = prev?.valueOrNull?.onlyAvailable;
      final nextAvailable = next.valueOrNull?.onlyAvailable;
      if (prevAvailable != nextAvailable) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _fetchMapStores();
        });
      }
    });

    final bottomSheetStore = _bottomSheetStore;

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
                HomeFilterBar(
                  onlyAvailable: controllerState?.onlyAvailable ?? false,
                  onToggleAvailable: () => ref
                      .read(homeScreenControllerProvider.notifier)
                      .toggleOnlyAvailable(),
                ),
                if (_bannerVisible)
                  NonServiceAreaBanner(
                    serviceAreaLabel: '죽전',
                    onCtaTapped: _onBannerCtaTapped,
                  ),
                Expanded(
                  child: Stack(
                    children: [
                      NaverMap(
                        options: NaverMapViewOptions(
                          initialCameraPosition: const NCameraPosition(
                            target: _tooltipPosition,
                            zoom: 13,
                          ),
                          mapType: NMapType.basic,
                          activeLayerGroups: [
                            NLayerGroup.building,
                            NLayerGroup.transit,
                          ],
                        ),
                        onMapReady: _onMapReady,
                        onCameraChange: _onCameraChange,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (_bannerVisible && !_serviceAreaChipDismissed)
              Positioned(
                bottom: bottomSheetStore != null ? 288 + 100 : 100,
                left: 16,
                child: ServiceAreaRequestChip(
                  onTap: () => SelectServiceRegionRoute().push<bool>(context),
                  onDismiss: () =>
                      setState(() => _serviceAreaChipDismissed = true),
                ),
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
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              bottom: bottomSheetStore != null ? 288 + 16 + 16: 16,
              left: 16,
              child: MapIconFloatingButton(
                icon: BaseSvgIcon.gps(size: 20, color: NewColorScheme.gray1),
                onPressed: _onGpsPressed,
              ),
            ),
            if (bottomSheetStore == null)
              Positioned(
                bottom: 16 + 38 + 8,
                left: 16,
                child: MapIconFloatingButton(
                  icon: BaseSvgIcon.store(size: 20, color: NewColorScheme.gray1),
                  onPressed: () => SelectServiceRegionRoute().push<bool>(context),
                ),
              ),
            // 가게 바텀시트 — 플로팅 버튼보다 위에 배치, 슬라이드 애니메이션
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              left: 0,
              right: 0,
              bottom: bottomSheetStore != null ? 0 : -288,
              child: bottomSheetStore != null
                  ? _StoreBottomSheetPanel(
                      store: bottomSheetStore,
                      onClose: _onBottomSheetClose,
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoreBottomSheetPanel extends StatelessWidget {
  const _StoreBottomSheetPanel({required this.store, required this.onClose});

  final StoreListDTO store;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Color(0x29000000),
            blurRadius: 12,
            offset: Offset(2, 0),
          ),
        ],
      ),
      child: StoreMapBottomSheet(
        storeId: store.storeId,
        distance: store.distance,
        onClose: onClose,
      ),
    );
  }
}
