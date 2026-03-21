import 'package:firebase_analytics/firebase_analytics.dart';

/// Firebase Analytics 싱글톤 서비스
class AnalyticsService {
  AnalyticsService._internal();
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // ─── 전체 유저 공통 ────────────────────────────────────────────────

  /// 앱 실행 시 / userType: 'consumer' | 'merchant' | 'admin'
  Future<void> logAppOpened({required String userType}) async {
    await _analytics.logEvent(
      name: 'app_opened',
      parameters: {'user_type': userType},
    );
  }

  /// 앱 종료 시
  Future<void> logAppClosed({required String userType}) async {
    await _analytics.logEvent(
      name: 'app_closed',
      parameters: {'user_type': userType},
    );
  }

  // ─── 일반 유저 (Consumer) ──────────────────────────────────────────

  /// 바이트백 상세페이지 진입 시
  Future<void> logBitebagView({
    required String storeId,
    required String bagId,
    int? originalPrice,
  }) async {
    final params = <String, Object>{
      'store_id': storeId,
      'bag_id': bagId,
    };
    if (originalPrice != null) {
      params['original_price'] = originalPrice;
    }
    await _analytics.logEvent(name: 'bitebag_view', parameters: params);
  }

  /// 구매하기 버튼 눌렀을 때
  Future<void> logCheckoutStarted({
    required String storeId,
    required int quantity,
  }) async {
    await _analytics.logEvent(
      name: 'checkout_started',
      parameters: {'store_id': storeId, 'quantity': quantity},
    );
  }

  /// 결제 완료 직후
  Future<void> logPurchaseCompleted({
    required String storeId,
    required int amount,
    required int quantity,
  }) async {
    await _analytics.logEvent(
      name: 'purchase_completed',
      parameters: {
        'store_id': storeId,
        'amount': amount,
        'quantity': quantity,
      },
    );
  }

  /// 결제 승인 거절 시
  Future<void> logPurchaseFailed({
    required int amount,
    required String reason,
  }) async {
    await _analytics.logEvent(
      name: 'purchase_failed',
      parameters: {'amount': amount, 'reason': reason},
    );
  }

  // ─── 사장님 (Merchant) ─────────────────────────────────────────────

  /// 바이트백 등록 완료 시
  Future<void> logBitebagRegisterCompleted({required String storeId}) async {
    await _analytics.logEvent(
      name: 'bitebag_register_completed',
      parameters: {'store_id': storeId},
    );
  }

  /// 판매중 ON/OFF 시
  Future<void> logStatusChanged({
    required String storeId,
    required bool isActive,
  }) async {
    await _analytics.logEvent(
      name: 'status_changed',
      parameters: {'store_id': storeId, 'is_active': isActive},
    );
  }

  /// 사장님이 주문 수락 버튼 눌렀을 때
  Future<void> logSaleCompleted({
    required String storeId,
    required int amount,
  }) async {
    await _analytics.logEvent(
      name: 'sale_completed',
      parameters: {'store_id': storeId, 'amount': amount},
    );
  }
}
