import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';

class BannerRegisterRoute extends GoRouteData {
  const BannerRegisterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BannerRegisterScreen();
  }
}

class BannerRegisterScreen extends ConsumerWidget {
  const BannerRegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseScaffold(
      appBar: BaseAppBar(title: const Text('배너 등록')),
      body: const Center(
        child: Text('Banner Register Screen'),
      ),
    );
  }
}
