import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/features/favorite/data/repositories/favorite_repository.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';

class StoreFavoriteIcon extends ConsumerWidget {
  const StoreFavoriteIcon(this.storeId, {super.key});
  final String storeId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteAsync = ref.watch(favoriteProvider(storeId: storeId));
    return GestureDetector(
      onTap: () async {
        final favoriteState = await ref.read(
          favoriteProvider(storeId: storeId).future,
        );
        favoriteState == true
            ? await ref.read(favoriteRepositoryProvider).removeFavorite(storeId)
            : await ref.read(favoriteRepositoryProvider).addFavorite(storeId);
        ref.invalidate(favoriteProvider(storeId: storeId));
      },
      child: MgAsyncAnimatedSwitcher(
        asyncValue: favoriteAsync,
        builder: (isFavorite) {
          return (isFavorite == true)
              ? BaseSvgIcon.heartFilled(color: MgColorScheme.navigationPrimary)
              : BaseSvgIcon.heart();
        },
      ),
    );
  }
}
