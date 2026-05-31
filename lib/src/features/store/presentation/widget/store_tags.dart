import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/list_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_tag.dart';

const _tagTextStyle = TextStyle(
  fontFamily: MgFontFamily.semiBold,
  fontWeight: FontWeight.w600,
  fontSize: 12,
  height: 1.5,
  letterSpacing: -0.3,
);

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
    if (saleStatus == "ON") {
      tags.add(
        MgTag(child: Text("픽업 가능", style: _tagTextStyle)).copyWith(
          backgroundColor: NewColorScheme.systemNeutral,
          color: NewColorScheme.systemAlert,
        ),
      );
    } else {
      tags.add(
        MgTag(child: Text("예약 마감", style: _tagTextStyle)).copyWith(
          backgroundColor: NewColorScheme.gray12,
          color: NewColorScheme.gray6,
        ),
      );
    }

    if (quantity > 0) {
      tags.add(
        quantity >= 10
            ? MgTag(child: Text('재고있음')).gray()
            : MgTag(child: Text('${quantity.toInt()}개 남음', style: _tagTextStyle)).copyWith(
                backgroundColor: NewColorScheme.systemAlert,
                color: NewColorScheme.gray14,
              ),
      );
    }

    if (tags.isEmpty) return SizedBox.shrink();

    return Row(
      children: tags.joinWithWidget(Gaps.w4),
    ).margin(bottom: MgSizes.sm);
  }
}
