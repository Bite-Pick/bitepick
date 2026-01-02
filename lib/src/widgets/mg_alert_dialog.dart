import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class MgAlertDialog extends StatelessWidget {
  final String? title;
  final Widget content;
  final Widget actions;

  const MgAlertDialog({
    super.key,
    required this.content,
    required this.actions,
    this.title,
  });

  /// 기본 AlertDialog (기존 동작)
  factory MgAlertDialog.basic({
    Key? key,
    required Widget content,
    required VoidCallback onConfirm,
    String? title,
    String confirmText = '예',
    String cancelText = '아니오',
    bool hasCancel = true,
  }) {
    return MgAlertDialog(
      key: key,
      title: title,
      content: content,
      actions: _buildBasicActions(
        onConfirm: onConfirm,
        confirmText: confirmText,
        cancelText: cancelText,
        hasCancel: hasCancel,
      ),
    );
  }

  static Widget _buildBasicActions({
    required VoidCallback onConfirm,
    required String confirmText,
    required String cancelText,
    required bool hasCancel,
  }) {
    return Builder(
      builder: (context) => Row(
        children: [
          if (hasCancel)
            Expanded(
              child: MgButton(
                onPressed: context.pop,
                content: Text(cancelText).textColor(MgColorScheme.gray4),
              ).gray(),
            ),
          if (hasCancel) Gaps.w8,
          Expanded(
            child: MgButton(
              onPressed: () {
                context.pop();
                onConfirm();
              },
              content: Text(confirmText),
            ).primary(),
          ),
        ],
      ).margin(top: MgSizes.size32),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MgRadius.md),
      ),
      title: title != null ? Text(title!).lg().bold().center() : null,
      content: Wrap(
        alignment: WrapAlignment.center,
        children: [
          content,
          actions,
        ],
      ),
    );
  }
}
