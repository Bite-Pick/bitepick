import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/core/network/json_utils.dart';
import 'package:magambell/src/features/auth/domain/entities/auth_provider_type.dart';
import 'package:magambell/src/features/auth/domain/entities/auth_tokens.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  final Ref ref;
  late final Dio _dio;

  AuthRepository(this.ref) {
    _dio = ref.read(apiClientProvider);
  }

  /// 소셜 로그인/회원가입
  /// - 기존 회원: name, nickName, phoneNumber, userRole을 비워서 호출
  /// - 신규 회원: 모든 파라미터를 채워서 호출
  Future<AuthTokens?> authenticateWithSocial({
    required AuthProviderType providerType,
    required String authCode,
    String? name,
    String? nickName,
    String? phoneNumber,
    String? userRole, // "CUSTOMER" or "OWNER"
  }) async {
    try {
      // null 또는 빈 값 제거
      final requestData = JsonUtils.removeEmpty({
        "providerType": providerType.value,
        "authCode": authCode,
        "name": name,
        "nickName": nickName,
        "phoneNumber": phoneNumber,
        "userRole": userRole,
      });

      final res = await _dio.post(
        '/v1/auth/oauth/login',
        data: requestData,
      );

      if (res.statusCode != 200) {
        print('Authentication failed: ${res.statusCode}');
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

      print(
        'Authentication successful - Access Token: ${accessToken.substring(0, 10)}...',
      );

      return AuthTokens(accessToken: accessToken, refreshToken: refresh);
    } catch (e, stackTrace) {
      print('Authentication error: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }

}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref);
}
