import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/utils/debug_text.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_textfield.dart';

class SearchRoute extends GoRouteData {
  const SearchRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SearchScreen();
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      // appBar: const BaseAppBar(title: Text('매장 검색')),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(onTap: context.pop, child: BaseSvgIcon.left()),
                Gaps.w8,
                Expanded(child: MgTextField(hintText: "먹고 싶은 매장을 찾아주세요!")),
              ],
            ),
            DebugText("오류수정중"),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: 0,
            //     itemBuilder: (context, index) {
            //       return Container();
            //     },
            //   ),
            // ),
          ],
        ).margin(horizontal: MgSizes.md),
      ),
    );
  }
}
