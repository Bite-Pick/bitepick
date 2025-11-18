import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';

class MyReviewListRoute extends GoRouteData {
  const MyReviewListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MyReviewListScreen();
  }
}

class MyReviewListScreen extends ConsumerWidget {
  const MyReviewListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseScaffold(
      appBar: BaseAppBar(title: const Text('내가 쓴 리뷰')),
      body: const Center(
        child: Text('My Review List Screen'),
      ),
    );
  }
}
