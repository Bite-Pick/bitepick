import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
import 'package:magambell/src/core/extensions/price_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/features/admin/data/dtos/pending_store.dto.dart';
import 'package:magambell/src/features/store/presentation/widget/store_image_section.dart';
import 'package:magambell/src/features/store/presentation/widget/store_tags.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class PendingStoreItem extends StatelessWidget {
  final PendingStoreDto store;
  final VoidCallback onApprove;

  const PendingStoreItem(this.store, {super.key, required this.onApprove});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 매장 이미지
        StoreImageSection(store.imageUrl),
        Gaps.h8,

        // 매장 이름 & 할인/가격
        DefaultTextStyle(
          style: context.textTheme.titleLarge!,
          child: Row(
            children: [
              Expanded(child: Text(store.storeName).md()),
              Text('${store.discount}%').red(),
              Gaps.w4,
              Text('${store.salePrice.toPrice()}원'),
              Gaps.w12,
            ],
          ),
        ),

        // 픽업시간 & 거리
        Text(
          "픽업시간 : ${store.startTime.convertTime() ?? ''} ~ ${store.endTime.convertTime() ?? ''}",
        ),
        Gaps.h4,

        // 수량 & 판매상태
        StoreTags(
          quantity: store.quantity,
          saleStatus: store.saleStatus,
        ).margin(left: MgSizes.size4),
        Gaps.h8,

        // 주소
        Text(
          store.address,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ).margin(left: MgSizes.size4),
        Gaps.h12,

        // 승인 버튼
        MgButton(onPressed: onApprove, content: Text("승인")).primary(),
      ],
    ).margin(horizontal: MgSizes.md, vertical: MgSizes.sm);
  }
}
