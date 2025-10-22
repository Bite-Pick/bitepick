import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeBannersView extends StatefulWidget {
  const HomeBannersView({super.key});

  @override
  State<HomeBannersView> createState() => _HomeBannersViewState();
}

class _HomeBannersViewState extends State<HomeBannersView> {
  // final SwiperController _swiperController = SwiperController();
  static const bannerHeight = 160;
  @override
  Widget build(BuildContext context) {
    // TODO : card_swiper
    // TODO: ad api
    //  Swiper(
    //         controller: _swiperController,
    //         autoplay: true,
    //         autoplayDelay: 4000,
    //         loop: loop,
    //         onIndexChanged: (int index) async {
    //          // TODO : GA
    //         },
    //         itemCount: majorUserTimetableGroupIds.length,
    //         itemBuilder: (_, index) {
    //           returnCachedNetworkImage(imageUrl: "");
    //         },
    //       ).constrained(height: bannerHeight),
    //     ),
    //   ],
    // );
    return CachedNetworkImage(imageUrl: "");
  }
}
