import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class BaseMapView extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return NaverMap(
      forceGesture: true,
      options: NaverMapViewOptions(
        initialCameraPosition: NCameraPosition(
          target: NLatLng(latitude, longitude),
          zoom: 15,
          bearing: 0,
          tilt: 0,
        ),
        mapType: NMapType.basic,
        activeLayerGroups: [NLayerGroup.building, NLayerGroup.transit],
      ),
      onMapReady: (controller) async {
        // final goalMarker = NMarker(
        //   id: "goal",
        //   position: NLatLng(latitude, longitude),
        //   caption: NOverlayCaption(
        //     text: buildingName,
        //     textSize: MgFontSize.sm,
        //     color: Colors.black,
        //     haloColor: Colors.white,
        //   ),
        // );
        // await controller.addOverlay(goalMarker);
      },
    );
  }
}
