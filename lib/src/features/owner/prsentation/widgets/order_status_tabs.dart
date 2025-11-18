import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/order/domain/entities/order_owner_status.dart';

class OrderStatusTabs extends ConsumerWidget {
  final OrderOwnerStatus? selectedStatus;
  final Function(OrderOwnerStatus?) onStatusChanged;
  final Map<OrderOwnerStatus?, int> statusCounts;

  const OrderStatusTabs({
    super.key,
    required this.selectedStatus,
    required this.onStatusChanged,
    this.statusCounts = const {},
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusMenus = [
      OrderOwnerStatus.PAID,
      OrderOwnerStatus.ACCEPTED,
      OrderOwnerStatus.COMPLETED,
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child:
          Row(
                children: [
                  _buildTab(
                    label: '전체',
                    count: statusCounts[null] ?? 0,
                    isSelected: selectedStatus == null,
                    onTap: () => onStatusChanged(null),
                  ),
                  ...statusMenus.map(
                    (status) => _buildTab(
                      label: status.tabName,
                      count: statusCounts[status] ?? 0,
                      isSelected: selectedStatus == status,
                      onTap: () => onStatusChanged(status),
                    ),
                  ),
                ],
              )
              .decorated(
                borderRadius: BorderRadius.circular(999),
                color: MgColorScheme.gray11,
              )
              .margin(horizontal: MgSizes.xl),
    );
  }

  Widget _buildTab({
    required String label,
    required int count,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MgSizes.xl,
          vertical: MgSizes.size10,
        ),
        decoration: BoxDecoration(
          color: isSelected ? MgColorScheme.text : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text('$label $count')
            .md()
            .textColor(isSelected ? MgColorScheme.gray11 : MgColorScheme.gray4)
            .bold(),
      ),
    );
  }
}
