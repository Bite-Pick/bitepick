import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/features/admin/data/repositories/admin_repository.dart';
import 'package:magambell/src/features/admin/presentation/admin_registered_store_detail_screen.dart';
import 'package:magambell/src/features/admin/presentation/widgets/registered_store_item.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';

class AdminRegisteredStoreListRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminRegisteredStoreListScreen();
  }
}

class AdminRegisteredStoreListScreen extends ConsumerStatefulWidget {
  const AdminRegisteredStoreListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
    _AdminRegisteredStoreListScreenState();
}

class _AdminRegisteredStoreListScreenState
    extends ConsumerState<AdminRegisteredStoreListScreen> {
  @override
  Widget build(BuildContext context) {
    final registeredStoreListAsync = ref.watch(registeredStoreListProvider);
    return BaseScaffold(
      appBar: const BaseAppBar(title: Text("입점 매장 관리")),
      body: MgAsyncAnimatedSwitcher(
        asyncValue: registeredStoreListAsync,
        builder: (stores) {
          return ListView.separated(
            itemCount: stores.length,
            itemBuilder: (context, index) {
              final store = stores[index];
              return AdminRegisteredStoreItem(
                store,
                onEdit: () async => AdminRegisteredStoreDetailRoute(
                  $extra: AdminRegisteredStoreDetailExtra(registeredStore: store),
                ).go(context),
              );
            },
            separatorBuilder: (context, index) =>
              const Divider().margin(vertical: MgSizes.md),
          );
        },
      ),
    );
  }
}