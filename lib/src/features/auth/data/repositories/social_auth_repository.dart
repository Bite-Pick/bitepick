import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_naver_login/interface/types/naver_account_result.dart';
import 'package:flutter_naver_login/interface/types/naver_login_result.dart';
import 'package:flutter_naver_login/interface/types/naver_login_status.dart';
import 'package:flutter_naver_login/interface/types/naver_token.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/auth/domain/entities/auth_provider_type.dart';
import 'package:magambell/src/features/auth/domain/entities/social_auth_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'social_auth_repository.g.dart';

class SocialAuthRepository {
  /// 네이버 로그인
  Future<SocialAuthResult?> signInWithNaver() async {
    try {
      // 1. 네이버 SDK로 로그인 실행
      final NaverLoginResult result = await FlutterNaverLogin.logIn();

      // 로그인 실패 처리
      if (result.status != NaverLoginStatus.loggedIn) {
        return null;
      }

      // 2. Access Token 가져오기
      final NaverToken token = await FlutterNaverLogin.getCurrentAccessToken();

      // 3. 프로필 정보 가져오기
      final NaverAccountResult account =
          await FlutterNaverLogin.getCurrentAccount();

      if (account.id == null || account.email == null) {
        return null;
      }

      // 4. 결과 반환
      return SocialAuthResult(
        providerType: AuthProviderType.NAVER,
        authCode: token.accessToken, // Access Token을 authCode로 전달
        email: account.email ?? '',
        name: account.nickname ?? account.name ?? '',
      );
    } catch (e) {
      talker.debug('Naver login error: $e');
      return null;
    }
  }

  /// 네이버 로그아웃
  Future<void> logoutNaver() async {
    try {
      await FlutterNaverLogin.logOut();
    } catch (e) {
      talker.debug('Naver logout error: $e');
    }
  }

  /// 카카오 로그인
  Future<SocialAuthResult?> signInWithKakao() async {
    try {
      // 1. 카카오톡 설치 여부 확인 후 로그인
      OAuthToken token;
      token = await isKakaoTalkInstalled()
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      talker.debug(
        'Kakao login success: ${token.accessToken.substring(0, 10)}...',
      );

      // 2. 프로필 정보 가져오기
      final User user = await UserApi.instance.me();

      // if (user.kakaoAccount?.email == null) {
      //   talker.debug('Kakao email is null');
      //   return null;
      // }

      // 3. 결과 반환
      return SocialAuthResult(
        providerType: AuthProviderType.KAKAO,
        authCode: token.accessToken,
        email: user.kakaoAccount?.email ?? '',
        name: user.kakaoAccount?.profile?.nickname ?? '',
      );
    } catch (e, stackTrace) {
      talker.debug('Kakao login error: $e');
      talker.debug('Stack trace: $stackTrace');
      return null;
    }
  }

  /// 카카오 로그아웃
  Future<void> logoutKakao() async {
    try {
      await UserApi.instance.logout();
    } catch (e) {
      talker.debug('Kakao logout error: $e');
    }
  }

  /// 애플 로그인
  Future<SocialAuthResult?> signInWithApple() async {
    try {
      // 1. 애플 로그인 요청
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      talker.debug(
        'Apple login success: ${credential.identityToken?.substring(0, 10)}...',
      );

      if (credential.identityToken == null) {
        talker.debug('Apple identity token is null');
        return null;
      }

      // 2. 이메일 추출 (최초 로그인시에만 제공됨)
      // 이후 로그인에서는 email이 null이므로 userIdentifier를 사용
      final email =
          credential.email ??
          '${credential.userIdentifier}@privaterelay.appleid.com';
      final name = credential.givenName ?? credential.familyName ?? '';

      // 3. 결과 반환
      return SocialAuthResult(
        providerType: AuthProviderType.APPLE,
        authCode: credential.identityToken!,
        email: email,
        name: name,
      );
    } catch (e, stackTrace) {
      talker.debug('Apple login error: $e');
      talker.debug('Stack trace: $stackTrace');
      return null;
    }
  }
}

@riverpod
SocialAuthRepository socialAuthRepository(Ref ref) {
  return SocialAuthRepository();
}
