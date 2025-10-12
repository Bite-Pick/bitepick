import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/features/detail/presentation/detail_screen.dart';
import 'package:magambell/src/features/main/presentation/main_screen.dart';

part 'app_router.g.dart';

class GlobalVariable {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}

final appRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: GlobalVariable.navigatorKey,
  debugLogDiagnostics: true,
  routes: $appRoutes,
);

@TypedGoRoute<MainRoute>(
  name: 'MainRoute',
  path: '/',
  routes: [
    TypedGoRoute<DetailRoute>(
      name: 'DetailRoute',
      path: 'detail/:id',
    ),
  ],
)
class MainRoute extends GoRouteData {
  const MainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MainScreen();
  }
}
