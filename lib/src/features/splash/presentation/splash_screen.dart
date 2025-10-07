import 'package:flutter/material.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/mg_textfield.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: const Text('Magambell')),
      body: Center(
        child: Column(
          children: [
            MgTextField(label: "이메일"),
            MgButton(
              onPressed: () {},
              content: Text("홈으로 이동"),
            ).primary(whiteBg: true),
          ],
        ),
      ),
    );
  }
}
