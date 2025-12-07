import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/price_extension.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/mg_text_rich.dart';

class OrderInfoItem extends StatelessWidget {
  const OrderInfoItem({
    super.key,
    required this.imageUrl,
    required this.storeName,
    this.address,
    this.discount,
    required this.price,
    required this.count,
    this.imageSize = 100,
  });
  final String imageUrl;
  final String storeName;
  final String? address;
  final int? discount;
  final int price;
  final int count;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            height: imageSize,
            width: imageSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
        ),
        Gaps.w12,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(storeName).md().bold(),
              if (address != null) Text(address!).sm().textGray(),
              Gaps.h4,
              MgTextRich(
                children: [
                  if (discount != null)
                    TextSpan(text: "${discount!.toInt()}%").subpointRed(),
                  TextSpan(text: ' ${price.toPrice()}원 • $count개'),
                ],
              ).sm().bold(),
            ],
          ),
        ),
      ],
    );
  }
}
