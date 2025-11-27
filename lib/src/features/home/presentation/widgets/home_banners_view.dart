import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/admin/data/repositories/admin_repository.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';

class HomeBannersView extends ConsumerStatefulWidget {
  const HomeBannersView({super.key});

  @override
  ConsumerState<HomeBannersView> createState() => _HomeBannersViewState();
}

class _HomeBannersViewState extends ConsumerState<HomeBannersView> {
  final SwiperController _swiperController = SwiperController();
  static const double bannerHeight = 160;
  @override
  Widget build(BuildContext context) {
    final bannerImagesAsync = ref.watch(bannerImagesProvider);

    return MgAsyncAnimatedSwitcher(
      asyncValue: bannerImagesAsync,
      builder: (bannerImages) {
        return Swiper(
          controller: _swiperController,
          autoplay: true,
          autoplayDelay: 4000,
          loop: true,
          onIndexChanged: (int index) async {
            // TODO : GA
          },
          itemCount: bannerImages.length,
          itemBuilder: (_, index) {
            final bannerImage = bannerImages[index];
            return CachedNetworkImage(
              imageUrl: bannerImage.url,
              width: 343,
              height: 160,
              fit: BoxFit.cover,
            ).clipRRect(all: MgRadius.sm);
          },
          pagination: swiperPageIndicator(),
        ).constrained(height: bannerHeight);
      },
    ).margin(horizontal: MgSizes.md);
  }

  SwiperPlugin swiperPageIndicator() {
    return SwiperPagination(
      alignment: Alignment.bottomRight,
      margin: Gutter.sm,
      builder: SwiperCustomPagination(
        builder: (BuildContext context, SwiperPluginConfig config) {
          return Text('${config.activeIndex + 1} / ${config.itemCount}')
              .xs()
              .white()
              .margin(horizontal: MgSizes.xs, vertical: MgSizes.xss)
              .decorated(
                color: MgColorScheme.gray1.withOpacity(0.3),
                borderRadius: BorderRadius.circular(999),
              );
        },
      ),
    );
  }
}
