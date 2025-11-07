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
import 'package:magambell/src/features/favorite/data/repositories/favorite_repository.dart';
import 'package:magambell/src/features/goods/domain/entities/goods.dart';
import 'package:magambell/src/features/map/presentation/widget/store_location_info_view.dart';
import 'package:magambell/src/features/store/presentation/widget/store_tags.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';

class StoreInfoView extends ConsumerWidget {
  const StoreInfoView({super.key, required this.store, required this.id});

  final Goods store;
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _buildThumbnailImageView(store),
        _buildStoreDescriptionSection(context, ref, store),
        Divider(thickness: MgSizes.size6).margin(vertical: MgSizes.md),
        _buildStoreLocationInfoSection(store),
        Divider(thickness: MgSizes.size6).margin(vertical: MgSizes.md),
      ],
    );
  }

  Widget _buildThumbnailImageView(Goods store) {
    if (store.ImageUrl.isEmpty) {
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
        loop: store.ImageUrl.length > 1,
        itemCount: store.ImageUrl.length,
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            activeColor: MgColorScheme.primary,
            color: MgColorScheme.gray4,
          ),
        ),
        itemBuilder: (context, index) {
          final imageUrl = store.ImageUrl[index];
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

  Widget _buildStoreDescriptionSection(
    BuildContext context,
    WidgetRef ref,
    Goods store,
  ) {
    final favoriteAsync = ref.watch(favoriteProvider(storeId: id));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            StoreTags(quantity: store.quantity, saleStatus: store.saleStatus),
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
                //     ? await repo.removeFavorite(id)
                //     : await repo.addFavorite(id);
                // ref.invalidate(favoriteProvider(storeId: id));
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
        Text(store.storeName).md().bold(),
        Text("ㅇㅇㅇㅇ").regular().textGray().margin(
          top: MgSizes.size4,
          bottom: MgSizes.size8,
        ), //store.description
        DefaultTextStyle(
          style: context.textTheme.titleLarge!,
          child: Row(
            children: [
              Text('${store.discount}%').red(),
              Text(
                '${store.salePrice.toPrice()}원',
              ).margin(left: MgSizes.size4, right: MgSizes.size8),
              Text(
                '${store.originPrice.toPrice()}원',
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

  Widget _buildStoreLocationInfoSection(Goods store) {
    return Column(
      spacing: MgSizes.size8,
      children: [
        _buildStoreInfoItem(
          '픽업시간',
          "${store.startTime.convertTime() ?? ''} ~ ${store.endTime.convertTime() ?? ''}",
        ),
        _buildStoreInfoItem('주차안내', "TODO"),
        _buildStoreInfoItem(
          '가게 주소',
          store.address,
          suffix: GestureDetector(
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: store.address));
              // TODO: Flash 메시지로 복사완료 알림
            },
            child: const Text("복사").textColor(Color(0xff0077FF)),
          ),
        ),
        StoreLocationInfoView(
          storeId: id,
          latitude: store.latitude,
          longitude: store.longitude,
          storeName: store.storeName,
          address: store.address,
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
