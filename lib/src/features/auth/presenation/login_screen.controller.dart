import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/auth/providers/auth_token_manager.dart';
import 'package:magambell/src/features/auth/data/repositories/auth_repository.dart';
import 'package:magambell/src/features/auth/data/repositories/social_auth_repository.dart';
import 'package:magambell/src/features/auth/data/repositories/vertify_repository.dart';
import 'package:magambell/src/features/auth/domain/entities/social_auth_result.dart';
import 'package:magambell/src/features/user/providers/user.provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_screen.controller.g.dart';

@riverpod
class LoginScreenController extends _$LoginScreenController {
  @override
  FutureOr<SocialAuthResult?> build() async {
    return null;
  }

  /// 네이버 로그인
  Future<void> signInWithNaver() async {
    await _performSocialLogin(
      onSocialLogin: () =>
          ref.read(socialAuthRepositoryProvider).signInWithNaver(),
      providerName: '네이버',
      onSocialLogout: () =>
          ref.read(socialAuthRepositoryProvider).logoutNaver(),
    );
  }

  /// 카카오 로그인
  Future<void> signInWithKakao() async {
    await _performSocialLogin(
      onSocialLogin: () =>
          ref.read(socialAuthRepositoryProvider).signInWithKakao(),
      providerName: '카카오',
      onSocialLogout: () =>
          ref.read(socialAuthRepositoryProvider).logoutKakao(),
    );
  }

  /// 애플 로그인
  Future<void> signInWithApple() async {
    await _performSocialLogin(
      onSocialLogin: () =>
          ref.read(socialAuthRepositoryProvider).signInWithApple(),
      providerName: '애플',
    );
  }

  /// 소셜 로그인 공통 로직
  Future<void> _performSocialLogin({
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
        return;
      }

      // 2. 백엔드로 기존 회원 검증
      final isExistingUser = await ref
          .read(vertifyRepositoryProvider)
          .vertifySocial(authResult.providerType, authResult.authCode);

      if (!isExistingUser) {
        // 신규 회원인 경우: 회원가입 화면으로 이동 (authResult 반환)
        state = AsyncValue.data(authResult);
        return;
      }

      // 기존 회원인 경우: 로그인 처리
      final loginSuccess = await _loginUser(authResult);
      if (loginSuccess) {
        _saveLastLoginProvider(providerName);
        // 로그인 성공: null 반환 (메인 화면으로 이동)
        ref.invalidate(userStateProvider);
        state = const AsyncValue.data(null);
      } else {
        // 로그인 실패 시 로그아웃
        if (onSocialLogout != null) {
          await onSocialLogout();
        }
        state = AsyncValue.error('로그인에 실패했습니다.', StackTrace.current);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error('$providerName 로그인 중 오류가 발생했습니다.', stackTrace);
    }
  }

  /// 백엔드로 로그인 요청
  Future<bool> _loginUser(SocialAuthResult authResult) async {
    try {
      final tokens = await ref
          .read(authRepositoryProvider)
          .authenticateWithSocial(
            providerType: authResult.providerType,
            authCode: authResult.authCode,
          );

      if (tokens != null) {
        await ref.read(authTokenManagerProvider.notifier).saveTokens(tokens);
        return true;
      }
      return false;
    } catch (e) {
      talker.debug('Login error: $e');
      return false;
    }
  }

  /// 최근 로그인 Provider 저장
  // NOTE: 적용 시점 고민 필요(로그인 완료 vs 버튼만 눌러도)
  Future<void> _saveLastLoginProvider(String provider) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastLoginProvider', provider);
  }
}
