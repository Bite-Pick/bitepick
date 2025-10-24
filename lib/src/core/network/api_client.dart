import 'dart:io';

import 'package:dio/dio.dart';
import 'package:magambell/src/core/config/environment.dart';
import 'package:magambell/src/core/network/app_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// API 클라이언트 싱글톤
///
/// Environment의 baseApiUrl을 사용하여 Dio 인스턴스를 생성합니다.
/// - 개발/운영 환경에 따라 자동으로 Base URL이 설정됩니다.
/// - 인증, 에러 처리, 로깅 등의 인터셉터가 적용됩니다.
class ApiClient {
  factory ApiClient() => _instance;
  static final _instance = ApiClient._private();

  late final Dio _dio;
  Dio get dio => _dio;

  ApiClient._private() {
    _dio = _initDio();
  }

  Dio _initDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Environment.baseApiUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        contentType: ContentType.json.mimeType,
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    // 인터셉터 추가
    dio.interceptors.addAll([
      AppInterceptor(), // 인증, 에러 처리
      if (!Environment.instance.isReleaseMode)
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
    ]);

    return dio;
  }

  /// 커스텀 Dio 인스턴스 생성 (특별한 설정이 필요한 경우)
  Dio createCustomDio({
    String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Map<String, dynamic>? headers,
  }) {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl ?? Environment.baseApiUrl,
        connectTimeout: connectTimeout ?? const Duration(seconds: 60),
        receiveTimeout: receiveTimeout ?? const Duration(seconds: 60),
        contentType: ContentType.json.mimeType,
        headers: {
          'Accept': 'application/json',
          ...?headers,
        },
      ),
    );
  }
}
