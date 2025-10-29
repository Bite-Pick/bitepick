import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
    log("SearchAddressScreen build");
    return Listener(
      onPointerDown: (event) => log('Pointer down at ${event.position}'),
      child: BaseScaffold(
        appBar: BaseAppBar(
          title: Text("주소 설정"),
          action: MgButton(onPressed: () {}, content: Text("편집").textGray()),
        ),
        body: SafeArea(
          child: Column(
            children: [
              MgTextField(hintText: '지역의 동 이름으로 검색해보세요!'),
              MgButton(onPressed: () {}, content: Text("현재 위치로 찾기")),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: 0,
            //     itemBuilder: (context, index) {
            //       return SizedBox();
            //     },
            //   ),
            // ),
            ],
          ),
        ),
      ),
    );
  }
}
