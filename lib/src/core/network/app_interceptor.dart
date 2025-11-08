import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/features/auth/providers/auth_token_manager.dart';
import 'package:magambell/src/features/auth/domain/entities/auth_tokens.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// 앱 공통 인터셉터
///
/// 주요 기능:
/// - Request: User-Agent, Authorization, Cookie 헤더 주입
/// - Response: Cookie 관리
/// - Error: 에러 코드별 처리 (400: 에러 메시지, 401: 토큰 갱신, 502: 점검)
class AppInterceptor extends Interceptor {
  final Ref ref;

  AppInterceptor(this.ref);

  static String? _sessionCookie;
  static String? _cachedUserAgent;

  // 🔄 토큰 갱신 중 여부 플래그
  static bool _isRefreshing = false;

  // 📦 토큰 갱신 대기 중인 요청들을 저장할 큐
  static final List<_RequestQueueItem> _requestQueue = [];

  // ========================================
  // 1️⃣ Request 전처리
  // ========================================

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // User-Agent 주입
    options.headers['User-Agent'] = await _getUserAgent();

    // 인증 토큰 주입
    final token = await _getAuthToken();
    if (token != null) options.headers['Authorization'] = 'Bearer $token';
    // 세션 쿠키 주입
    // if (_sessionCookie != null) options.headers['Cookie'] = _sessionCookie;

