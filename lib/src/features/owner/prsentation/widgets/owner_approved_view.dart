import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/auth/providers/auth_token_manager.dart';
import 'package:magambell/src/features/auth/utils/auth_utils.dart';
import 'package:magambell/src/features/user/providers/user.provider.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class OwnerStoreApprovedRoute extends GoRouteData {
  const OwnerStoreApprovedRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return OwnerApprovedView.completed();
  }
}

class OwnerStoreWaitingRoute extends GoRouteData {
  const OwnerStoreWaitingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return OwnerApprovedView.reviewing();
  }
}

class OwnerApprovedView extends ConsumerWidget {
  const OwnerApprovedView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.assetName,
  });

  final String title;
  final String subtitle;
  final String assetName;

  factory OwnerApprovedView.completed() => const OwnerApprovedView(
    title: '매장 등록 완료!',
    subtitle: '24시간 내에 승인이 완료됩니다.\n승인 이후 고객의 앱에서 사장님 가게를\n볼 수 있으며 판매가 시작됩니다.',
    assetName: R.ASSETS_IMAGES_STORE_REGISTER_SUCCESS_PNG,
  );

  factory OwnerApprovedView.reviewing() => const OwnerApprovedView(
    title: '매장 등록 심사중입니다',
    subtitle: '24시간 내에 승인이 완료됩니다.\n승인 이후 고객의 앱에서 사장님 가게를\n볼 수 있으며 판매가 시작됩니다.',
    assetName: R.ASSETS_IMAGES_STORE_REIGSTER_WAITING_PNG,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseScaffold(
      appBar: BaseAppBar(leading: SizedBox.shrink()),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gaps.h128,
          Text(title).xl().bold(),
          Gaps.h8,
          Text(
            subtitle,
          ).md().center().margin(top: MgSizes.xs, bottom: MgSizes.xl),
          Image.asset(assetName).constrained(height: 225.h),
          Spacer(),
          MgButton(
            onPressed: () => logout(ref, context),
            content: const Text("로그아웃"),
          ),
        ],
      ),
    );
  }
}
