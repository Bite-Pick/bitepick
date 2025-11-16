import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/features/auth/data/repositories/withdraw_controller.dart';
import 'package:magambell/src/features/auth/providers/auth_token_manager.dart';
import 'package:magambell/src/features/user/providers/user.provider.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';

Future<void> logout(WidgetRef ref, BuildContext context) async {
  await ref.read(authTokenManagerProvider.notifier).deleteTokens();
  ref.invalidate(userStateProvider);
  if (context.mounted) DefaultRoute().go(context);
}

Future<void> withDraw(WidgetRef ref, BuildContext context) async {
  final res = await ref
      .read(withdrawControllerProvider.notifier)
      .withdraw(context: context);
  if (res) {
    ToastPresentor.success(context, "회원탈퇴이 완료되었습니다");
    await logout(ref, context);
  }
}
