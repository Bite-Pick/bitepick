import 'package:flutter/material.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';

class NonServiceAreaBanner extends StatelessWidget {
  const NonServiceAreaBanner({
    super.key,
    required this.serviceAreaLabel,
    required this.onCtaTapped,
  });

  final String serviceAreaLabel;
  final VoidCallback onCtaTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      color: const Color(0xFFE3EEFF),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BaseSvgIcon.megaphone(size: 20, color: const Color(0xFF0C4596)),
          const SizedBox(width: 4),
          const Text(
            '이 지역엔 아직 매장이 없어요.',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              height: 1.5,
              letterSpacing: -0.325,
              color: Color(0xFF0C4596),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onCtaTapped,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$serviceAreaLabel 매장 보기',
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    letterSpacing: -0.325,
                    color: Color(0xFF0C4596),
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.chevron_right,
                  size: 16,
                  color: Color(0xFF0C4596),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
