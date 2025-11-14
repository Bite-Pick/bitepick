import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/auth/data/repositories/auth_repository.dart';
import 'package:magambell/src/features/auth/domain/entities/auth_provider_type.dart';
import 'package:magambell/src/features/auth/domain/entities/user_role.dart';
import 'package:magambell/src/features/auth/providers/auth_token_manager.dart';
import 'package:magambell/src/widgets/mg_reactive_phone_textfield.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'join_screen.controller.freezed.dart';
part 'join_screen.controller.g.dart';

@freezed
class JoinState with _$JoinState {
  const factory JoinState({
    @Default(null) UserRole? userRole,
    @Default(null) AuthProviderType? providerType,
    @Default(null) String? socialToken,
    @Default('') String nickname,
    @Default('') String phone,
    @Default(false) bool isLoading,
    String? error,
  }) = _JoinState;
}

@Riverpod(keepAlive: true)
class JoinController extends _$JoinController {
  @override
  JoinState build() {
    return const JoinState();
  }

  // 1단계: UserRole 선택
  void setUserRole(UserRole userRole) {
    state = state.copyWith(userRole: userRole);
  }

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
  }

  // 3단계: 전화번호 입력
  void setPhone(String phone) {
    // 숫자만 추출 (하이픈 등 제거)
    final digitsOnly = phone.replaceAll(RegExp(r'[^0-9]'), '');
    state = state.copyWith(phone: digitsOnly);
  }

  // 전화번호 포맷팅 (UI 표시용)
  String getFormattedPhone() {
    return formatPhoneNumber(state.phone);
  }

  // 최종 회원가입 API 호출
  Future<bool> completeSignup() async {
    if (state.userRole == null) {
      state = state.copyWith(error: '사용자 유형을 선택해주세요');
      return false;
    }

    if (state.providerType == null || state.socialToken == null) {
      state = state.copyWith(error: '소셜 로그인 정보가 없습니다');
      return false;
    }

    if (state.nickname.trim().isEmpty) {
      state = state.copyWith(error: '닉네임을 입력해주세요');
      return false;
    }

    if (state.phone.trim().isEmpty) {
      state = state.copyWith(error: '전화번호를 입력해주세요');
      return false;
    }

  
      state = state.copyWith(isLoading: true, error: null);

      final tokens = await ref
          .read(authRepositoryProvider)
          .authenticateWithSocial(
            providerType: state.providerType!,
            authCode: state.socialToken!,
            userRole: state.userRole!.value,
            nickName: state.nickname,
            phoneNumber: state.phone,
          );
      if (tokens == null) return false;
      await ref.read(authTokenManagerProvider.notifier).saveTokens(tokens);
      state = state.copyWith(isLoading: false);
      return true;
    
  }

  // 에러 상태 설정
  void setError({required bool isLoading, required String error}) {
    state = state.copyWith(isLoading: isLoading, error: error);
  }

  // 상태 초기화
  void reset() {
    state = const JoinState();
  }
}
