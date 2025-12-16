import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/price_extension.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/base_network_image.dart';
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
        BaseNetworkImage(
          imageUrl: imageUrl,
          width: imageSize,
          height: imageSize,
        ),
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
                    TextSpan(text: "${discount!.toInt()}% ").subpointRed(),
                  TextSpan(text: '${price.toPrice()}원 • $count개'),
                ],
              ).sm().bold(),
            ],
          ),
        ),
      ],
    );
  }
}
