import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/order/presentation/widget/order_owner_info_item.dart';
import 'package:magambell/src/features/owner/prsentation/owner_order_list_view.controller.dart';
import 'package:magambell/src/features/owner/prsentation/widgets/order_status_tabs.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';

class OwnerOrderListView extends ConsumerWidget {
  const OwnerOrderListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerAsync = ref.watch(ownerOrderListControllerProvider);

    return MgAsyncAnimatedSwitcher(
      asyncValue: controllerAsync,
      builder: (controllerState) {
        if (controllerState.isLoading && controllerState.orders.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        final controller = ref.read(ownerOrderListControllerProvider.notifier);

        return Column(
          children: [
            // 상태 탭
            OrderStatusTabs(
              selectedStatus: controllerState.selectedStatus,
              statusCounts: controllerState.statusCounts,
              onStatusChanged: (status) => controller.changeStatus(status),
            ).margin(top: MgSizes.lg, bottom: MgSizes.md),

            // 주문 목록
            Expanded(
              child: controllerState.orders.isEmpty
                  ? Center(
                      child: Text(
                        '주문이 없습니다.',
                      ).md().textColor(MgColorScheme.gray4),
                    )
                  : RefreshIndicator(
                      onRefresh: () => controller.refresh(),
                      child: ListView.separated(
                        itemCount: controllerState.orders.length,
                        itemBuilder: (context, index) {
                          final order = controllerState.orders[index];
                          return OrderOwnerInfoItem(order)
                              .margin(top: index == 0 ? MgSizes.lg : 0);
                        },
                        separatorBuilder: (context, index) => Gaps.h20,
                      ).margin(horizontal: MgSizes.xl),
                    ),
            ),
          ],
        ).colored(MgColorScheme.gray9);
      },
    );
  }
}
