import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/core/network/json_utils.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
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
        "providerType": providerType.name,
        "authCode": authCode,
        "name": name,
        "nickName": nickName,
        "phoneNumber": phoneNumber,
        "userRole": userRole,
      });

      final res = await _dio.post('/v1/auth/oauth/login', data: requestData);

      if (res.statusCode != 200) {
        final errorName = res.data?['name'];
        final errorMessage = res.data?['message'] ?? '인증에 실패했습니다.';

        if (errorName == 'DUPLICATE_NICKNAME') {
          throw DuplicateNicknameException();
        } else {
          throw AuthenticationException(errorMessage, errorCode: errorName);
        }
      }

      // Response Header에서 JWT 토큰 추출
      final authorization = res.headers.value('authorization');
      final refreshToken = res.headers.value('refreshtoken');

      if (authorization == null || refreshToken == null) {
        talker.debug('Tokens not found in response headers');
        return null;
      }

      // "Bearer " 및 "RefreshToken " 접두사 제거
      final accessToken = authorization.replaceFirst('Bearer ', '');
      final refresh = refreshToken.replaceFirst('RefreshToken ', '');

      talker.debug(
        'Authentication successful - Access Token: ${accessToken.substring(0, 10)}...',
      );

      return AuthTokens(accessToken: accessToken, refreshToken: refresh);
    } catch (e, stackTrace) {
      talker.debug('Authentication error: $e');
      talker.debug('Stack trace: $stackTrace');
      return null;
    }
  }

  Future<bool> withdraw({
    required AuthProviderType providerType,
    required String authCode,
  }) async {
    final res = await _dio.delete(
      '/v1/auth/withdraw',
      data: {"providerType": providerType.name, "authCode": authCode},
    );
    final data = res.data['data'] as String?;
    if (res.data['status'] != 'OK' || data == null) return false;
    return true;
  }
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref);
}

// TODO: 추후 Exception만 모은 파일 분리
/// 중복 닉네임 예외
class DuplicateNicknameException implements Exception {
  final String message;
  DuplicateNicknameException([this.message = '이미 사용 중인 닉네임입니다.']);

  @override
  String toString() => message;
}

/// 인증 실패 예외
class AuthenticationException implements Exception {
  final String message;
  final String? errorCode;

  AuthenticationException(this.message, {this.errorCode});

  @override
  String toString() => message;
}
