import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/features/admin/data/repositories/admin_repository.dart';
import 'package:magambell/src/features/admin/presentation/widgets/pending_store_item.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_alert_dialog.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';

class WaitingStoreListRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return WaitingStoreListScreen();
  }
}

class WaitingStoreListScreen extends ConsumerStatefulWidget {
  const WaitingStoreListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WaitingStoreListScreenState();
}

class _WaitingStoreListScreenState
    extends ConsumerState<WaitingStoreListScreen> {
  @override
  Widget build(BuildContext context) {
    final pendingStoreListAsync = ref.watch(pendingStoreListProvider());
    return BaseScaffold(
      appBar: BaseAppBar(title: Text("가입 매장 승인")),
      body: MgAsyncAnimatedSwitcher(
        asyncValue: pendingStoreListAsync,
        builder: (stores) {
          return ListView.separated(
            itemCount: stores.length,
            itemBuilder: (context, index) {
              final store = stores[index];
              return PendingStoreItem(
                store,
                onApprove: () => _showApprovalDialog(context, store.storeId),
              );
            },
            separatorBuilder: (context, index) =>
                Divider().margin(vertical: MgSizes.md),
          );
        },
      ),
    );
  }

  void _showApprovalDialog(BuildContext context, String storeId) {
    showDialog(
      context: context,
      builder: (dialogContext) => MgAlertDialog(
        title: '가게를 승인하시겠습니까?',
        content: const Text('승인 시 가게에서 판매 등록이 가능합니다.'),
        confirmText: '승인',
        onConfirm: () async => _approveStore(storeId),
      ),
    );
  }

  /// 매장 승인 처리
  Future<void> _approveStore(String storeId) async {
    final res = await ref.read(adminRepositoryProvider).approveStore(storeId);

    // 로딩 다이얼로그 닫기
    if (res && mounted) {
      context.pop();
      ToastPresentor.success(context, '매장이 승인되었습니다');
    } else {
      ToastPresentor.success(context, '매장 승인이 실패하였습니다');
    }
  }
}
