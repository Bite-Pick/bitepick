import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/features/address/presentation/search_address_screen.dart';
import 'package:magambell/src/features/home/presentation/home_screen.dart';
import 'package:magambell/src/features/main/presentation/main_screen.dart';
import 'package:magambell/src/features/order/presentation/order_caution_screen.dart';
import 'package:magambell/src/features/search/presentation/search_screen.dart';
import 'package:magambell/src/features/store/presentation/store_screen.dart';

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
    TypedGoRoute<StoreRoute>(name: 'StoreRoute', path: 'store/:id'),
    TypedGoRoute<SearchRoute>(name: 'SearchRoute', path: 'search'),
    TypedGoRoute<SearchAddressRoute>(
      name: 'SearchAddressRoute',
      path: 'address/search',
    ),
    TypedGoRoute<OrderCautionRoute>(
      name: 'OrderCautionRoute',
      path: 'order/caution',
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
