import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_naver_login/interface/types/naver_account_result.dart';
import 'package:flutter_naver_login/interface/types/naver_login_result.dart';
import 'package:flutter_naver_login/interface/types/naver_login_status.dart';
import 'package:flutter_naver_login/interface/types/naver_token.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:magambell/src/features/auth/domain/entities/auth_provider_type.dart';
import 'package:magambell/src/features/auth/domain/entities/social_auth_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'social_auth_repository.g.dart';

@riverpod
SocialAuthRepository socialAuthRepository(SocialAuthRepositoryRef ref) {
  return SocialAuthRepository();
}

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
        providerType: AuthProviderType.naver,
        authCode: token.accessToken, // Access Token을 authCode로 전달
        email: account.email ?? '',
        name: account.nickname ?? account.name ?? '',
      );
    } catch (e) {
      print('Naver login error: $e');
      return null;
    }
  }

  /// 네이버 로그아웃
  Future<void> logoutNaver() async {
    try {
      await FlutterNaverLogin.logOut();
    } catch (e) {
      print('Naver logout error: $e');
    }
  }

  /// 카카오 로그인
  Future<SocialAuthResult?> signInWithKakao() async {
    try {
      // 1. 카카오톡 설치 여부 확인 후 로그인
      OAuthToken token;
      if (await isKakaoTalkInstalled()) {
        // 카카오톡으로 로그인
        token = await UserApi.instance.loginWithKakaoTalk();
      } else {
        // 카카오 계정으로 로그인
        token = await UserApi.instance.loginWithKakaoAccount();
      }

      print('Kakao login success: ${token.accessToken.substring(0, 10)}...');

      // 2. 프로필 정보 가져오기
      final User user = await UserApi.instance.me();

      if (user.kakaoAccount?.email == null) {
        print('Kakao email is null');
        return null;
      }

      // 3. 결과 반환
      return SocialAuthResult(
        providerType: AuthProviderType.kakao,
        authCode: token.accessToken, // Access Token을 authCode로 전달
        email: user.kakaoAccount?.email ?? '',
        name: user.kakaoAccount?.profile?.nickname ?? '',
      );
    } catch (e, stackTrace) {
      print('Kakao login error: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }

  /// 카카오 로그아웃
  Future<void> logoutKakao() async {
    try {
      await UserApi.instance.logout();
    } catch (e) {
      print('Kakao logout error: $e');
    }
  }
}
