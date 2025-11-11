import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/features/goods/presentation/goods_register_screen.dart';
import 'package:magambell/src/features/owner/prsentation/owner_goods_empty_screen.dart';
import 'package:magambell/src/features/store/data/repositories/store_repository.dart';
import 'package:magambell/src/features/store/domain/entities/store.dart';
import 'package:magambell/src/features/store/presentation/widget/store_bite_bag_view.dart';
import 'package:magambell/src/features/store/presentation/widget/store_info_view.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class OwnerGoodsView extends ConsumerWidget {
  const OwnerGoodsView({super.key, this.store});
  final Store? store;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: API 연동시 아래 주석 해제
    final ownerStoreAsync = ref.watch(ownerStoreProvider);
    return MgAsyncAnimatedSwitcher(
      asyncValue: ownerStoreAsync,
      builder: (store) {
        if (store == null) return OwnerGoodsEmptyScreen();
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    StoreInfoView(store.toStoreInfoData(), hasFavorite: false),
                    StoreBiteBagView(),
                  ],
                ),
              ),
            ),
            MgButton(
              onPressed: () {
                GoodsRegisterRoute().push(context);
              },
              content: Text("상품 관리하기"),
            ).primary().margin(vertical: MgSizes.lg, horizontal: MgSizes.md),
          ],
        );
      },
    );
  }
}
