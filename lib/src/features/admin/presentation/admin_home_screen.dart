import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';

class AdminHomeRoute extends GoRouteData {
  const AdminHomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminHomeScreen();
  }
}

class AdminHomeScreen extends ConsumerWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseScaffold(
      appBar: BaseAppBar(title: const Text('관리자 홈')),
      body: const Center(
        child: Text('Admin Home Screen'),
      ),
    );
  }
}
