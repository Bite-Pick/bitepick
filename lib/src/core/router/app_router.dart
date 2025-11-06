import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/features/address/presentation/search_address_screen.dart';
import 'package:magambell/src/features/auth/presenation/login_screen.dart';
import 'package:magambell/src/features/auth/presenation/owner/owner_join_info_screen.dart';
import 'package:magambell/src/features/auth/presenation/select_user_type_screen.dart';
import 'package:magambell/src/features/main/presentation/main_screen.dart';
import 'package:magambell/src/features/map/presentation/store_map_screen.dart';
import 'package:magambell/src/features/order/presentation/order_caution_screen.dart';
import 'package:magambell/src/features/order/presentation/order_pay_screen.dart';
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

@TypedGoRoute<LoginRoute>(
  name: 'LoginRoute',
  path: '/auth',
  routes: [
    TypedGoRoute<SelectUserTypeRoute>(
      name: 'SelectUserTypeRoute',
      path: 'select-user-type',
    ),
    TypedGoRoute<OwnerJoinInfoRoute>(
      name: 'OwnerJoinInfoRoute',
      path: 'owner/join/info',
    ),
  ],
)
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

@TypedGoRoute<MainRoute>(
  name: 'MainRoute',
  path: '/',
  routes: [
    TypedGoRoute<StoreRoute>(
      name: 'StoreRoute',
      path: 'store/:id',
      routes: [TypedGoRoute<StoreMapRoute>(name: 'StoreMapRoute', path: 'map')],
    ),
    TypedGoRoute<SearchRoute>(name: 'SearchRoute', path: 'search'),
    TypedGoRoute<SearchAddressRoute>(
      name: 'SearchAddressRoute',
      path: 'address/search',
    ),
    TypedGoRoute<OrderCautionRoute>(
      name: 'OrderCautionRoute',
      path: 'order/caution',
    ),
    TypedGoRoute<OrderPayRoute>(name: 'OrderPayRoute', path: 'order/pay'),
  ],
)
class MainRoute extends GoRouteData {
  const MainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MainScreen();
  }

  @override
  Future<String?> redirect(BuildContext context, GoRouterState state) async {
    try {
      return _checkRoute();
    } catch (e) {
      return LoginRoute().location;
    }
  }

  Future<String> _checkRoute() async {
    // TODO: auth Token manager에 token이 있다면 자동 로그인 시도
    return LoginRoute().location;
  }
}
