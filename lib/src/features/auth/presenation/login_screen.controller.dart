import 'package:magambell/src/features/auth/data/repositories/social_auth_repository.dart';
import 'package:magambell/src/features/auth/domain/entities/social_auth_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_screen.controller.g.dart';

@riverpod
class LoginScreenController extends _$LoginScreenController {
  @override
  FutureOr<void> build() {}

  /// 네이버 로그인
  Future<bool> signInWithNaver() async {
    return _performSocialLogin(
      onSocialLogin: () =>
          ref.read(socialAuthRepositoryProvider).signInWithNaver(),
      providerName: '네이버',
      onSocialLogout: () =>
          ref.read(socialAuthRepositoryProvider).logoutNaver(),
    );
  }

  /// 카카오 로그인
  Future<bool> signInWithKakao() async {
    return _performSocialLogin(
      onSocialLogin: () =>
          ref.read(socialAuthRepositoryProvider).signInWithKakao(),
      providerName: '카카오',
      onSocialLogout: () =>
          ref.read(socialAuthRepositoryProvider).logoutKakao(),
    );
  }

  /// 애플 로그인
  Future<bool> signInWithApple() async {
    return _performSocialLogin(
      onSocialLogin: () =>
          ref.read(socialAuthRepositoryProvider).signInWithApple(),
      providerName: '애플',
    );
  }

  /// 소셜 로그인 공통 로직
  Future<bool> _performSocialLogin({
    required Future<SocialAuthResult?> Function() onSocialLogin,
    required String providerName,
    Future<void> Function()? onSocialLogout,
  }) async {
    state = const AsyncValue.loading();

    try {
      // 1. 소셜 SDK로 로그인 실행 및 프로필 가져오기
      final authResult = await onSocialLogin();

      if (authResult == null) {
        state = AsyncValue.error(
          '$providerName 로그인에 실패했습니다.',
          StackTrace.current,
        );
        return false;
      }

      // 2. 백엔드로 기존 회원 검증
      final isExistingUser = await _verifyUser(authResult);

      if (!isExistingUser) {
        // 신규 회원인 경우: 회원가입 화면으로 이동
        state = AsyncValue.data(authResult);
        return false;
      }

      // 기존 회원인 경우: 로그인 처리
      final loginSuccess = await _loginUser(authResult);
      if (loginSuccess) {
        state = const AsyncValue.data(null);
        return true;
      } else {
        // 로그인 실패 시 로그아웃
        if (onSocialLogout != null) {
          await onSocialLogout();
        }
        state = AsyncValue.error('로그인에 실패했습니다.', StackTrace.current);
        return false;
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error('$providerName 로그인 중 오류가 발생했습니다.', stackTrace);
      return false;
    }
  }

  /// 백엔드로 기존 회원 검증
  Future<bool> _verifyUser(SocialAuthResult authResult) async {
    // TODO : vertify duplicate
    return true;
  }

  /// 백엔드로 로그인 요청
  Future<bool> _loginUser(SocialAuthResult authResult) async {
    // TODO
    return true;
  }

  /// 최근 로그인 Provider 저장
  // TODO: 적용 시점 고민 필요(로그인 완료 vs 버튼만 눌러도)
  Future<void> _saveLastLoginProvider(String provider) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastLoginProvider', provider);
  }
}
