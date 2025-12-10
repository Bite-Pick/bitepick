import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/features/admin/data/repositories/admin_repository.dart';
import 'package:magambell/src/features/admin/presentation/admin_pending_store_detail_screen.dart';
import 'package:magambell/src/features/admin/presentation/widgets/pending_store_item.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';

class AdminPendingStoreListRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdmingPendingStoreListScreen();
  }
}

class AdmingPendingStoreListScreen extends ConsumerStatefulWidget {
  const AdmingPendingStoreListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdmingPendingStoreListScreenState();
}

class _AdmingPendingStoreListScreenState
    extends ConsumerState<AdmingPendingStoreListScreen> {
  @override
  Widget build(BuildContext context) {
    final pendingStoreListAsync = ref.watch(pendingStoreListProvider());
    return BaseScaffold(
      appBar: const BaseAppBar(title: Text("가입 매장 승인")),
      body: MgAsyncAnimatedSwitcher(
        asyncValue: pendingStoreListAsync,
        builder: (stores) {
          return ListView.separated(
            itemCount: stores.length,
            itemBuilder: (context, index) {
              final store = stores[index];
              return AdminPendingStoreItem(
                store,
                onApprove: () async => AdminPendingStoreDetailRoute(
                  $extra: AdminPendingStoreDetailExtra(pendingStore: store),
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
