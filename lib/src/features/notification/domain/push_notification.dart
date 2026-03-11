import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/notification/data/repositories/notification_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_notification.g.dart';

class PushNotification {
  PushNotification(this.ref);

  final Ref ref;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // TODO: 알림 dialog 뜨는 위치 점검 필요
    await requestPermission();
    await initNotification();
    await initLocalNotifications();
    setupMessageListeners();

    // 토큰 갱신 시 서버에 등록 (로그인되어 있으면)
    // listenToTokenRefresh(registerTokenToServer);
  }

  /// 앱 종료 상태에서 알림으로 실행되었는지 확인
  static Future<void> checkInitialMessage() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();

    if (initialMessage != null) {
      talker.info(
        '[FCM] App opened from notification: ${initialMessage.notification?.title}',
      );
      handleNotificationNavigation(initialMessage);
    }
  }

  /// 알림 권한 요청
  static Future<bool> requestPermission() async {
    final messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    final enabled =
        settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;

    talker.info('[FCM] Permission granted: $enabled');
    return enabled;
  }

  static Future<void> initNotification() async {
    final messaging = FirebaseMessaging.instance;

    // iOS foreground notification 옵션 설정
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    talker.info('[FCM] Push notification initialized');
  }

  /// 로컬 알림 초기화
  static Future<void> initLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: onNotificationTapped,
    );

    talker.info('[FCM] Local notifications initialized');
  }

  /// 알림 클릭 처리
  static void onNotificationTapped(NotificationResponse response) {
    talker.info('[FCM] Notification tapped: ${response.payload}');
    // TODO: 알림 클릭 시 화면 이동 처리
    // 예: Navigator.push(...) 또는 GoRouter.go(...)
  }

  /// 메시지 리스너 설정
  static void setupMessageListeners() {
    // Foreground 메시지 리스너
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      talker.info('[FCM] Foreground message: ${message.notification?.title}');

      if (message.notification != null) {
        showLocalNotification(message);
      }
    });

    // 백그라운드에서 알림 클릭
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      talker.info(
        '[FCM] Notification opened (background): ${message.notification?.title}',
      );
      handleNotificationNavigation(message);
    });
  }

  /// 알림 네비게이션 처리
  static void handleNotificationNavigation(RemoteMessage message) {
    // TODO: 알림 데이터에 따라 화면 이동
    final data = message.data;
    talker.debug('[FCM] Navigation data: $data');

    // 예시:
    // if (data.containsKey('storeId')) {
    //   GoRouter.of(context).go('/store/${data['storeId']}');
    // }
  }

  /// 로컬 알림 표시 (Foreground용)
  static Future<void> showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'high_importance_channel',
          '앱 알림',
          channelDescription: '바이트픽 푸시 알림',
          importance: Importance.high,
          priority: Priority.high,
        );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      details,
      payload: message.data.toString(),
    );

    talker.debug('[FCM] Local notification shown');
  }

  /// FCM 토큰 가져오기
  Future<String?> getToken() async {
    try {
      final messaging = FirebaseMessaging.instance;

      // iOS의 경우 APNS 토큰을 먼저 가져와야 함
      if (Platform.isIOS) {
        final apnsToken = await messaging.getAPNSToken();
        if (apnsToken == null) {
          talker.warning('[FCM] APNS token not available yet, retrying...');
          // APNS 토큰이 없으면 잠시 대기 후 재시도
          await Future.delayed(const Duration(seconds: 2));
          final retryApnsToken = await messaging.getAPNSToken();
          if (retryApnsToken == null) {
            talker.error('[FCM] APNS token still not available after retry');
            return null;
          }
          talker.debug('[FCM] APNS token retrieved on retry');
        } else {
          talker.debug('[FCM] APNS token: ${apnsToken.substring(0, 20)}...');
        }
      }

      final token = await messaging.getToken();
      talker.info('[FCM] Token retrieved: ${token?.substring(0, 20)}...');
      return token;
    } catch (e, stackTrace) {
      talker.error('[FCM] Failed to get token', e, stackTrace);
      return null;
    }
  }

  /// 토큰 갱신 리스너 등록
  void listenToTokenRefresh(Function onTokenRefresh) {
    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      talker.info('[FCM] Token refreshed: ${token.substring(0, 20)}...');
      onTokenRefresh();
    });
  }

  /// iOS Keychain 캐시 토큰 초기화 후 서버에 새 토큰 등록 (로그인 시 1회 호출)
  Future<void> refreshAndRegisterToken() async {
    if (Platform.isIOS) {
      await FirebaseMessaging.instance.deleteToken();
      talker.info('[FCM] Deleted existing token to force refresh');
    }
    await registerTokenToServer();
  }

  /// FCM 토큰을 서버에 등록
  Future<void> registerTokenToServer() async {
    try {
      final token = await getToken();
      if (token == null) {
        talker.warning('[FCM] Token is null, cannot register to server');
        return;
      }

      final success = await ref
          .read(notificationRepositoryProvider)
          .saveNotificationToken(token);

      success
          ? talker.info('[FCM] Token registered to server successfully')
          : talker.error('[FCM] Failed to register token to server');
    } catch (e, stackTrace) {
      talker.error('[FCM] Error registering token to server', e, stackTrace);
    }
  }
}

@riverpod
PushNotification pushNotification(Ref ref) {
  return PushNotification(ref);
}
