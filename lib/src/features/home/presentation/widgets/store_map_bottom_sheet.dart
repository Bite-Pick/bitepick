import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/extensions/price_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/features/store/presentation/store_screen.dart';
import 'package:magambell/src/features/store/data/repositories/store_repository.dart';
import 'package:magambell/src/features/store/presentation/widget/store_tags.dart';
import 'package:magambell/src/widgets/base_network_image.dart';
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

    return SizedBox(
      height: 288,
      child: Column(
        children: [
          const SizedBox(height: 12),
          // 핸들
          Center(
            child: Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: NewColorScheme.gray11,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Expanded(
            child: detailAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
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
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              child: BaseSvgIcon.close(
                                size: 24,
                                color: NewColorScheme.gray1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // 가게명
                        Text(
                          detail.storeName,
                          style: const TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F0F10),
                            letterSpacing: -0.4,
                            height: 1.5,
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
                                color: Color(0xFFF04452),
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
                                color: Color(0xFF0F0F10),
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
                                    color: Color(0xFFC2C4C8),
                                    letterSpacing: -0.4,
                                    height: 1.5,
                                  ),
                                ),
                                Positioned.fill(
                                  child: Center(
                                    child: Container(
                                      height: 1,
                                      color: const Color(0xFFC2C4C8),
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
                                    style: TextStyle(color: Color(0xFFAEB0B6)),
                                  ),
                                  TextSpan(
                                    text: '$pickupStart~$pickupEnd',
                                    style: const TextStyle(
                                      color: Color(0xFF5A5C63),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 4),
                            BaseSvgIcon.mapPin(
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
                                color: Color(0xFF5A5C63),
                                letterSpacing: -0.325,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // 이미지 가로 스크롤
                        SizedBox(
                          height: 108,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: detail.images.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 8),
                            itemBuilder: (context, index) => BaseNetworkImage(
                              imageUrl: detail.images[index],
                              width: 109,
                              height: 108,
                              borderRadius: 8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatDistance(double? dist) {
    if (dist == null) return '';
    if (dist < 1.0) return '${(dist * 1000).round()}m';
    return '${dist.toStringAsFixed(1)}km';
  }
}
