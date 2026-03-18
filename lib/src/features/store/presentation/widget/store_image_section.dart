import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magambell/src/constants/mg_sizes.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/widgets/base_network_image.dart';

class StoreImageSection extends ConsumerWidget {
  const StoreImageSection(this.images, {super.key});
  final List<String> images;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO[home] : 기기에 따라 크기를 조정해야하는지 검토
    // TODO[home] : 3개 이상 넘어가면 하단에 +n 표시
    final double imagesize1 = 108.w;
    final double imagesize2 = 66.w;
    return SizedBox(
      height: imagesize2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          final image = images[index];
          if (image == "") return SizedBox.shrink();
          return BaseNetworkImage(
            imageUrl: image,
            width: imagesize1,
            height: imagesize1,
          ).margin(right: MgSizes.xs);
        },
      ),
    );
  }
}
