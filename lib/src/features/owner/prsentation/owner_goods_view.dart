import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/features/goods/domain/entities/goods.dart';
import 'package:magambell/src/features/goods/presentation/goods_register_screen.dart';
import 'package:magambell/src/features/store/presentation/widget/store_info_view.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class OwnerGoodsView extends ConsumerWidget {
  const OwnerGoodsView(this.goods, {super.key});
  final Goods? goods;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (goods == null) return _buildEmptyView(context);
    return Text("준비중..");
    // return StoreInfoView(store: null, id: '',);
  }

  Widget _buildEmptyView(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text("앗! 등록된 메뉴가 없어요"),
        Gaps.h24,
        MgButton(
          content: Text("마감백 등록하러가기"),
          onPressed: () async => GoodsRegisterRoute().push(context),
          fullWidth: false,
        ).primary(),
      ],
    );
  }
}
