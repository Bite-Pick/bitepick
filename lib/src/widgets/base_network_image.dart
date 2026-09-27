import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/mg_sizes.dart';
import 'package:magambell/src/core/theme/mg_color.dart';

class BaseNetworkImage extends ConsumerWidget {
  const BaseNetworkImage({
    super.key,
    required this.imageUrl,
    this.width=100,
    this.height=100,
    this.borderRadius = MgRadius.sm,
    this.imageBuilder,
    this.placeholderBuilder,
    this.errorWidgetBuilder,
    this.backgroundColor = MgColorScheme.gray10,
  });
  final String imageUrl;
  final double width;
  final double height;
  final double borderRadius;
  final ImageWidgetBuilder? imageBuilder;
  final PlaceholderWidgetBuilder? placeholderBuilder;
  final LoadingErrorWidgetBuilder? errorWidgetBuilder;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => imageBuilder != null
          ? imageBuilder!(context, imageProvider)
          : Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
      errorWidget: (context, url, error) => errorWidgetBuilder != null
          ? errorWidgetBuilder!(context, url, error)
          : Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.error, color: Colors.white),
            ),
      placeholder: (context, url) => placeholderBuilder != null
          ? placeholderBuilder!(context, url)
          : Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: backgroundColor, // TODO: shimmer로 변경
                borderRadius: BorderRadius.circular(8),
              ),
            ),
    );
  }
}
