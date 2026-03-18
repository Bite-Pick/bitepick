import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/features/admin/data/dtos/registered_store.dto.dart';
import 'package:magambell/src/features/store/presentation/widget/store_image_section.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class AdminRegisteredStoreItem extends StatelessWidget {
  final RegisteredStoreDto store;
  final VoidCallback onEdit;

  const AdminRegisteredStoreItem(this.store, {super.key, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTextStyle(
          style: context.textTheme.titleLarge!,
          child: Row(
            children: [
              Expanded(child: Text(store.storeName).md()),
              GestureDetector(
                onTap: onEdit,
                child: Container(
                  width: 51,
                  height: 31,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      color: const Color(0xFF686868),
                      width: 0.5,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Color(0xFF686868),
                    ),
                    child: Text("수정"),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(store.address).sm().textGray(),
        Text(store.address).sm().textGray(),
        // 주소
        Gaps.h12,
        StoreImageSection(store.imageUrl),
        Gaps.h8,
      ],
    ).margin(horizontal: MgSizes.xl);
  }
}