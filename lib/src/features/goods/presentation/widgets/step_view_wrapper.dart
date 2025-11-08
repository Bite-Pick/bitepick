import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';

class StoreRegisterViewWrapper extends StatelessWidget {
  final List<Widget> children;

  const StoreRegisterViewWrapper({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: MgSizes.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
