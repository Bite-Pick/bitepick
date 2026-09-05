import 'package:flutter/material.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';

/// 지도를 이동했을 때 노출되는 "현 지도에서 검색" floating action button.
class SearchInAreaButton extends StatelessWidget {
  const SearchInAreaButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: NewColorScheme.gray14,
          borderRadius: BorderRadius.circular(1000),
          boxShadow: [
            BoxShadow(
              color: const Color(0x29000000),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseSvgIcon.reload(size: 16, color: NewColorScheme.gray1),
            const SizedBox(width: 4),
            Text(
              '현 지도에서 검색',
              style: TextStyle(
                fontFamily: MgFontFamily.medium,
                fontWeight: FontWeight.w500,
                fontSize: 13,
                height: 1.5,
                letterSpacing: 13 * -0.025,
                color: NewColorScheme.gray1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
