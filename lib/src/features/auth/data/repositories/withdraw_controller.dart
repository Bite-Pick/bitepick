import 'package:flutter/material.dart';
import 'package:magambell/src/features/auth/data/repositories/auth_repository.dart';
import 'package:magambell/src/features/user/providers/user.provider.dart';
import 'package:magambell/src/widgets/mg_alert_dialog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'social_auth_repository.dart';
import 'package:magambell/src/features/auth/domain/entities/auth_provider_type.dart';

part 'withdraw_controller.g.dart';

@riverpod
class WithdrawController extends _$WithdrawController {
  @override
  FutureOr<void> build() {}

  Future<bool> withdraw({required BuildContext context}) async {
    // 확인 다이얼로그
    bool ok = false;
    await showDialog(
      context: context,
      builder: (context) => MgAlertDialog(
        title: "정말로 탈퇴하시겠어요?",
        content: Text("다음에 또 만날 수 있으면 좋겠어요!"),
        onConfirm: () => ok = true,
      ),
    );
    if (!ok) return false;

    state = const AsyncLoading();

    try {
      // 1) 소셜 재인증 → 최신 토큰 확보
      final user = await ref.read(userStateProvider.future);
      if (user == null) {
        state = AsyncError('로그인 상태가 아닙니다', StackTrace.empty);
        return false;
      }
      final providerType = user.providerType;
      final repository = ref.read(socialAuthRepositoryProvider);
      String? authCode;

      switch (providerType) {
        case AuthProviderType.KAKAO:
          authCode = (await repository.signInWithKakao())?.authCode;
          break;
        case AuthProviderType.NAVER:
          authCode = (await repository.signInWithNaver())?.authCode;
          break;
        case AuthProviderType.APPLE:
          authCode =
              (await repository.signInWithApple())?.authCode; // identityToken
          break;
        // 이메일/자체계정이 있다면 여기에 분기 추가
        default:
          authCode = null;
      }

      if (authCode == null || authCode.isEmpty) {
        state = const AsyncError('소셜 인증에 실패했습니다.', StackTrace.empty);
        _showSnack(context, '소셜 인증 실패', isError: true);
        return false;
      }

      // ✅ 2) 도메인 레벨 AuthRepository 호출로 변경
      final success = await ref
          .read(authRepositoryProvider)
          .withdraw(providerType: providerType, authCode: authCode);

      if (!success) {
        state = const AsyncError('탈퇴 요청에 실패했습니다.', StackTrace.empty);
        _showSnack(context, '탈퇴 요청에 실패했습니다.', isError: true);
        return false;
      }
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      _showSnack(context, '알 수 없는 오류가 발생했습니다.', isError: true);
      return false;
    }
  }

  void _showSnack(BuildContext context, String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.red : null,
      ),
    );
  }
}
