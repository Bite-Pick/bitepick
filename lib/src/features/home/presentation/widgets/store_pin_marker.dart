import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:magambell/src/core/theme/mg_color.dart';

class StorePinMarker extends StatelessWidget {
  const StorePinMarker({
    super.key,
    required this.storeName,
    required this.isSelected,
    required this.isOpen,
    required this.showLabel,
  });

  final String storeName;
  final bool isSelected;
  final bool isOpen;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isOpen) _OpenBadge(),
          _PinIcon(isSelected: isSelected),
          if (showLabel)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Stack(
                children: [
                  Text(
                    storeName,
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 3
                        ..color = Colors.white,
                      letterSpacing: -0.3,
                      height: 1.0,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    storeName,
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: NewColorScheme.gray1,
                      letterSpacing: -0.3,
                      height: 1.0,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _OpenBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white, width: 0.5),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x29000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '영업중',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: NewColorScheme.gray1,
                    letterSpacing: -0.3,
                    height: 1.5,
                  ),
                ),
                const SizedBox(width: 2),
                Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: MgColorScheme.primaryHeavy,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PinIcon extends StatelessWidget {
  const _PinIcon({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return SvgPicture.asset(
        'assets/icons/svg/pin_store_selected.svg',
        width: 44,
        height: 43,
      );
    }
    return Image.asset(
      'assets/images/pin_store_default.png',
      width: 36,
      height: 36,
    );
  }
}
