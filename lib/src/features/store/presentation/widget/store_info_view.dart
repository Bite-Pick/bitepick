import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
import 'package:magambell/src/core/extensions/price_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/features/favorite/data/repositories/favorite_repository.dart';
import 'package:magambell/src/features/goods/domain/entities/goods.dart';
import 'package:magambell/src/features/map/presentation/widget/store_location_info_view.dart';
import 'package:magambell/src/features/store/domain/entities/store.dart';
import 'package:magambell/src/features/store/presentation/widget/store_tags.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';

class StoreInfoView extends ConsumerWidget {
  const StoreInfoView({super.key, this.goods, this.store})
    : assert(
        goods != null || store != null,
        'Either goods or store must be provided',
      );

  final Goods? goods;
  final Store? store;

  String get storeId => goods?.storeId ?? store?.storeId ?? '';
  String get storeName => goods?.storeName ?? store?.storeName ?? '';
  String get address => goods?.address ?? store?.address ?? '';
  List<String> get imageUrls => goods?.ImageUrl ?? store?.storeImageUrls ?? [];
  double? get latitude => goods?.latitude;
  double? get longitude => goods?.longitude;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildThumbnailImageView(),
        _buildStoreDescriptionSection(context, ref),
        Divider(thickness: MgSizes.size6).margin(vertical: MgSizes.md),
        _buildStoreLocationInfoSection(),
        Divider(thickness: MgSizes.size6).margin(vertical: MgSizes.md),
      ],
    );
  }

  Widget _buildThumbnailImageView() {
    if (imageUrls.isEmpty) {
      return Container(
        height: 300,
        color: MgColorScheme.gray2,
        child: Center(child: Text('이미지 없음').textGray()),
      );
    }

    return SizedBox(
      height: 240,
      child: Swiper(
        autoplay: true,
        autoplayDelay: 4000,
        loop: imageUrls.length > 1,
        itemCount: imageUrls.length,
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            activeColor: MgColorScheme.primary,
            color: MgColorScheme.gray4,
          ),
        ),
        itemBuilder: (context, index) {
          final imageUrl = imageUrls[index];
          if (imageUrl.isEmpty) {
            return Container(
              color: MgColorScheme.gray2,
              child: Center(child: Text('이미지 없음').textGray()),
            );
          }
          return CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover);
        },
      ),
    );
  }

  Widget _buildStoreDescriptionSection(BuildContext context, WidgetRef ref) {
    final favoriteAsync = ref.watch(favoriteProvider(storeId: storeId));

    // Goods 데이터가 있는 경우에만 표시
    final quantity = goods?.quantity ?? 0;
    final saleStatus = goods?.saleStatus ?? '';
    final discount = goods?.discount ?? 0;
    final salePrice = goods?.salePrice ?? 0;
    final originPrice = goods?.originPrice ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (goods != null) ...[
          Row(
            children: [
              StoreTags(quantity: quantity, saleStatus: saleStatus),
              // TODO[review]: 리뷰영역으로 스크롤내리는 버튼 추가
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  context.showFlash(
                    duration: const Duration(milliseconds: 2000),
                    builder: (context, controller) {
                      return FlashBar(
                        controller: controller,
                        content: const Text("로그인 기능 구현 이후에 작동가능"),
                      );
                    },
                  );
                  // final repo = ref.read(favoriteRepositoryProvider);
                  // final currentFavorite = favoriteAsync.asData?.value;
                  // currentFavorite == true
                  //     ? await repo.removeFavorite(storeId)
                  //     : await repo.addFavorite(storeId);
                  // ref.invalidate(favoriteProvider(storeId: storeId));
                },
                child: MgAsyncAnimatedSwitcher(
                  asyncValue: favoriteAsync,
                  builder: (isFavorite) {
                    return (isFavorite == true)
                        ? BaseSvgIcon.heartFilled(
                            color: MgColorScheme.navigationPrimary,
                          )
                        : BaseSvgIcon.heart();
                  },
                ),
              ),
            ],
          ),
          Gaps.h12,
        ],
        Text(storeName).md().bold(),
        Text("ㅇㅇㅇㅇ").regular().textGray().margin(
          top: MgSizes.size4,
          bottom: MgSizes.size8,
        ), //description
        if (goods != null)
          DefaultTextStyle(
            style: context.textTheme.titleLarge!,
            child: Row(
              children: [
                Text('${discount.toInt()}%').red(),
                Text(
                  '${salePrice.toInt().toPrice()}원',
                ).margin(left: MgSizes.size4, right: MgSizes.size8),
                Text(
                  '${originPrice.toInt().toPrice()}원',
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: MgColorScheme.gray6,
                    color: MgColorScheme.gray6,
                  ),
                ),
              ],
            ),
          ),
      ],
    ).margin(all: MgSizes.md, bottom: 0);
  }

  Widget _buildStoreLocationInfoSection() {
    final startTime = goods?.startTime ?? '';
    final endTime = goods?.endTime ?? '';

    return Column(
      spacing: MgSizes.size8,
      children: [
        if (goods != null && startTime.isNotEmpty && endTime.isNotEmpty)
          _buildStoreInfoItem(
            '픽업시간',
            "${startTime.convertTime() ?? ''} ~ ${endTime.convertTime() ?? ''}",
          ),
        _buildStoreInfoItem('주차안내', "TODO"),
        _buildStoreInfoItem(
          '가게 주소',
          address,
          suffix: GestureDetector(
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: address));
              // TODO: Flash 메시지로 복사완료 알림
            },
            child: const Text("복사").textColor(Color(0xff0077FF)),
          ),
        ),
        if (latitude != null && longitude != null)
          StoreLocationInfoView(
            storeId: storeId,
            latitude: latitude!,
            longitude: longitude!,
            storeName: storeName,
            address: address,
          ).margin(vertical: MgSizes.md),
      ],
    ).margin(horizontal: MgSizes.md);
  }

  Widget _buildStoreInfoItem(String label, String value, {Widget? suffix}) {
    return Row(
      children: [
        Text(label).md().textGray().bold(),
        Gaps.w12,
        Text(value).md().regular(),
        Gaps.w4,
        suffix ?? const SizedBox.shrink(),
      ],
    );
  }
}
