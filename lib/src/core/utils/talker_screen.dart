import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerRoute extends GoRouteData {
  const TalkerRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MgTalkerScreen();
  }
}

class MgTalkerScreen extends ConsumerWidget {
  const MgTalkerScreen({
    super.key,
    this.appBarTitle = 'Talker',
    this.theme = const TalkerScreenTheme(),
  });

  final TalkerScreenTheme theme;
  final String appBarTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TalkerScreen(
      talker: talker,
      theme: TalkerScreenTheme(
        backgroundColor: theme.backgroundColor,
        logColors: {
          TalkerLogType.riverpodAdd.key: const Color(0xFF55FFFF),
          TalkerLogType.riverpodUpdate.key: const Color(0xFF58FF99),
          TalkerLogType.riverpodDispose.key: const Color(0xFFF40C66),
          TalkerLogType.debug.key: const Color(0xFFFAB86D),
        },
      ),
      appBarTitle: appBarTitle,
      appBarLeading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.pop(),
      ),
    );
  }
}
