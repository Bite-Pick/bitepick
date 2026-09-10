import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magambell/src/core/config/environment.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/core/utils/talker_screen.dart';
import 'package:magambell/src/core/utils/visual_logger_visible_builder.dart';
import 'package:magambell/src/widgets/visual_logger.dart';
import 'package:go_router/go_router.dart';

class MagambellApp extends ConsumerWidget {
  const MagambellApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (_, child) {
        return MaterialApp.router(
          title: Environment.appName,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ko')],
          theme: MgTheme.getInstance().themeData,
          routerConfig: router,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.noScaling,
              ),
              child: Stack(children: [child!, const _VisualElements()]),
            );
          },
        );
      },
    );
  }
}

class _VisualElements extends StatelessWidget {
  const _VisualElements();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100,
      right: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          VisualLoggerVisibleBuilder(
            builder: (context, visible) {
              if (!visible) return const SizedBox.shrink();
              return const VisualLogger();
            },
          ),
          if (MgTalker.isEnabled) ...[const SizedBox(height: 8)],
        ],
      ),
    );
  }
}
