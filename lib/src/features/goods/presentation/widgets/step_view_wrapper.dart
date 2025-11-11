import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';

class StoreRegisterViewWrapper extends StatelessWidget {
  final List<Widget> children;

  const StoreRegisterViewWrapper({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ).margin(horizontal: MgSizes.xl);
  }
}
