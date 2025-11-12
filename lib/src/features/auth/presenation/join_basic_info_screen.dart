import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/auth/presenation/join_screen.controller.dart';
import 'package:magambell/src/features/auth/presenation/join_success_screen.dart';
import 'package:magambell/src/features/user/providers/user.provider.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/mg_textfield.dart';

class JoinBasicInfoRoute extends GoRouteData {
  const JoinBasicInfoRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const JoinBasicInfoScreen();
  }
}

class JoinBasicInfoScreen extends ConsumerStatefulWidget {
  const JoinBasicInfoScreen({super.key});

  @override
  ConsumerState<JoinBasicInfoScreen> createState() =>
      _JoinBasicInfoScreenState();
}

class _JoinBasicInfoScreenState extends ConsumerState<JoinBasicInfoScreen> {
  final _nicknameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nicknameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final controller = ref.read(joinControllerProvider.notifier);

    // 입력값 저장
    controller.setNickname(_nicknameController.text);
    controller.setPhone(_phoneController.text);

    // 회원가입 API 호출
    final success = await controller.completeSignup();

    if (!mounted) return;

    if (success) {
      if (!mounted) return;
      JoinSuccessRoute().go(context);
    } else {
      // 에러 표시
      final error = ref.read(joinControllerProvider).error;
      if (error != null) {
        context.showFlash(
          duration: const Duration(milliseconds: 2000),
          builder: (context, flashController) {
            return FlashBar(controller: flashController, content: Text(error));
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final joinState = ref.watch(joinControllerProvider);

    return BaseScaffold(
      appBar: BaseAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "시작을 위해\n간단한 정보를 입력해주세요",
          ).bold().xl().margin(top: MgSizes.size32, bottom: MgSizes.sm),
          Text("마이페이지에서 언제든지 수정 가능해요").sm().textGray(),
          Gaps.h40,
          MgTextField(
            label: "닉네임",
            controller: _nicknameController,
            prefixIcon: SizedBox.shrink(),
          ),
          Gaps.h32,
          MgTextField(
            label: "전화번호",
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            prefixIcon: SizedBox.shrink(),
          ),
          Spacer(),
          MgButton(
            onPressed: joinState.isLoading ? null : _handleSubmit,
            content: Text(joinState.isLoading ? "처리중..." : "완료"),
          ).primary(),
        ],
      ).margin(horizontal: MgSizes.xl),
    );
  }
}
