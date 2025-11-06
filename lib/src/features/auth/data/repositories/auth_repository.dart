import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/features/auth/domain/entities/auth_provider_type.dart';
import 'package:magambell/src/features/auth/domain/entities/auth_tokens.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  final Dio _dio = ApiClient().dio;

  /// 소셜 로그인 (기존 회원)
  Future<AuthTokens?> loginWithSocial({
    required AuthProviderType providerType,
    required String authCode,
  }) async {
    try {
      final res = await _dio.post(
        '/v1/auth/oauth/login',
        data: {
          "providerType": providerType.value,
          "authCode": authCode,
          "name": "",
          "nickName": "",
          "phoneNumber": "",
        },
      );

      if (res.statusCode != 200) {
        print('Login failed: ${res.statusCode}');
        return null;
      }

      // Response Header에서 JWT 토큰 추출
      final authorization = res.headers.value('authorization');
      final refreshToken = res.headers.value('refreshtoken');

      if (authorization == null || refreshToken == null) {
        print('Tokens not found in response headers');
        return null;
      }

      // "Bearer " 및 "RefreshToken " 접두사 제거
      final accessToken = authorization.replaceFirst('Bearer ', '');
      final refresh = refreshToken.replaceFirst('RefreshToken ', '');

      print('Login successful - Access Token: ${accessToken.substring(0, 10)}...');

      return AuthTokens(
        accessToken: accessToken,
        refreshToken: refresh,
      );
    } catch (e, stackTrace) {
      print('Login error: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }

  /// 소셜 회원가입 (신규 회원)
  Future<AuthTokens?> signUpWithSocial({
    required AuthProviderType providerType,
    required String authCode,
    required String name,
    required String nickName,
    required String phoneNumber,
    required String userRole, // "CUSTOMER" or "OWNER"
  }) async {
    try {
      final res = await _dio.post(
        '/v1/auth/oauth/login',
        data: {
          "providerType": providerType.value,
          "authCode": authCode,
          "name": name,
          "nickName": nickName,
          "phoneNumber": phoneNumber,
          "userRole": userRole,
        },
      );

      if (res.statusCode != 200) {
        print('Sign up failed: ${res.statusCode}');
        return null;
      }

      // Response Header에서 JWT 토큰 추출
      final authorization = res.headers.value('authorization');
      final refreshToken = res.headers.value('refreshtoken');

      if (authorization == null || refreshToken == null) {
        print('Tokens not found in response headers');
        return null;
      }

      // "Bearer " 및 "RefreshToken " 접두사 제거
      final accessToken = authorization.replaceFirst('Bearer ', '');
      final refresh = refreshToken.replaceFirst('RefreshToken ', '');

      print('Sign up successful - Access Token: ${accessToken.substring(0, 10)}...');

      return AuthTokens(
        accessToken: accessToken,
        refreshToken: refresh,
      );
    } catch (e, stackTrace) {
      print('Sign up error: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }

  /// 토큰 저장 (SharedPreferences 또는 Secure Storage)
  Future<void> saveTokens(AuthTokens tokens) async {
    // TODO: Secure Storage에 토큰 저장
    // await secureStorage.write(key: 'access_token', value: tokens.accessToken);
    // await secureStorage.write(key: 'refresh_token', value: tokens.refreshToken);
    print('Tokens saved');
  }

  /// 로그아웃
  Future<void> logout() async {
    // TODO: 토큰 삭제
    // await secureStorage.delete(key: 'access_token');
    // await secureStorage.delete(key: 'refresh_token');
    print('Logged out');
  }
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository();
}
