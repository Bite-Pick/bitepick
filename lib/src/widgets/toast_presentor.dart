import 'dart:async';

import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';

class ToastPresentor {
  static void info(
    BuildContext context,
    String message, {
    String? subtitle,
    Widget? action,
  }) {
    unawaited(
      context.showFlash(
        duration: const Duration(milliseconds: 2000),
        builder: (context, controller) {
          return FlashBar(
            controller: controller,
            title: subtitle != null
                ? Text(subtitle).sm().regular().textColor(MgColorScheme.gray1)
                : null,
            content: Text(message).md().regular().textColor(MgColorScheme.gray1),
            primaryAction: action,
            backgroundColor: MgColorScheme.primary,
            position: FlashPosition.top,
            behavior: FlashBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MgRadius.md),
            ),
            margin: Gutter.wlg + Gutter.hmd,
            insetAnimationDuration: const Duration(milliseconds: 300),
            elevation: 0,
          );
        },
      ),
    );
  }

  static void success(
    BuildContext context,
    String message, {
    String? subtitle,
    Widget? action,
  }) {
    unawaited(
      context.showFlash(
        duration: const Duration(milliseconds: 2000),
        builder: (context, controller) {
          return FlashBar(
            controller: controller,
            title: subtitle != null
                ? Text(subtitle).sm().regular().textColor(Colors.white)
                : null,
            content: Text(message).md().regular().textColor(Colors.white),
            primaryAction: action,
            backgroundColor: MgColorScheme.systemSuccess,
            position: FlashPosition.top,
            behavior: FlashBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MgRadius.md),
            ),
            margin: Gutter.wlg + Gutter.hmd,
            insetAnimationDuration: const Duration(milliseconds: 300),
            elevation: 0,
          );
        },
      ),
    );
  }

  static void error(
    BuildContext context,
    String message, {
    String? subtitle,
    Widget? action,
  }) {
    unawaited(
      context.showFlash(
        duration: const Duration(milliseconds: 2000),
        builder: (context, controller) {
          return FlashBar(
            controller: controller,
            title: subtitle != null
                ? Text(subtitle).sm().regular().textColor(Colors.white)
                : null,
            content: Text(message).md().regular().textColor(Colors.white),
            primaryAction: action,
            backgroundColor: MgColorScheme.systemError,
            position: FlashPosition.top,
            behavior: FlashBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MgRadius.md),
            ),
            margin: Gutter.wlg + Gutter.hmd,
            insetAnimationDuration: const Duration(milliseconds: 300),
            elevation: 0,
          );
        },
      ),
    );
  }

  static void bottomInfo(
    BuildContext context,
    String message, {
    String? subtitle,
  }) {
    unawaited(
      context.showFlash(
        duration: const Duration(milliseconds: 2000),
        builder: (context, controller) {
          return FlashBar(
            controller: controller,
            title: subtitle != null
                ? Text(subtitle).sm().regular().textColor(MgColorScheme.gray1)
                : null,
            content: Text(message).md().regular().textColor(MgColorScheme.gray1),
            backgroundColor: MgColorScheme.primaryLightest,
            position: FlashPosition.bottom,
            behavior: FlashBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MgRadius.md),
            ),
            margin: Gutter.wlg + Gutter.hmd,
            insetAnimationDuration: const Duration(milliseconds: 300),
            elevation: 0,
          );
        },
      ),
    );
  }
}
