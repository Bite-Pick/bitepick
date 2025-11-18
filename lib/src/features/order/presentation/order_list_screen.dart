import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/utils/debug_text.dart';
import 'package:magambell/src/features/order/domain/entities/order_guest.dart';
import 'package:magambell/src/features/order/presentation/widget/order_list_item.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = mockOrders;
    return BaseScaffold(
      canSwipeBack: false,
      appBar: BaseAppBar(
        title: const Text('주문 내역'),
        leading: const SizedBox.shrink(),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Column(
            children: [
              OrderListItem(order),
              if (index != orders.length - 1)
                Divider(thickness: 6).margin(vertical: MgSizes.lg),
            ],
          );
        },
      ),
    );
  }
}
