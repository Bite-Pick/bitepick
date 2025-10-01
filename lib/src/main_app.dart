import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:magambell/core/config/environment.dart';
import 'package:magambell/core/theme/mg_theme.dart';
import 'package:magambell/src/features/splash/presentation/splash_screen.dart';

class MagambellApp extends StatelessWidget {
  const MagambellApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Environment.appName,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ko')],
      theme: MgTheme.getInstance().themeData,
      home: const SplashScreen(),
      builder: (context, child) {
        return child!;
      },
    );
  }
}
