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
    state = const AsyncValue.loading();

    try {
      // 1. 네이버 SDK로 로그인 실행 및 프로필 가져오기
      final authResult = await ref
          .read(socialAuthRepositoryProvider)
          .signInWithNaver();

      if (authResult == null) {
        state = AsyncValue.error('네이버 로그인에 실패했습니다.', StackTrace.current);
        return false;
      }

      // 2. 최근 로그인 정보 저장
      await _saveLastLoginProvider('NAVER');

      // 3. 백엔드로 기존 회원 검증
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
        await ref.read(socialAuthRepositoryProvider).logoutNaver();
        state = AsyncValue.error('로그인에 실패했습니다.', StackTrace.current);
        return false;
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error('네이버 로그인 중 오류가 발생했습니다.', stackTrace);
      return false;
    }
  }

  /// 카카오 로그인
  Future<bool> signInWithKakao() async {
    state = const AsyncValue.loading();

    try {
      // 1. 카카오 SDK로 로그인 실행 및 프로필 가져오기
      final authResult = await ref
          .read(socialAuthRepositoryProvider)
          .signInWithKakao();

      if (authResult == null) {
        state = AsyncValue.error('카카오 로그인에 실패했습니다.', StackTrace.current);
        return false;
      }

      // 2. 최근 로그인 정보 저장
      await _saveLastLoginProvider('KAKAO');

      // 3. 백엔드로 기존 회원 검증
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
        await ref.read(socialAuthRepositoryProvider).logoutKakao();
        state = AsyncValue.error('로그인에 실패했습니다.', StackTrace.current);
        return false;
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error('카카오 로그인 중 오류가 발생했습니다.', stackTrace);
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
