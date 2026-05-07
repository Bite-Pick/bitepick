import 'package:flutter/material.dart';

class MyLocationMarker extends StatelessWidget {
  const MyLocationMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 52,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 바깥 반투명 파란 원
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: Color(0x403385FF),
              shape: BoxShape.circle,
            ),
          ),
          // 흰 테두리 원
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x293385FF),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
          // 안쪽 파란 원
          Container(
            width: 14,
            height: 14,
            decoration: const BoxDecoration(
              color: Color(0xFF3385FF),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
