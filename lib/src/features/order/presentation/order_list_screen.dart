import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/order/data/repositories/order_repository.dart';
import 'package:magambell/src/features/order/presentation/widget/order_list_item.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';

class OrderListScreen extends ConsumerWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(userOrdersProvider());
    return BaseScaffold(
      canSwipeBack: false,
      appBar: BaseAppBar(
        title: const Text('주문 내역'),
        leading: const SizedBox.shrink(),
      ),
      body: MgAsyncAnimatedSwitcher(
        asyncValue: ordersAsync,
        emptyBuilder: () => _buildEmptyView(),
        builder: (orders) {
          return ListView.separated(
            itemCount: orders.length,
            separatorBuilder: (context, index) =>
                Divider(thickness: 6).margin(vertical: MgSizes.lg),
            itemBuilder: (context, index) {
              final order = orders[index];
              return OrderListItem(order.toOrderListItemState());
            },
          );
        },
      ),
    );
  }

  // TODO: 공통 컴포넌트로 분리
  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(R.ASSETS_IMAGES_CHARACTER_1_PNG, height: 165.h),
          Gaps.h12,
          Text("앗! 아직 주문내역이 없어요").bold(),
        ],
      ),
    );
  }
}
