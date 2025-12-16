import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/address/domain/entities/address.dart';
import 'package:magambell/src/features/address/presentation/search_address_screen.controller.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';

class SearchAddressResultItem extends ConsumerWidget {
  const SearchAddressResultItem(
    this.address, {
    super.key,
    this.isEditMode = false,
  });

  final Address address;
  final bool isEditMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(searchAddressScreenControllerProvider.notifier);

    return GestureDetector(
      onTap: isEditMode ? null : () => controller.selectFromSaved(address),
      child: Row(
        children: [
          BaseSvgIcon.mapPin(size: 20).gray(),
          Gaps.w12,
          Text(address.label).md().bold(),
          Spacer(),
          if (isEditMode) ...[
            Gaps.w12,
            GestureDetector(
              onTap: () => controller.deleteAddress(address),
              child: BaseSvgIcon.trash(
                size: 20,
              ).color(MgColorScheme.systemError),
            ),
          ] else if (address.isDefault) ...[
            Gaps.w12,
            BaseSvgIcon.check(size: 20).color(MgColorScheme.primary),
          ],
        ],
      ).margin(all: MgSizes.md),
    );
  }
}
