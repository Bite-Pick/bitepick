import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/features/auth/providers/auth_token_manager.dart';

final globalProviderContainer = ProviderContainer();

class BaseProvider extends StatelessWidget {
  const BaseProvider({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      parent: globalProviderContainer,
      child: _EagerInitialization(child: child),
    );
  }
}

class _EagerInitialization extends ConsumerWidget {
  const _EagerInitialization({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Eager initialization: 앱 시작 시 필요한 provider들을 미리 초기화
    ref.watch(apiClientProvider);
    ref.watch(authTokenManagerProvider);

    return child;
  }
}
