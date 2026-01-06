import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/list_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_tag.dart';

class StoreTags extends StatelessWidget {
  const StoreTags({
    super.key,
    required this.quantity,
    required this.saleStatus,
  });
  final int quantity;
  final String saleStatus;
  @override
  Widget build(BuildContext context) {
    final List<Widget> tags = [];
    // TODO: saleStatus enum으로 변경및 조건문 수정
    if (saleStatus == "ON") tags.add(MgTag(child: Text("픽업가능")));
    if (quantity > 0) {
      tags.add(
        quantity >= 10
            ? MgTag(child: Text('재고있음')).gray()
            : MgTag(child: Text('${quantity.toInt()}개 남음')).danger(),
      );
    }

    if (quantity > 0 && quantity <= 4) {
      tags.add(
        MgTag(
          prefix: BaseSvgIcon.time(
            size: MgSizes.md,
            color: MgColorScheme.systemError,
          ),
          child: Text('품절임박'),
        ).danger(light: true),
      );
    }
    if (tags.isEmpty) return SizedBox.shrink();

    return Row(
      children: tags.joinWithWidget(Gaps.w6),
    ).margin(bottom: MgSizes.sm);
  }
}
