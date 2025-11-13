import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/utils/visual_logger_provider.dart';

class VisualLoggerVisibleBuilder extends ConsumerWidget {
  const VisualLoggerVisibleBuilder({
    required this.builder,
    super.key,
  });

  final Widget Function(BuildContext context, bool visible) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visibleAsync = ref.watch(visualLoggerVisibilityProvider);

    return visibleAsync.when(
      data: (visible) => builder(context, visible),
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
