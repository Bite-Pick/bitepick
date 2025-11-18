import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.drawer,
    this.endDrawer,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.unfocusWhenTapOpaque = true,
    this.extendBodyBehindAppBar = false,
    this.hasBottomMargin = true,
    this.resizeToAvoidBottomInset,
    this.onTap,
    this.onBack,
    this.canSwipeBack = true,
  });
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool unfocusWhenTapOpaque;
  final bool extendBodyBehindAppBar;
  final bool hasBottomMargin;
  final bool? resizeToAvoidBottomInset;
  final VoidCallback? onTap;
  final Future<bool> Function()? onBack;
  final bool canSwipeBack;

  static BaseScaffold of(BuildContext context) {
    final widget = context.findAncestorWidgetOfExactType<BaseScaffold>();
    assert(widget != null, 'BaseScaffold를 위젯트리 최상단에 위치시켜주세요');
    return widget!;
  }

  static double getBottomMargin(BuildContext context) {
    return math.max(
      MediaQuery.of(context).viewPadding.bottom,
      MediaQuery.of(context).systemGestureInsets.bottom,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double bottomNotchPadding = getBottomMargin(context);

    return PopScope(
      canPop: canSwipeBack,
      onPopInvokedWithResult: (didPop, _) async {
        if (onBack != null) {
          await onBack!.call();
        }
      },
      child: GestureDetector(
        onTap: () {
          if (unfocusWhenTapOpaque) {
            WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
          }
          if (onTap != null) onTap!.call();
        },
        child: Scaffold(
          appBar: appBar,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          drawer: drawer,
          endDrawer: endDrawer,
          body: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyLarge!,
            child: bottomNavigationBar == null && hasBottomMargin
                ? Padding(
                    padding: EdgeInsets.only(bottom: bottomNotchPadding),
                    child: body,
                  )
                : body,
          ),
          floatingActionButton: floatingActionButton,
          backgroundColor: backgroundColor,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          bottomNavigationBar: bottomNavigationBar == null
              ? null
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    bottomNavigationBar!,
                    // if (hasBottomMargin)
                    //   Container(
                    //     height: bottomNotchPadding,
                    //     color:
                    //         Theme.of(
                    //           context,
                    //         ).bottomNavigationBarTheme.backgroundColor ??
                    //         Theme.of(context).colorScheme.surface,
                    //   ),
                  ],
                ),
        ),
      ),
    );
  }
}
