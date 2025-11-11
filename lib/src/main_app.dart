import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magambell/src/core/config/environment.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';

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
            return child!;
          },
        );
      },
    );
  }
}
