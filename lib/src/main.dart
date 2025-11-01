import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:magambell/src/core/utils/shorebird_manager.dart';
import 'package:magambell/src/main_app.dart';

Future<void> runMagamBellApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await runZonedGuarded<Future<void>>(() async {
    await dotenv.load(fileName: '.env');

    // Initialize Naver Map SDK
    await FlutterNaverMap().init(
      clientId: dotenv.env['NAVER_CLIENT_ID'] ?? '',
      onAuthFailed: (ex) {
        log('Naver Map authentication failed: $ex');
      },
    );

    // Shorebird 자동 업데이트 확인
    ShorebirdManager.checkAndDownloadUpdate();

    runApp(const MagambellApp());
  }, (error, stackTrace) => log(error.toString()));
}
