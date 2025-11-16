import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:magambell/src/core/config/environment.dart';
import 'package:magambell/src/core/providers/base_provider.dart';
import 'package:magambell/src/core/utils/global_error_handler.dart';
import 'package:magambell/src/core/utils/push_notification.dart';
import 'package:magambell/src/core/utils/shorebird_manager.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/main_app.dart';

/// Background Message Handler (Top-level function 필수)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(
  RemoteMessage remoteMessage,
) async {
  try {
    // 백그라운드 핸들러는 별도 isolate에서 실행되므로 Firebase 초기화 필요
    await Firebase.initializeApp();
    talker.info('[FCM] Background message received: ${remoteMessage.messageId}');
    // Background에서 서버에 푸시 수신 로그 전송 등의 처리 가능
  } catch (e, stackTrace) {
    talker.error('[FCM] Background handler error', e, stackTrace);
  }
}

Future<void> runMagamBellApp() async {
  // Initialize Talker for logging FIRST (before runZonedGuarded)
  MgTalker.init();

  await runZonedGuarded<Future<void>>(
    () async {
      // Move WidgetsFlutterBinding inside the zone to avoid zone mismatch
      WidgetsFlutterBinding.ensureInitialized();

      await dotenv.load(fileName: '.env');

      // Firebase 초기화
      if (Platform.isAndroid) {
        await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: Environment.firebaseApiKey,
            appId: Environment.firebaseAppId,
            messagingSenderId: Environment.firebaseMessagingSenderId,
            projectId: Environment.firebaseProjectId,
          ),
        );
      } else {
        await Firebase.initializeApp();
      }

      // Background Message Handler 등록
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );

      // Push Notification 초기화
      await PushNotification.initialize();

      // 앱 종료 상태에서 알림으로 실행되었는지 확인
      await PushNotification.checkInitialMessage();

      // Initialize Kakao SDK
      KakaoSdk.init(nativeAppKey: Environment.kakaoNativeAppKey);

      // Initialize Naver Map SDK
      await FlutterNaverMap().init(
        clientId: dotenv.env['NAVER_CLIENT_ID'] ?? '',
        onAuthFailed: (ex) {
          log('Naver Map authentication failed: $ex');
        },
      );

      // Shorebird 자동 업데이트 확인
      ShorebirdManager.checkAndDownloadUpdate();

      // Initialize GlobalErrorHandler and run app
      await GlobalErrorHandler().initialize(
        appRunner: () async {
          runApp(const BaseProvider(child: MagambellApp()));
        },
      );

      // Flutter error handler
      FlutterError.onError = (FlutterErrorDetails details) {
        GlobalErrorHandler().onErrorDetails(details);
      };
    },
    (error, stackTrace) async {
      await GlobalErrorHandler().onError(error, stackTrace);
      debugPrint('🔴 UNCAUGHT ERROR: $error');
      debugPrint('$stackTrace');
    },
  );
}