    return super.onRequest(options, handler);
  }

  // ========================================
  // 2️⃣ Response 후처리
  // ========================================

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 쿠키 저장
    final setCookie = response.headers['set-cookie']?.firstOrNull;
    if (setCookie != null) {
      _sessionCookie = setCookie.split(';').first;
    }

    return super.onResponse(response, handler);
  }

  // ========================================
  // 3️⃣ Error 처리
  // ========================================

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;
    final data = err.response?.data;

    // 502: 서비스 점검
    if (statusCode == 502 || err.message?.contains('502') == true) {
      _navigateToMaintenance();
      return handler.reject(err);
    }

    // 응답 데이터가 Map인 경우 커스텀 에러 코드 처리
    if (data is Map) {
      final code = data['code'] ?? statusCode ?? -1;
      final message = data['message'] as String? ?? '알 수 없는 오류가 발생했습니다.';

      switch (code) {
        case 400: // Bad Request
          _showErrorMessage(message);
          return handler.resolve(
            Response(
              requestOptions: err.requestOptions,
              data: data,
              statusCode: statusCode,
            ),
          );

        case 401: // Unauthorized - 토큰 갱신 시도
          await _refreshTokenAndRetry(err, handler);
          return;

        default:
          // 기본 에러 응답 반환
          return handler.resolve(
            Response(
              requestOptions: err.requestOptions,
              data: data,
              statusCode: statusCode ?? -1,
            ),
          );
      }
    }

    // 데이터가 없거나 Map이 아닌 경우 그대로 reject
    return handler.reject(err);
  }

  // ========================================
  // 🔄 토큰 갱신 후 재요청 (Queue Lock 패턴)
  // ========================================

  Future<void> _refreshTokenAndRetry(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    debugPrint('🔒 Request failed with 401, checking refresh status...');

    // 1. 이미 토큰 갱신 중이면 큐에 추가하고 대기
    if (_isRefreshing) {
      debugPrint('⏳ Token refresh in progress, adding request to queue');
      _requestQueue.add(_RequestQueueItem(err, handler));
      return;
    }

    // 2. 첫 번째 요청이 토큰 갱신 시작
    _isRefreshing = true;
    debugPrint('🔄 Starting token refresh...');

    try {
      // 3. 새 Access Token 발급
      final newAccessToken = await _refreshAuthToken();

      if (newAccessToken == null) {
        debugPrint('❌ Token refresh failed, navigate to login');
        _isRefreshing = false;

        // 큐에 있는 모든 요청 실패 처리
        for (final item in _requestQueue) {
          item.handler.reject(item.error);
        }
        _requestQueue.clear();

        _navigateToLogin();
        return handler.reject(err);
      }

      debugPrint('✅ Token refreshed successfully');

      // 4. 현재 요청 재시도
      await _retryRequest(err, handler, newAccessToken);

      // 5. 큐에 있는 모든 요청들도 재시도
      debugPrint('📦 Retrying ${_requestQueue.length} queued requests');
      for (final item in _requestQueue) {
        await _retryRequest(item.error, item.handler, newAccessToken);
      }
      _requestQueue.clear();

      _isRefreshing = false;
      debugPrint('✅ All requests retried successfully');
    } catch (e, stackTrace) {
      debugPrint('❌ Token refresh and retry failed: $e');
      debugPrint('Stack trace: $stackTrace');

      _isRefreshing = false;

      // 큐에 있는 모든 요청 실패 처리
      for (final item in _requestQueue) {
        item.handler.reject(item.error);
      }
      _requestQueue.clear();

      _navigateToLogin();
      return handler.reject(err);
    }
  }

  /// 실패한 요청을 새 토큰으로 재시도
  Future<void> _retryRequest(
    DioException err,
    ErrorInterceptorHandler handler,
    String newAccessToken,
  ) async {
    try {
      // 1. 실패했던 요청의 헤더에 새 토큰 주입
      err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

      // 2. 실패했던 요청을 새 토큰으로 재시도
      final retryDio = Dio(
        BaseOptions(
          baseUrl: err.requestOptions.baseUrl,
          connectTimeout: err.requestOptions.connectTimeout,
          receiveTimeout: err.requestOptions.receiveTimeout,
        ),
      );

      final response = await retryDio.request(
        err.requestOptions.path,
        data: err.requestOptions.data,
        queryParameters: err.requestOptions.queryParameters,
        options: Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers,
        ),
      );

      // 3. 성공한 응답 반환
      handler.resolve(response);
    } catch (e) {
      debugPrint('❌ Retry request failed: $e');
      handler.reject(err);
    }
  }

  // ========================================
  // 📱 헬퍼 메서드들
  // ========================================

  /// User-Agent 생성 (앱 버전, OS, 디바이스 정보)
  Future<String> _getUserAgent() async {
    if (_cachedUserAgent != null) return _cachedUserAgent!;

    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final deviceInfo = DeviceInfoPlugin();

      String osInfo;
      String deviceModel;

      if (Platform.isAndroid) {
        final info = await deviceInfo.androidInfo;
        osInfo = 'Android ${info.version.release}';
        deviceModel = info.model;
      } else if (Platform.isIOS) {
        final info = await deviceInfo.iosInfo;
        osInfo = 'iOS ${info.systemVersion}';
        deviceModel = info.utsname.machine;
      } else {
        osInfo = Platform.operatingSystem;
        deviceModel = 'Unknown';
      }

      _cachedUserAgent =
          'MagamBell/${packageInfo.version} '
          '($osInfo; $deviceModel)';

      return _cachedUserAgent!;
    } catch (e) {
      debugPrint('Failed to get user agent: $e');
      return 'MagamBell/1.0.0';
    }
  }

  /// 인증 토큰 가져오기
  Future<String?> _getAuthToken() async {
    final tokenManager = ref.read(authTokenManagerProvider.notifier);
    return tokenManager.getAccessToken();
  }

  /// 인증 토큰 갱신
  ///
  /// 토큰 갱신 전용 Dio 인스턴스를 생성하여 요청
  /// - Refresh Token이 만료된 경우 로그인 화면으로 이동
  Future<String?> _refreshAuthToken() async {
    try {
      final tokenManager = ref.read(authTokenManagerProvider.notifier);
      final refreshToken = tokenManager.getRefreshToken();

      if (refreshToken == null) {
        debugPrint('⚠️ No refresh token available');
        return null;
      }

      debugPrint('🔄 Refreshing token...');

      // 토큰 갱신 전용 Dio 인스턴스 생성 (인터셉터 없음)
      final refreshDio = Dio(
        BaseOptions(
          baseUrl: ref.read(apiClientProvider).options.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          contentType: ContentType.json.mimeType,
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

      // Refresh Token 갱신 요청 중 에러 처리
      refreshDio.interceptors.add(
        InterceptorsWrapper(
          onError: (error, handler) async {
            final statusCode = error.response?.statusCode;
            final code = error.response?.data?['code'];

            debugPrint(
              '❌ Token refresh error: statusCode=$statusCode, code=$code',
            );

            // Refresh Token 만료 또는 인증 오류
            if (statusCode == 401 || code == 401) {
              debugPrint('🔐 Refresh token expired, navigate to login');
              _navigateToLogin();
            }

            return handler.next(error);
          },
        ),
      );

      // 토큰 갱신 API 요청
      final response = await refreshDio.post(
        '/v1/auth/token/reissue',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode != 200) {
        debugPrint('⚠️ Token refresh failed: ${response.statusCode}');
        return null;
      }

      // Response Header에서 JWT 토큰 추출
      final authorization = response.headers.value('authorization');
      final newRefreshToken = response.headers.value('refreshtoken');

      if (authorization == null || newRefreshToken == null) {
        debugPrint('⚠️ Tokens not found in response headers');
        return null;
      }

      // "Bearer " 및 "RefreshToken " 접두사 제거
      final accessToken = authorization.replaceFirst('Bearer ', '');
      final refresh = newRefreshToken.replaceFirst('RefreshToken ', '');

      // 새 토큰 저장
      final newTokens = AuthTokens(
        accessToken: accessToken,
        refreshToken: refresh,
      );
      await tokenManager.saveTokens(newTokens);

      debugPrint('✅ Token refreshed and saved');
      return accessToken;
    } catch (e, stackTrace) {
      debugPrint('⚠️ Token refresh failed: $e');
      debugPrint('Stack trace: $stackTrace');
      return null;
    }
  }

  /// 에러 메시지 표시
  ///
  /// TODO: Toast, SnackBar 등으로 메시지 표시 구현
  void _showErrorMessage(String message) {
    // 예시: Fluttertoast 사용
    // Fluttertoast.showToast(msg: message);

    debugPrint('❌ Error: $message');
  }

  /// 로그인 화면으로 이동
  ///
  /// TODO: 네비게이션 로직 구현
  void _navigateToLogin() {
    // 예시: GoRouter 사용
    // final context = navigatorKey.currentContext;
    // if (context != null) {
    //   context.go('/login');
    // }

    debugPrint('🔐 Navigate to login');
  }

  /// 점검 화면으로 이동
  ///
  /// TODO: 네비게이션 로직 구현
  void _navigateToMaintenance() {
    // 예시: GoRouter 사용
    // final context = navigatorKey.currentContext;
    // if (context != null) {
    //   context.go('/maintenance');
    // }

    debugPrint('🔧 Navigate to maintenance');
  }

  // ========================================
  // 🔑 세션 쿠키 관리 정적 메서드
  // ========================================

  /// 세션 쿠키 삭제 (로그아웃 후 호출)
  static void clearSessionCookie() {
    _sessionCookie = null;
  }
}

// ========================================
// 📦 요청 큐 아이템
// ========================================

/// 토큰 갱신 대기 중인 요청을 저장하는 클래스
class _RequestQueueItem {
  final DioException error;
  final ErrorInterceptorHandler handler;

  _RequestQueueItem(this.error, this.handler);
}
