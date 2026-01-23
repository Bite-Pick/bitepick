import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/core/network/api_exception.dart';
import 'package:magambell/src/features/auth/data/repositories/auth_repository.dart';
import 'package:magambell/src/features/auth/domain/entities/auth_provider_type.dart';
import 'package:magambell/src/features/auth/domain/entities/user_role.dart';
import 'package:magambell/src/features/auth/providers/auth_token_manager.dart';
import 'package:magambell/src/widgets/mg_reactive_phone_textfield.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'join_basic_info_screen.controller.freezed.dart';
part 'join_basic_info_screen.controller.g.dart';

@freezed
class JoinBasicInfoState with _$JoinBasicInfoState {
  const factory JoinBasicInfoState({
    @Default(null) UserRole? userRole,
    @Default(null) AuthProviderType? providerType,
    @Default(null) String? socialToken,
    @Default('') String nickname,
    @Default('') String phone,
    @Default(false) bool isLoading,
    @Default(false) bool submitted, // submit 버튼을 눌렀는지 여부
    String? error,
    String? nicknameError,
    String? phoneError,
  }) = _JoinBasicInfoState;
}

@Riverpod(keepAlive: true)
class JoinBasicInfoScreenController extends _$JoinBasicInfoScreenController {
  @override
  JoinBasicInfoState build() => const JoinBasicInfoState();

  // 1단계: UserRole 선택
  void setUserRole(UserRole userRole) =>
      state = state.copyWith(userRole: userRole);

  // 소셜 로그인 정보 저장
  void setSocialLoginInfo({
    required AuthProviderType providerType,
    required String socialToken,
  }) {
    state = state.copyWith(
      providerType: providerType,
      socialToken: socialToken,
    );
  }

  // 2단계: 닉네임 입력
  void setNickname(String nickname) {
    state = state.copyWith(nickname: nickname);
    // submitted가 true일 때만 실시간 검증
    if (state.submitted) {
      validateInputs();
    }
  }

  // 3단계: 전화번호 입력
  void setPhone(String phone) {
    // 숫자만 추출 (하이픈 등 제거)
    final digitsOnly = phone.replaceAll(RegExp(r'[^0-9]'), '');
    state = state.copyWith(phone: digitsOnly);
    // submitted가 true일 때만 실시간 검증
    if (state.submitted) {
      validateInputs();
    }
  }

  // 전화번호 포맷팅 (UI 표시용)
  String getFormattedPhone() => formatPhoneNumber(state.phone);

  // 전화번호 포맷팅 및 업데이트 (TextEditingController용)
  String formatAndUpdatePhone(String text) {
    final digitsOnly = text.replaceAll(RegExp(r'[^0-9]'), '');

    // 최대 11자리로 제한
    final limited = digitsOnly.length > 11
        ? digitsOnly.substring(0, 11)
        : digitsOnly;

    // 상태 업데이트
    state = state.copyWith(phone: limited);

    // 포맷팅된 문자열 반환
    return formatPhoneNumber(limited);
  }

  // 최종 회원가입 API 호출
  Future<bool> completeSignup() async {
    // Submit 상태로 변경 (이후 실시간 검증 활성화)
    state = state.copyWith(submitted: true);

    // Validation 실행
    if (!await validateInputs()) {
      return false;
    }

    if (state.userRole == null) {
      state = state.copyWith(error: '사용자 유형을 선택해주세요', isLoading: false);
      return false;
    }

    if (state.providerType == null || state.socialToken == null) {
      state = state.copyWith(error: '소셜 로그인 정보가 없습니다', isLoading: false);
      return false;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final tokens = await ref
          .read(authRepositoryProvider)
          .authenticateWithSocial(
            providerType: state.providerType!,
            authCode: state.socialToken!,
            userRole: state.userRole!.value,
            nickName: state.nickname,
            phoneNumber: state.phone,
          );

      if (tokens == null) {
        state = state.copyWith(isLoading: false, error: '회원가입에 실패했습니다');
        return false;
      }

      await ref.read(authTokenManagerProvider.notifier).saveTokens(tokens);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      final errorMessage = switch (e) {
        DuplicateNicknameException() => '이미 사용 중인 닉네임입니다.',
        _ => '회원가입 중 오류가 발생했습니다',
      };

      state = state.copyWith(isLoading: false, error: errorMessage);
      return false;
    }
  }

  // 입력값 검증
  Future<bool> validateInputs() async {
    // submitted가 false면 에러 표시 안함 (submit 전)
    if (!state.submitted) return true;

    // 에러 초기화
    state = state.copyWith(nicknameError: null, phoneError: null);

    bool isValid = true;

    // 닉네임 검증
    if (state.nickname.trim().isEmpty) {
      state = state.copyWith(nicknameError: '닉네임을 입력해주세요');
      isValid = false;
    }
    // 닉네임 중복 검증
    // NOTE:에러메세지 통일 목적으로 submit이전에 체크
    else {
      final isDuplicate = await ref
          .read(authRepositoryProvider)
          .checkDuplicateNickname(nickName: state.nickname.trim());
      if (isDuplicate) {
        state = state.copyWith(nicknameError: '이미 사용 중인 닉네임입니다');
        isValid = false;
      }
    }

    // 전화번호 검증
    final phoneDigits = state.phone.replaceAll(RegExp(r'[^0-9]'), '');
    if (phoneDigits.isEmpty) {
      state = state.copyWith(phoneError: '전화번호를 입력해주세요');
      isValid = false;
    } else if (!RegExp(r'^01[0-9][0-9]{7,8}$').hasMatch(phoneDigits)) {
      state = state.copyWith(phoneError: '올바른 전화번호 형식이 아닙니다');
      isValid = false;
    }

    return isValid;
  }

  // 상태 초기화
  void reset() => state = const JoinBasicInfoState();
}
