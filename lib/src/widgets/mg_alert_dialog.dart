import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class MgAlertDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final VoidCallback onConfirm;
  final String? confirmText;
  final String? cancelText;
  final bool hasCancel;

  const MgAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.confirmText = '예',
    this.cancelText = '아니오',
    this.hasCancel = true,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MgRadius.md),
      ),
      title: Text(title).lg().bold().center(),
      content: Wrap(
        alignment: WrapAlignment.center,
        children: [
          content,
          Row(
            children: [
              if (hasCancel)
                Expanded(
                  child: MgButton(
                    onPressed: context.pop,
                    content: Text(cancelText!).textColor(MgColorScheme.gray4),
                  ).gray(),
                ),
              Gaps.w8,
              Expanded(
                child: MgButton(
                  onPressed: () {
                    context.pop();
                    onConfirm();
                  },
                  content: Text(confirmText!),
                ).primary(),
              ),
            ],
          ).margin(top: MgSizes.size32),
        ],
      ),
    );
  }
}
