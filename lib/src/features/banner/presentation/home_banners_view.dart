import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/features/banner/data/repositories/banner_repository.dart';
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
      emptyBuilder: () => SizedBox.shrink(),
      builder: (bannerImages) {
        return Swiper(
          controller: _swiperController,
          autoplay: true,
          autoplayDelay: 4000,
          loop: true,
          onIndexChanged: (int index) async {
            // TODO : view GA
          },
          itemCount: bannerImages.length,
          itemBuilder: (_, index) {
            final image = bannerImages[index].url;
            return CachedNetworkImage(imageUrl: image);
          },
        ).constrained(height: bannerHeight);
      },
    );
  }
}
