import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/config/environment.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/utils/talker_screen.dart';

class VisualLogger extends ConsumerWidget {
  const VisualLogger({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Gaps.h16,
        GestureDetector(
          onTap: () {
            final router = ref.read(appRouterProvider);
            router.push(const TalkerRoute().location);
          },
          child: _ShowLogButton(),
        ),
      ],
    );
  }
}

class _ShowLogButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Environment.instance.isProd) return SizedBox.shrink();
    return _DecoratedContainer(
      child: Text(
        "Show\nLog",
        style: TextStyle(color: Colors.red, decoration: TextDecoration.none),
      ).xs().bold(),
    );
  }
}

class _DecoratedContainer extends StatelessWidget {
  const _DecoratedContainer({this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        border: Border.all(color: Colors.black.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: child),
    );
  }
}
