import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/features/auth/data/repositories/withdraw_controller.dart';
import 'package:magambell/src/features/auth/presenation/owner/owner_join_info_screen.controller.dart';
import 'package:magambell/src/features/auth/providers/auth_token_manager.dart';
import 'package:magambell/src/features/user/providers/user.provider.dart';
import 'package:magambell/src/widgets/mg_alert_dialog.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';

Future<void> logout(
  WidgetRef ref,
  BuildContext context, {
  bool showAlertDialog = true,
}) async {
  if (showAlertDialog) {
    bool ok = false;
    await showDialog(
      context: context,
      builder: (context) => MgAlertDialog.basic(
        title: "로그아웃 하시겠어요?",
        content: Text("다음에 또 만나요!"),
        onConfirm: () => ok = true,
      ),
    );
    if (!ok) return;
  }

  await ref.read(authTokenManagerProvider.notifier).deleteTokens();
  ref.invalidate(userStateProvider);
  ref.invalidate(ownerJoinInfoScreenControllerProvider);
  if (context.mounted) DefaultRoute().go(context);
}

Future<void> withDraw(WidgetRef ref, BuildContext context) async {
  final res = await ref
      .read(withdrawControllerProvider.notifier)
      .withdraw(context: context);
  if (res) {
    ToastPresentor.success(context, "회원탈퇴가 완료되었습니다");
    await logout(ref, context, showAlertDialog: false);
  }
}
