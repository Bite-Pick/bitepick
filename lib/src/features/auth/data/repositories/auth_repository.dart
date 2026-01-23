import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/core/network/api_exception.dart';
import 'package:magambell/src/core/network/json_utils.dart';
import 'package:magambell/src/features/notification/domain/push_notification.dart';
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
      final errorCode = res.data?['code'];
      final errorMessage = res.data?['message'] ?? '인증에 실패했습니다.';

      errorCode == "DUPLICATE_NICKNAME"
          ? throw DuplicateNicknameException()
          : throw AuthenticationException(errorMessage, errorCode: errorCode);
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

    // 로그인 성공 후 FCM 토큰을 서버에 등록
    ref.read(pushNotificationProvider).registerTokenToServer().catchError((e) {
      talker.error('[AUTH] Failed to register FCM token after login', e);
    });

    return AuthTokens(accessToken: accessToken, refreshToken: refresh);
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

  Future<bool> checkDuplicateNickname({required String nickName}) async {
    final res = await _dio.post(
      '/v1/verify/nickname/register',
      data: {"nickName": nickName},
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
