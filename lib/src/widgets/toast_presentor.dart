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
        transitionDuration: const Duration(milliseconds: 350),
        reverseTransitionDuration: const Duration(milliseconds: 250),
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
            forwardAnimationCurve: Curves.easeOutCubic,
            reverseAnimationCurve: Curves.easeInCubic,
            insetAnimationDuration: const Duration(milliseconds: 300),
            insetAnimationCurve: Curves.easeOut,
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
        transitionDuration: const Duration(milliseconds: 350),
        reverseTransitionDuration: const Duration(milliseconds: 250),
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
            forwardAnimationCurve: Curves.easeOutCubic,
            reverseAnimationCurve: Curves.easeInCubic,
            insetAnimationDuration: const Duration(milliseconds: 300),
            insetAnimationCurve: Curves.easeOut,
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
        transitionDuration: const Duration(milliseconds: 350),
        reverseTransitionDuration: const Duration(milliseconds: 250),
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
            forwardAnimationCurve: Curves.easeOutCubic,
            reverseAnimationCurve: Curves.easeInCubic,
            insetAnimationDuration: const Duration(milliseconds: 300),
            insetAnimationCurve: Curves.easeOut,
            elevation: 0,
          );
        },
      ),
    );
  }

  static void notificationToast(
    BuildContext context,
    String message,
  ) {
    unawaited(
      context.showFlash(
        duration: const Duration(milliseconds: 2000),
        transitionDuration: const Duration(milliseconds: 350),
        reverseTransitionDuration: const Duration(milliseconds: 250),
        builder: (context, controller) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: controller.controller,
              curve: Curves.easeOut,
              reverseCurve: Curves.easeIn,
            ),
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.85, end: 1.0).animate(
                CurvedAnimation(
                  parent: controller.controller,
                  curve: Curves.easeOutBack,
                  reverseCurve: Curves.easeIn,
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    margin: Gutter.wlg,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: MgColorScheme.gray1,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: MgColorScheme.systemSuccess,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(message).md().regular().textColor(Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
        transitionDuration: const Duration(milliseconds: 350),
        reverseTransitionDuration: const Duration(milliseconds: 250),
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
            forwardAnimationCurve: Curves.easeOutCubic,
            reverseAnimationCurve: Curves.easeInCubic,
            insetAnimationDuration: const Duration(milliseconds: 300),
            insetAnimationCurve: Curves.easeOut,
            elevation: 0,
          );
        },
      ),
    );
  }
}
