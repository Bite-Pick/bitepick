import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

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
    final marker = NMarker(
      id: "goal",
      position: NLatLng(widget.latitude, widget.longitude),
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
