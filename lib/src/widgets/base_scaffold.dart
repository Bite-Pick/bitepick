import 'dart:async';

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
    this.onTap,
    this.onBack,
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
  final VoidCallback? onTap;
  final Future<bool> Function()? onBack;

  static BaseScaffold of(BuildContext context) {
    final widget = context.findAncestorWidgetOfExactType<BaseScaffold>();
    assert(widget != null, 'BaseScaffold를 위젯트리 최상단에 위치시켜주세요');
    return widget!;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
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
            child: body,
          ),
          floatingActionButton: floatingActionButton,
          backgroundColor: backgroundColor,
          bottomNavigationBar: bottomNavigationBar,
        ),
      ),
    );
  }
}
