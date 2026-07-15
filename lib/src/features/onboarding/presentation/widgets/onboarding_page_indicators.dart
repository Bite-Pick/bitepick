import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magambell/src/core/theme/mg_color.dart';

class OnboardingPageIndicators extends StatelessWidget {
  const OnboardingPageIndicators({
    super.key,
    required this.count,
    required this.current,
  });

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final isActive = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: 8.w,
          height: 8.h,
          margin:
              i < count - 1 ? EdgeInsets.only(right: 8.w) : EdgeInsets.zero,
          decoration: BoxDecoration(
            color:
                isActive ? MgColorScheme.primaryStrong : MgColorScheme.gray7,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
