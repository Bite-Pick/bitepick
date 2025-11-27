import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magambell/src/constants/mg_sizes.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';

class StoreImageSection extends ConsumerWidget {
  const StoreImageSection(this.images, {super.key});
  final List<String> images;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO[home] : 기기에 따라 크기를 조정해야하는지 검토
    // TODO[home] : 3개 이상 넘어가면 하단에 +n 표시
    final double imagesize = 109.w;
    return SizedBox(
      height: imagesize,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          final image = images[index];
          if (image == "") return SizedBox.shrink();
          return CachedNetworkImage(
            imageUrl: image,
            imageBuilder: (context, imageProvider) => Container(
              height: imagesize,
              width: imagesize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => Container(
              height: imagesize,
              width: imagesize,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ).margin(right: MgSizes.size8.w);
        },
      ),
    );
  }
}
