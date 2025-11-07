import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';

class OwnerHomeScreen extends ConsumerStatefulWidget {
  const OwnerHomeScreen({super.key});

  @override
  ConsumerState<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends ConsumerState<OwnerHomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        bottom: TabBar(
          dividerColor: Colors.transparent,
          controller: _tabController,
          labelColor: MgColorScheme.text,
          unselectedLabelColor: MgColorScheme.gray5,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: MgColorScheme.gray1, width: 2),
          ),
          labelStyle: context.textTheme.bodyLarge,
          unselectedLabelStyle: context.textTheme.bodyLarge,
          tabs: [
            Tab(text: '주문'),
            Tab(text: '판매'),
            Tab(text: '관리'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [Text("주문"), Text("판매"), Text("관리")],
      ),
    );
  }
}