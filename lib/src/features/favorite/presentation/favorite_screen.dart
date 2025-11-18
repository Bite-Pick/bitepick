import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/features/favorite/data/repositories/favorite_repository.dart';
import 'package:magambell/src/features/home/presentation/widgets/home_goods_item.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';

class FavoriteRoute extends GoRouteData {
  const FavoriteRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FavoriteScreen();
  }
}

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  ConsumerState<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favoritesAsync = ref.watch(myFavoriteProvider);
    return BaseScaffold(
      appBar: BaseAppBar(title: const Text('관심 목록')),
      body: MgAsyncAnimatedSwitcher(
        asyncValue: favoritesAsync,
        emptyBuilder: () => Center(child: Text("관심 목록이 없습니다")),

        builder: (favorites) {
          return ListView.separated(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites[index];
              return HomeGoodsItem(
                goods: favorite.toHomeGoodsItem(),
              ).margin(horizontal: MgSizes.md);
            },
            separatorBuilder: (context, index) => Gaps.h16,
          ).margin(top: MgSizes.md);
        },
      ),
    );
  }
}
