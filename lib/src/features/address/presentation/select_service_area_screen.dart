import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class SelectServiceAreaRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SelectServiceAreaScreen();
  }
}

class SelectServiceAreaScreen extends ConsumerStatefulWidget {
  const SelectServiceAreaScreen({super.key});

  @override
  ConsumerState<SelectServiceAreaScreen> createState() =>
      _SelectServiceAreaScreenState();
}

class _SelectServiceAreaScreenState
    extends ConsumerState<SelectServiceAreaScreen> {
  final _cellHeight = 42.h;
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: Text("서비스 지역 요청")),
      body: Column(
        children: [_buildTopInfoSection(), _buildAreaTableSection()],
      ),
      bottomNavigationBar: MgButton(
        // disabled: // TODO 지역 선택 여부에 따라 비활성화,
        onPressed: () {
          // TODO: api 호출
          // TODO: dialog 추가(카카오톡 공유하기 있는)
        },
        content: Text("서비스 지역 요청하기"),
      ).primary().margin(vertical: MgSizes.lg),
    );
  }

  Widget _buildTopInfoSection() {
    return Row(
          children: [
            Image.asset(R.ASSETS_IMAGES_CHARACTER_STANDING_PNG, width: 46),
            Gaps.w24,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("우리 동네도 서비스해주세요").md().bold(),
                Gaps.h4,
                Text("지역을 선택하고 오픈을 요청해보세요 🍞").textColor(MgColorScheme.gray4),
              ],
            ),
          ],
        )
        .margin(horizontal: MgSizes.xxl + 2, vertical: MgSizes.lg)
        .colored(MgColorScheme.primaryLightest);
  }

  Widget _buildAreaTableSection() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: _buildTableColumn('시 ∙ 도', ['서울', '경기도'])),
          Expanded(flex: 2, child: _buildTableColumn('시 ∙ 군 ∙ 구', ['서울 전체'])),
          Expanded(
            flex: 2,
            child: _buildTableColumn('동 ∙ 읍 ∙ 면', [], hasRightBorder: false),
          ),
        ],
      ),
    );
  }

  Widget _buildTableColumn(
    String title,
    List<String> contents, {
    bool hasRightBorder = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTableTitle(title),
        ...contents.map((e) => _buildTableCell(e)),
      ],
    ).decorated(
      border: Border(
        right: hasRightBorder
            ? BorderSide(color: MgColorScheme.gray8, width: 1)
            : BorderSide.none,
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isSelected = false}) {
    return Text(text)
        .center()
        .margin(right: MgSizes.md, vertical: MgSizes.sm)
        .colored(
          isSelected ? MgColorScheme.primary : MgColorScheme.gray11,
        ) // TODO: 위계에 따라 색상 + suffix 아이콘이 다름
        .constrained(height: _cellHeight, width: double.infinity);
  }

  Widget _buildTableTitle(String text) {
    return Text(text)
        .center()
        .bold()
        .margin(vertical: MgSizes.sm)
        .decorated(
          color: MgColorScheme.gray10,
          border: Border(
            bottom: BorderSide(color: MgColorScheme.gray8, width: 1),
          ),
        )
        .constrained(height: _cellHeight, width: double.infinity);
  }
}
