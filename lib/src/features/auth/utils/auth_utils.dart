import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/features/auth/providers/auth_token_manager.dart';
import 'package:magambell/src/features/user/providers/user.provider.dart';

Future<void> logout(WidgetRef ref, BuildContext context) async {
  await ref.read(authTokenManagerProvider.notifier).deleteTokens();
  ref.invalidate(userStateProvider);
  if (context.mounted) {
    context.go('/');
  }
}
