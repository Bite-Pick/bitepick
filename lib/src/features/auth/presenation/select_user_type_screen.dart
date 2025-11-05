import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SelectUserTypeRoute extends GoRouteData {
  const SelectUserTypeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SelectUserTypeScreen();
  }
}

class SelectUserTypeScreen extends ConsumerWidget {
  const SelectUserTypeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
