import 'package:flutter/material.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/widgets/mg_alert_dialog.dart';

Future<void> showLoginAlerDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) => LoginUserAlertDialog(),
  );
}

class LoginUserAlertDialog extends StatelessWidget {
  const LoginUserAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return MgAlertDialog.basic(
      title: "로그인이 필요한 기능입니다",
      content: Text("로그인을 진행하시겠습니까?"),
      confirmText: "예",
      onConfirm: () {
        LoginRoute().go(context);
      },
    );
  }
}
