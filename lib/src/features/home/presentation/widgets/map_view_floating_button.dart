import 'package:flutter/material.dart';
import 'package:magambell/src/core/theme/mg_color.dart';

enum MapViewFloatingButtonVariant { dark, light }

class MapViewFloatingButton extends StatelessWidget {
  const MapViewFloatingButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.variant = MapViewFloatingButtonVariant.dark,
  });

  final String label;
  final Widget icon;
  final VoidCallback onPressed;
  final MapViewFloatingButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final isDark = variant == MapViewFloatingButtonVariant.dark;
    final backgroundColor =
        isDark ? NewColorScheme.gray2 : NewColorScheme.gray14;
    final foregroundColor =
        isDark ? NewColorScheme.gray14 : NewColorScheme.gray1;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(1000),
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.16),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: foregroundColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.325,
                height: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
