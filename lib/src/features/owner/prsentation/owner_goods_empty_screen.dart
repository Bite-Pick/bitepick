import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/goods/presentation/goods_register_screen.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class OwnerGoodsEmptyRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return OwnerGoodsEmptyScreen();
  }
}

class OwnerGoodsEmptyScreen extends ConsumerWidget {
  const OwnerGoodsEmptyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseScaffold(
      appBar: BaseAppBar(leading: SizedBox.shrink()),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text("앗! 등록된 메뉴가 없어요").bold(),
            Gaps.h24,
            MgButton(
              content: Text("바이트백 등록하러가기"),
              onPressed: () async => GoodsRegisterRoute().push(context),
            ).primary().constrained(width: 200.w),
          ],
        ),
      ),
    );
    ;
  }
}
