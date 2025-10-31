import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/price_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/features/home/domain/entities/goods.dart';
import 'package:magambell/src/features/store/presentation/widget/store_tags.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';

class StoreRoute extends GoRouteData {
  const StoreRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DetailScreen(id: id);
  }
}

class DetailScreen extends ConsumerStatefulWidget {
  const DetailScreen({super.key, required this.id});

  final String id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    // final store = ref.watch(storeGoodsDetailProvider(id));
    final store = mockData;
    return BaseScaffold(
      appBar: BaseAppBar(title: Text('상세 화면 ${widget.id}')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_buildStoreDescriptionSection(store)],
        ),
      ),
    );
  }

  Widget _buildStoreDescriptionSection(Goods store) {
    return Column(
      children: [
        Row(
          children: [
            StoreTags(quantity: store.quantity, saleStatus: store.saleStatus),
            GestureDetector(
              onTap: () {
                // TODO: 좋아요
              },
              child: BaseSvgIcon.heart(),
            ),
          ],
        ),
        Text(store.storeName).md().bold(),
        // Text(store.description).md().bold().margin(top: MgSizes.size4, bottom: MgSizes.size8),
        StoreTags(quantity: store.quantity, saleStatus: store.saleStatus),
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
              ).underline().textColor(MgColorScheme.gray6), // TODO: 취소선
            ],
          ),
        ),
        Text('할인율: ${store.discount}%'),
        Text('거리: ${store.distance}'),
        Text('픽업시간: ${store.startTime} ~ ${store.endTime}'),
      ],
    );
  }
}
