import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/features/admin/data/dtos/pending_store.dto.dart';
import 'package:magambell/src/features/store/presentation/widget/store_image_section.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class AdminPendingStoreItem extends StatelessWidget {
  final PendingStoreDto store;
  final VoidCallback onApprove;

  const AdminPendingStoreItem(this.store, {super.key, required this.onApprove});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 매장 이름 & 할인/가격
        DefaultTextStyle(
          style: context.textTheme.titleLarge!,
          child: Row(
            children: [
              Expanded(child: Text(store.storeName).md()),
              MgButton(
                onPressed: onApprove,
                content: Text("검토").md(),
                padding: Gutter.wsm + Gutter.hxss,
              ).red(light: true),
            ],
          ),
        ),
        Text(store.address).sm().textGray(),
        Text(store.address).sm().textGray(),
        // 주소
        Gaps.h12,
        StoreImageSection(store.storeImages),
        Gaps.h8,
      ],
    ).margin(horizontal: MgSizes.xl);
  }
}
