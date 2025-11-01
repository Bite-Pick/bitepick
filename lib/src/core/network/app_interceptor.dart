import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// 앱 공통 인터셉터
///
/// 주요 기능:
/// - Request: User-Agent, Authorization, Cookie 헤더 주입
/// - Response: Cookie 관리
/// - Error: 에러 코드별 처리 (400: 에러 메시지, 401: 토큰 갱신, 502: 점검)
class AppInterceptor extends Interceptor {
  static String? _sessionCookie;
  static String? _authToken;
  static String? _cachedUserAgent;

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
    // if (token != null) {
    // options.headers['Authorization'] = 'Bearer $token';
    options.headers['Authorization'] =
        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJVc2VyUm9sZSI6IkNVU1RPTUVSIiwic3ViIjoiNzQyMTQ5NjM5NDc4MjgxNjkyIiwiaWF0IjoxNzYyMDA0ODEyLCJleHAiOjE3NjIwMDg0MTJ9.Krvs6AC_CtgGOluidxjCh4MEV8YdRWrQKNPUzA6t5lA ';
    // }

    // 세션 쿠키 주입
    if (_sessionCookie != null) {
      options.headers['Cookie'] = _sessionCookie;
    }

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
  // 🔄 토큰 갱신 후 재요청
  // ========================================

  Future<void> _refreshTokenAndRetry(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      final newToken = await _refreshAuthToken();

      if (newToken == null) {
        _navigateToLogin();
        return handler.reject(err);
      }

      // 토큰 갱신 성공: 원래 요청 재시도
      final dio = Dio(
        BaseOptions(
          baseUrl: err.requestOptions.baseUrl,
          connectTimeout: err.requestOptions.connectTimeout,
          receiveTimeout: err.requestOptions.receiveTimeout,
        ),
      );

      final response = await dio.request(
        err.requestOptions.path,
        data: err.requestOptions.data,
        queryParameters: err.requestOptions.queryParameters,
        options: Options(
          method: err.requestOptions.method,
          headers: {
            ...err.requestOptions.headers,
            'Authorization': 'Bearer $newToken',
          },
        ),
      );

      handler.resolve(response);
    } catch (e) {
      _navigateToLogin();
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
  ///
  /// TODO: SharedPreferences, SecureStorage 등에서 토큰을 가져오도록 구현
  Future<String?> _getAuthToken() async {
    // 예시: SharedPreferences에서 토큰 가져오기
    // final prefs = await SharedPreferences.getInstance();
    // return prefs.getString('auth_token');

    return _authToken; // 임시로 메모리에서 가져옴
  }

  /// 인증 토큰 갱신
  ///
  /// TODO: 실제 토큰 갱신 API 호출 구현
  Future<String?> _refreshAuthToken() async {
    // 예시: Refresh Token으로 새 Access Token 발급
    // final refreshToken = await _getRefreshToken();
    // final dio = Dio();
    // final response = await dio.post('/auth/token/reissue', data: {
    //   'refresh_token': refreshToken,
    // });
    // final newToken = response.data['access_token'];
    // await _saveAuthToken(newToken);
    // return newToken;

    debugPrint('⚠️ Token refresh not implemented');
    return null;
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
  // 🔑 토큰 관리 정적 메서드
  // ========================================

  /// 토큰 설정 (로그인 후 호출)
  static void setAuthToken(String token) {
    _authToken = token;
  }

  /// 토큰 삭제 (로그아웃 후 호출)
  static void clearAuthToken() {
    _authToken = null;
    _sessionCookie = null;
  }
}
