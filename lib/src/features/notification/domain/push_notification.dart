import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/core/navigator/navigator_controller.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/auth/domain/entities/user_role.dart';
import 'package:magambell/src/features/notification/data/repositories/notification_repository.dart';
import 'package:magambell/src/features/owner/prsentation/owner_home_screen.dart';
import 'package:magambell/src/features/store/presentation/store_screen.dart';
import 'package:magambell/src/features/user/providers/user.provider.dart';
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
      handleNotificationNavigation(initialMessage, delayed: true);
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

  /// 알림 클릭 처리 (포그라운드 로컬 알림)
  static void onNotificationTapped(NotificationResponse response) {
    talker.info('[FCM] Notification tapped: ${response.payload}');
    final payload = response.payload;
    if (payload == null) return;
    try {
      final data = jsonDecode(payload) as Map<String, dynamic>;
      _navigateFromData(data);
    } catch (e) {
      talker.error('[FCM] Failed to parse notification payload', e);
    }
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
  static void handleNotificationNavigation(RemoteMessage message, {bool delayed = false}) {
    talker.debug('[FCM] Navigation data: ${message.data}');
    if (delayed) {
      Future.delayed(const Duration(milliseconds: 500), () => _navigateFromData(message.data));
    } else {
      _navigateFromData(message.data);
    }
  }

  /// data에 따라 화면 이동
  /// - type == 'STORE_OPEN' && storeId 있으면 → 매장 상세
  /// - type == 'ORDER' 이면 → 사장님: OwnerHome, 일반: 주문내역 탭
  /// - 그 외 → 아무것도 안 함 (앱만 오픈)
  static void _navigateFromData(Map<String, dynamic> data) {
    final context = GlobalVariable.navigatorKey.currentContext;
    if (context == null || !context.mounted) return;

    final storeId = data['storeId'] as String?;
    final type = data['type'] as String?;

    if (type == 'STORE_OPEN' && storeId != null) {
      GoRouter.of(context).go(StoreRoute(id: storeId).location);
      return;
    }

    if (type == 'ORDER') {
      final container = ProviderScope.containerOf(context);
      final user = container.read(userStateProvider).asData?.value;
      if (user?.userRole == UserRole.owner) {
        GoRouter.of(context).go(OwnerHomeRoute().location);
      } else {
        GoRouter.of(context).go(MainRoute().location);
        container.read(navigatorControllerProvider.notifier).changeTabIndex(1);
      }
    }
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
      payload: jsonEncode(message.data),
    );

    talker.debug('[FCM] Local notification shown');
  }

  /// FCM 토큰 가져오기
  Future<String?> getToken() async {
    try {
      if (Platform.isIOS) {
        String? apnsToken;
        for (int i = 0; i < 10; i++) {
          apnsToken = await FirebaseMessaging.instance.getAPNSToken();
          if (apnsToken != null) break;
          await Future.delayed(const Duration(milliseconds: 500));
        }
        if (apnsToken == null) {
          talker.error('[FCM] APNS token not available');
          return null;
        }
        talker.debug('[FCM] APNS token ready');
        // Firebase 내부 APNS 상태 동기화 대기 (race condition 방지)
        await Future.delayed(const Duration(milliseconds: 500));
      }
      final token = await FirebaseMessaging.instance.getToken();
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

  /// 사용자 역할에 따라 FCM 토픽 구독
  /// - 역할: "CUSTOMER", "OWNER", "ADMIN"
  static Future<void> subscribeToRoleTopic(String userRole) async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic('all');
      await FirebaseMessaging.instance.subscribeToTopic(userRole.toLowerCase());
      talker.info('[FCM] Subscribed to topics: all, ${userRole.toLowerCase()}');
    } catch (e, stackTrace) {
      talker.error('[FCM] Failed to subscribe to topic', e, stackTrace);
    }
  }

  /// FCM 토픽 구독 해제 (로그아웃 시 호출)
  static Future<void> unsubscribeFromAllTopics() async {
    try {
      await FirebaseMessaging.instance.unsubscribeFromTopic('all');
      for (final role in ['customer', 'owner', 'admin']) {
        await FirebaseMessaging.instance.unsubscribeFromTopic(role);
      }
      talker.info('[FCM] Unsubscribed from all topics');
    } catch (e, stackTrace) {
      talker.error('[FCM] Failed to unsubscribe from topics', e, stackTrace);
    }
  }

  /// 로그인 시 FCM 토큰을 서버에 등록
  Future<void> refreshAndRegisterToken() async {
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
