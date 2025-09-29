import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:magambell/src/features/splash/presentation/splash_screen.dart';

class MagambellApp extends StatelessWidget {
  const MagambellApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magambell',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ko')],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashScreen(),
      builder: (context, child) {
        return child!;
      },
    );
  }
}