import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/widgets/mg_text_rich.dart';

class GoodsRegisterFormTitle extends StatelessWidget {
  const GoodsRegisterFormTitle({
    super.key,
    required this.title,
    this.subtitles = const <TextSpan>[],
  });

  final String title;
  final List<TextSpan> subtitles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title).md().bold(),
        if (subtitles.isNotEmpty)
          MgTextRich(
            style: context.textTheme.bodyMedium!.copyWith(
              color: MgColorScheme.gray4,
            ),
            children: subtitles,
          ),
        Gaps.h8,
      ],
    );
  }
}
