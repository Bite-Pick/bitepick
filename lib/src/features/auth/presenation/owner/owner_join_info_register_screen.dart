import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OwnerJoinInfoRoute extends GoRouteData {
  const OwnerJoinInfoRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const OwnerJoinInfoScreen();
  }
}

class OwnerJoinInfoScreen extends ConsumerStatefulWidget {
  const OwnerJoinInfoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OwnerJoinInfoScreenState();
}

class _OwnerJoinInfoScreenState extends ConsumerState<OwnerJoinInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
