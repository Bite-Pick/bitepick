import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/theme/mg_color.dart' show MgColorScheme;
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/store/domain/sort_type.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';

class HomeFilterBar extends StatelessWidget {
  const HomeFilterBar({
    super.key,
    required this.onlyAvailable,
    this.sortType,
    this.showFilter = false,
    required this.onToggleAvailable,
    this.onSortTap,
  });

  final bool onlyAvailable;
  final SortType? sortType;
  final bool showFilter;
  final VoidCallback onToggleAvailable;
  final VoidCallback? onSortTap;

  Widget _buildChip() {
    return GestureDetector(
      onTap: onToggleAvailable,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: onlyAvailable ? MgColorScheme.gray1 : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: onlyAvailable ? MgColorScheme.gray1 : MgColorScheme.gray7,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.access_time_rounded,
              size: 14,
              color: onlyAvailable ? MgColorScheme.gray11 : MgColorScheme.gray1,
            ),
            const SizedBox(width: 4),
            Text(
              '예약가능',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color:
                    onlyAvailable ? MgColorScheme.gray11 : MgColorScheme.gray1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bottomBorder = BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Color(0xFFEAEBEC), width: 1),
      ),
    );

    // 지도 뷰: chip만 단독 표시 (outer frame 없음)
    if (!showFilter) {
      return DecoratedBox(
        decoration: bottomBorder,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: MgSizes.md,
            vertical: MgSizes.xs,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: _buildChip(),
          ),
        ),
      );
    }

    // 리스트 뷰: chip + filter
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: MgSizes.md,
          vertical: 8,
        ),
        child: SizedBox(
          height: 48,
          child: Row(
            children: [
            _buildChip(),
            const Spacer(),
            if (sortType != null)
              GestureDetector(
                onTap: onSortTap,
                child: SizedBox(
                  width: 54,
                  height: 20,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(sortType!.name).sm(),
                      BaseSvgIcon.down(size: 16),
                    ],
                  ),
                ),
              ),
          ],
          ),
        ),
    );
  }
}
