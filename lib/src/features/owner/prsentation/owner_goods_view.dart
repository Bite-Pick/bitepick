import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/features/goods/presentation/goods_register_screen.dart';
import 'package:magambell/src/features/store/domain/entities/store.dart';
import 'package:magambell/src/features/store/presentation/widget/store_info_view.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class OwnerGoodsView extends ConsumerWidget {
  const OwnerGoodsView({super.key, this.store});
  final Store? store;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: API 연동시 아래 주석 해제
    // final ownerStoreAsync = ref.watch(ownerStoreProvider);
    // return ownerStoreAsync.when(
    //   loading: () => Center(child: CircularProgressIndicator()),
    //   error: (error, stack) => Center(child: Text('Error: $error')),
    //   data: (apiStore) {
    //     final displayStore = apiStore ?? mockStore;
    //     if (displayStore.goodsList.isEmpty) return _buildEmptyView(context);
    //     return StoreInfoView(store: displayStore);
    //   },
    // );

    // 현재는 mockStore 사용
    final displayStore = store ?? mockStore;

    // if (displayStore.goodsList.isEmpty) return _buildEmptyView(context);
    return StoreInfoView(store: displayStore);
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
