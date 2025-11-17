import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/core/network/api_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_repository.g.dart';

class NotificationRepository {
  final Ref ref;
  late final Dio _dio;

  NotificationRepository(this.ref) {
    _dio = ref.read(apiClientProvider);
  }

  /// 매장 알림 등록
  ///
  /// 성공하면 true
  /// - DUPLICATE_NOTIFICATION_STORE 코드면 [DuplicateNotificationStoreException] throw
  /// - 그 외 에러는 그대로 rethrow(DioException 포함)
  Future<bool> registerStoreNotification({
    required String storeId,
    required String fcmToken,
  }) async {
    // baseUrl이 이미 `/api/v1` 라고 가정하고 path만 적음
    // (FavoriteRepository도 `/v1/favorite` 쓰니까, 여기도 `/v1/notification/...` 맞춰도 됨)
    final res = await _dio.post(
      '/v1/notification/store',
      data: {'storeId': storeId, 'fcmToken': fcmToken},
    );

    // 서버 공통 응답 포맷이 { status, data, code, message } 라고 가정
    if (res.data['status'] != 'OK') return false;

    // status != OK 인데 code가 내려오는 경우
    final code = res.data['code'] as String?;
    final message = res.data['message'] as String? ?? '알림 등록 실패';

    if (code == 'DUPLICATE_NOTIFICATION_STORE') {
      throw DuplicateNotificationStoreException(
        '이미 알림을 신청했어요! 오픈 시간이 되면 알려드릴게요~☺️',
      );
    }

    return true;
  }

  /// 알림 구독 상태 조회
  ///
  /// - 200 + data.subscribed: bool → 그대로 리턴
  /// - 404 (NOT_FOUND_NOTIFICATION_STORE) → false
  /// - 그 외 에러 → throw
  Future<bool> getStoreNotificationSubscribed(String storeId) async {
    try {
      final res = await _dio.get('/v1/notification/store/$storeId');

      if (res.statusCode == 200) {
        final data = res.data['data'] as Map<String, dynamic>?;
        // 스펙: { "data": { "subscribed": true } }
        final subscribed = data?['subscribed'] as bool?;
        return subscribed ?? false;
      }

      // 여기까지 왔는데 404는 아닌 경우 → 일반 에러 처리
      throw Exception('알림 상태 확인 실패');
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        // React Native 예제처럼, NOT_FOUND_NOTIFICATION_STORE → 알림 신청 기록 없음
        return false;
      }

      // 그 외 에러는 그대로 던짐
      rethrow;
    }
  }

  Future<bool> deleteNotificationToken(String storeId) async {
    final res = await _dio.delete('/v1/notification/store/$storeId');
    final data = res.data['data'] as String?;
    if (res.data['status'] != 'OK' || data == null) return false;
    return true;
  }

  Future<bool> saveNotificationToken(String fcmToken) async {
    final res = await _dio.post(
      '/v1/notification',
      data: {'fcmToken': fcmToken},
    );
    final data = res.data['data'] as String?;
    if (res.data['status'] != 'OK' || data == null) return false;
    return true;
  }

  Future<bool> testNotification() async {
    final res = await _dio.get('/v1/notification');
    final data = res.data['data'] as String?;
    if (res.data['status'] != 'OK' || data == null) return false;
    return true;
  }
}

/// Repository Provider
@riverpod
NotificationRepository notificationRepository(Ref ref) {
  return NotificationRepository(ref);
}

/// 알림 상태 조회용 Provider
///
/// 사용 예:
/// ```dart
/// final subscribedAsync = ref.watch(storeNotificationSubscribedProvider(storeId: storeId));
/// ```
@riverpod
Future<bool> storeNotificationSubscribed(
  Ref ref, {
  required String storeId,
}) async {
  final repo = ref.read(notificationRepositoryProvider);
  return repo.getStoreNotificationSubscribed(storeId);
}

/// 알림 등록 호출은 보통 UI 로직 or Notifier에서
/// `ref.read(notificationRepositoryProvider).registerStoreNotification(...)`
/// 이런 식으로 직접 부르면 될 듯
