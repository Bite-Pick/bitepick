import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/assets.dart';
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
      onRetry: () => ref.invalidate(ownerOrderListControllerProvider),
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
                  ? Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            R.ASSETS_IMAGES_NO_ORDER_PNG,
                            width: 80,
                            height: 80,
                          ),
                          Gaps.h16,
                          Text('아직 주문이 없어요')
                              .md()
                              .semibold()
                              .center()
                              .height(1.5)
                              .letterSpacing(MgFontSize.md * -0.025)
                              .textColor(NewColorScheme.gray4),
                        ],
                      ).margin(top: MgSizes.xxxxxl + MgSizes.xs),
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
