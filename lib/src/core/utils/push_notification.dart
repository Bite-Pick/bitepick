import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';

/// 백그라운드 메시지 핸들러 (톱레벨 함수)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // 백그라운드 핸들러는 별도 isolate에서 실행되므로 Firebase 초기화 필요
  await Firebase.initializeApp();
  talker.info('[FCM] Background message: ${message.notification?.title}');
}

class PushNotification {
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    await _requestPermission();
    await _initNotification();
    await _initLocalNotifications();
    _setupMessageListeners();
  }

  /// 알림 권한 요청
  static Future<bool> _requestPermission() async {
    final messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    final enabled = settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;

    talker.info('[FCM] Permission granted: $enabled');
    return enabled;
  }

  static Future<void> _initNotification() async {
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
  static Future<void> _initLocalNotifications() async {
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
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    talker.info('[FCM] Local notifications initialized');
  }

  /// 알림 클릭 처리
  static void _onNotificationTapped(NotificationResponse response) {
    talker.info('[FCM] Notification tapped: ${response.payload}');
    // TODO: 알림 클릭 시 화면 이동 처리
    // 예: Navigator.push(...) 또는 GoRouter.go(...)
  }

  /// 메시지 리스너 설정
  static void _setupMessageListeners() {
    // Foreground 메시지 리스너
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      talker.info('[FCM] Foreground message: ${message.notification?.title}');

      if (message.notification != null) {
        _showLocalNotification(message);
      }
    });

    // 백그라운드에서 알림 클릭
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      talker.info('[FCM] Notification opened (background): ${message.notification?.title}');
      _handleNotificationNavigation(message);
    });
  }

  /// 앱 종료 상태에서 알림으로 실행되었는지 확인
  static Future<void> checkInitialMessage() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      talker.info('[FCM] App opened from notification: ${initialMessage.notification?.title}');
      _handleNotificationNavigation(initialMessage);
    }
  }

  /// 알림 네비게이션 처리
  static void _handleNotificationNavigation(RemoteMessage message) {
    // TODO: 알림 데이터에 따라 화면 이동
    final data = message.data;
    talker.debug('[FCM] Navigation data: $data');

    // 예시:
    // if (data.containsKey('storeId')) {
    //   GoRouter.of(context).go('/store/${data['storeId']}');
    // }
  }

  /// 로컬 알림 표시 (Foreground용)
  static Future<void> _showLocalNotification(RemoteMessage message) async {
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
  static Future<String?> getToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      talker.info('[FCM] Token retrieved: ${token?.substring(0, 20)}...');
      return token;
    } catch (e, stackTrace) {
      talker.error('[FCM] Failed to get token', e, stackTrace);
      return null;
    }
  }

  /// 토큰 갱신 리스너 등록
  static void listenToTokenRefresh(Function(String) onTokenRefresh) {
    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      talker.info('[FCM] Token refreshed: ${token.substring(0, 20)}...');
      onTokenRefresh(token);
    });
  }

  /// 알림 권한 요청 (수동 호출용)
  static Future<bool> requestPermission() async {
    return await _requestPermission();
  }
}
