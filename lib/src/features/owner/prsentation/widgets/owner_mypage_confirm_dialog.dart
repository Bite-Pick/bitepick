import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/widgets/mg_button.dart';

void showOwnerMypageConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    builder: (dialogContext) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MgRadius.md + MgSizes.xss)),
      child: SizedBox(
        width: 320,
        child: Padding(
          padding: const EdgeInsets.all(MgSizes.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: dialogContext.textTheme.headlineMedium?.copyWith(color: NewColorScheme.gray2),
              ),
              Gaps.h(MgSizes.xss),
              Text(
                message,
                style: dialogContext.textTheme.labelLarge?.copyWith(color: NewColorScheme.gray5),
              ),
              Gaps.h(MgSizes.xl + MgSizes.size1),
              Row(
                children: [
                  Expanded(
                    child: MgButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      backgroundColor: NewColorScheme.gray14,
                      textColor: NewColorScheme.gray1,
                      borderColor: MgColorScheme.gray7,
                      content: const Text('닫기').medium(),
                    ),
                  ),
                  Gaps.w10,
                  Expanded(
                    child: MgButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        onConfirm();
                      },
                      content: Text(title).semibold(),
                    ).primary(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
