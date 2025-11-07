import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/features/goods/domain/entities/goods.dart';

// TODO: 시안 나온 이후 구체화 필요
class GoodsInfoView extends ConsumerWidget {
  const GoodsInfoView(this.goods, {super.key});
  final Goods goods;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        CachedNetworkImage(imageUrl: goods.ImageUrl[0]),
        Text("${goods.goodsName}"),
      ],
    );
  }
}
