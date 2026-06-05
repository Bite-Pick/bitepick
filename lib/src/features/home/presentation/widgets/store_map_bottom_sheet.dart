import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/extensions/price_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/features/store/presentation/store_screen.dart';
import 'package:magambell/src/features/store/data/repositories/store_repository.dart';
import 'package:magambell/src/features/store/presentation/widget/store_image_section.dart';
import 'package:magambell/src/features/store/presentation/widget/store_tags.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';

class StoreMapBottomSheet extends ConsumerWidget {
  const StoreMapBottomSheet({
    super.key,
    required this.storeId,
    required this.onClose,
    this.distance,
  });

  final String storeId;
  final VoidCallback onClose;
  final double? distance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(storeGoodsDetailProvider(storeId));
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onClose,
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity != null &&
                details.primaryVelocity! > 0) {
              onClose();
            }
          },
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: NewColorScheme.gray11,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
        ),
        detailAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (_, __) => const SizedBox.shrink(),
          data: (detail) {
            if (detail == null) return const SizedBox.shrink();

            final pickupStart =
                '${detail.startTime.hour.toString().padLeft(2, '0')}:${detail.startTime.minute.toString().padLeft(2, '0')}';
            final pickupEnd =
                '${detail.endTime.hour.toString().padLeft(2, '0')}:${detail.endTime.minute.toString().padLeft(2, '0')}';

            return GestureDetector(
              onTap: () {
                onClose();
                StoreRoute(id: storeId).push(context);
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, bottomPadding + 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 레이블 + 닫기 버튼
                    Row(
                      children: [
                        StoreTags(
                          quantity: detail.quantity,
                          saleStatus: detail.saleStatus,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: onClose,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: NewColorScheme.gray11,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: BaseSvgIcon.close(
                                size: 14,
                                color: NewColorScheme.gray1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // 가게명
                    Text(
                      detail.storeName,
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: NewColorScheme.gray1,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // 가격 행
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${detail.discount}%',
                          style: const TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: NewColorScheme.systemAlert,
                            letterSpacing: -0.5,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${detail.salePrice.toPrice()}원',
                          style: const TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: NewColorScheme.gray1,
                            letterSpacing: -0.5,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              '${detail.originalPrice.toPrice()}원',
                              style: const TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: NewColorScheme.gray8,
                                letterSpacing: -0.4,
                                height: 1.5,
                              ),
                            ),
                            Positioned.fill(
                              child: Center(
                                child: Container(
                                  height: 1,
                                  color: NewColorScheme.gray8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // 픽업 시간 + 거리
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.325,
                              height: 1.5,
                            ),
                            children: [
                              const TextSpan(
                                text: '픽업 ',
                                style: TextStyle(color: NewColorScheme.gray7),
                              ),
                              TextSpan(
                                text: '$pickupStart~$pickupEnd',
                                style: const TextStyle(
                                  color: NewColorScheme.gray4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4),
                        BaseSvgIcon.mapPinSmall(
                          size: 16,
                          color: NewColorScheme.gray6,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          _formatDistance(distance),
                          style: const TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: NewColorScheme.gray4,
                            letterSpacing: -0.325,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // 이미지 가로 스크롤
                    StoreImageSection(detail.images),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  String _formatDistance(double? dist) {
    if (dist == null) return '';
    if (dist < 1.0) return '${(dist * 1000).round()}m';
    return '${dist.toStringAsFixed(1)}km';
  }
}
