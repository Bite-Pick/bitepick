import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/mg_textfield.dart';

class SearchAddressRoute extends GoRouteData {
  const SearchAddressRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SearchAddressScreen();
  }
}

class SearchAddressScreen extends ConsumerWidget {
  const SearchAddressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: Text("주소 설정"),
        action: MgButton(
          onPressed: () {},
          content: Text("편집").textGray().regular(),
        ),
      ),
      body: Column(
        children: [
          // TODO: 페이지 켰을때 focusNode 자동 포커스되는지 확인
          MgTextField(
            hintText: '지역의 동 이름으로 검색해보세요!',
            onSubmitted: (text) {
              // TODO: 주소 검색 API 연동
            },
          ),
          MgButton(
            onPressed: () {
              // TODO: 현재 위치로 찾기 기능 구현
            },
            content: Text("현재 위치로 찾기").xs().regular(),
            padding: Gutter.hsm,
          ).gray(),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: 0,
          //     itemBuilder: (context, index) {
          // TODO: dataSource sharedPreference로 변경
          //       return SizedBox();
          //     },
          //   ),
          // ),
        ],
      ).margin(horizontal: MgSizes.md),
    );
  }
}
