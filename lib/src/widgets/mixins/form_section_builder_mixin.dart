import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';

/// 폼 섹션 타이틀을 빌드하는 공통 기능을 제공하는 Mixin
mixin FormSectionBuilderMixin {
  /// 섹션 타이틀을 빌드합니다.
  ///
  /// [title]: 섹션의 제목
  /// [subtitle]: 선택적으로 표시할 부제목 (설명)
  Widget buildSectionTitle(String title, {String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title).md().bold(),
        if (subtitle != null) ...[
          Gaps.h2,
          Text(subtitle).sm().textGray().regular(),
        ],
      ],
    ).margin(top: MgSizes.xl, bottom: MgSizes.xs);
  }
}
