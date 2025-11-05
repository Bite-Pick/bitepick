import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_naver_login/interface/types/naver_account_result.dart';
import 'package:flutter_naver_login/interface/types/naver_login_result.dart';
import 'package:flutter_naver_login/interface/types/naver_login_status.dart';
import 'package:flutter_naver_login/interface/types/naver_token.dart';
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
}
