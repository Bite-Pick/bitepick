import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/features/admin/presentation/admin_upload_screen.dart';
import 'package:magambell/src/features/admin/presentation/waiting_store_list_view.dart';
import 'package:magambell/src/features/owner/prsentation/widgets/owner_more_button.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';

class AdminHomeRoute extends GoRouteData {
  const AdminHomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminHomeScreen();
  }
}

class AdminHomeScreen extends ConsumerStatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminHomeScreenState();
}

class _AdminHomeScreenState extends ConsumerState<AdminHomeScreen>
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
      appBar: BaseAppBar(
        action: OwnerMoreButton(),
        leading: SizedBox.shrink(),
        bottom: TabBar(
          dividerColor: Colors.transparent,
          controller: _tabController,
          labelColor: MgColorScheme.text,
          unselectedLabelColor: MgColorScheme.gray5,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: MgColorScheme.gray1, width: 2),
          ),
          labelStyle: context.textTheme.titleLarge,
          unselectedLabelStyle: context.textTheme.bodyLarge,
          tabs: [
            Tab(text: '가게 승인'),
            Tab(text: '데이터 업로드'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [WaitingStoreListView(), AdminUploadScreen()],
      ),
    );
  }
}
