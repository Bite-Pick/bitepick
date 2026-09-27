import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:magambell/src/features/home/presentation/widgets/store_pin_marker.dart';

class BaseMapView extends StatefulWidget {
  const BaseMapView({
    required this.latitude,
    required this.longitude,
    this.buildingName = "",
    super.key,
  });

  final double latitude;
  final double longitude;
  final String buildingName;

  @override
  State<BaseMapView> createState() => _BaseMapViewState();
}

class _BaseMapViewState extends State<BaseMapView> {
  static const _pinHeight = 43.0;
  static const _labelHeight = 12.0;
  static const _markerWidth = 80.0;
  static const _markerHeight = _pinHeight + _labelHeight; 

  late final NCameraPosition _initialPosition;

  @override
  void initState() {
    super.initState();
    _initialPosition = NCameraPosition(
      target: NLatLng(widget.latitude, widget.longitude),
      zoom: 15,
      bearing: 0,
      tilt: 0,
    );
  }

  Future<void> _onMapReady(NaverMapController controller) async {
  await NOverlayImage.fromWidget(
    context: context,
    size: const Size(80, 65),
    widget: const StorePinMarker(
      storeName: '',
      isSelected: true,
      isOpen: false,
      showLabel: false,
    ),
  );

  final icon = await NOverlayImage.fromWidget(
    context: context,
    size: const Size(80, 65),
    widget: StorePinMarker(
      storeName: widget.buildingName,
      isSelected: true,
      isOpen: false,
      showLabel: true,
    ),
  );
  final marker = NMarker(
    id: "goal",
    position: NLatLng(widget.latitude, widget.longitude),
    icon: icon,
    anchor: const NPoint(0.5, 0.5), // 추가
  );
  await controller.addOverlay(marker);
}


  @override
  Widget build(BuildContext context) {
    return NaverMap(
      forceGesture: true,
      options: NaverMapViewOptions(
        initialCameraPosition: _initialPosition,
        mapType: NMapType.basic,
        activeLayerGroups: [NLayerGroup.building, NLayerGroup.transit],
      ),
      onMapReady: _onMapReady,
    );
  }
}
