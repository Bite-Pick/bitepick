import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/features/address/presentation/search_address_screen.dart';
import 'package:magambell/src/features/auth/presenation/join_basic_info_screen.dart';
import 'package:magambell/src/features/auth/presenation/join_success_screen.dart';
import 'package:magambell/src/features/auth/presenation/login_screen.dart';
import 'package:magambell/src/features/auth/presenation/owner/owner_join_info_screen.dart';
import 'package:magambell/src/features/auth/presenation/select_user_type_screen.dart';
import 'package:magambell/src/features/goods/presentation/goods_register_screen.dart';
import 'package:magambell/src/features/main/presentation/main_screen.dart';
import 'package:magambell/src/features/map/presentation/store_map_screen.dart';
import 'package:magambell/src/features/order/presentation/order_caution_screen.dart';
import 'package:magambell/src/features/order/presentation/order_pay_screen.dart';
import 'package:magambell/src/features/owner/prsentation/owner_home_screen.dart';
import 'package:magambell/src/features/search/presentation/search_screen.dart';
import 'package:magambell/src/features/store/presentation/store_screen.dart';
import 'package:magambell/src/features/user/domain/entities/user.dart';
import 'package:magambell/src/features/user/providers/user.provider.dart';

part 'app_router.g.dart';

class GlobalVariable {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}

// GoRouter가 userState 변경을 감지하기 위한 Notifier
class _UserStateNotifier extends ChangeNotifier {
  _UserStateNotifier(this.ref) {
    ref.listen<AsyncValue<User?>>(userStateProvider, (previous, next) {
      notifyListeners();
    });
  }
  final Ref ref;
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final notifier = _UserStateNotifier(ref);

  return GoRouter(
    initialLocation: '/',
    navigatorKey: GlobalVariable.navigatorKey,
    debugLogDiagnostics: true,
    routes: $appRoutes,
    refreshListenable: notifier,
  );
});

// 하위 호환성을 위한 기존 appRouter (deprecated)
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
    TypedGoRoute<JoinBasicInfoRoute>(
      name: 'JoinBasicInfoRoute',
      path: 'join/basic-info',
    ),
    TypedGoRoute<JoinSuccessRoute>(
      name: 'JoinSuccessRoute',
      path: 'join/success',
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

@TypedGoRoute<DefaultRoute>(
  name: 'DefaultRoute',
  path: '/',
  routes: [
    TypedGoRoute<MainRoute>(name: 'MainRoute', path: 'main'),
    TypedGoRoute<OwnerHomeRoute>(name: 'OwnerHomeRoute', path: 'owner/home'),
    TypedGoRoute<GoodsRegisterRoute>(
      name: 'GoodsRegisterRoute',
      path: 'owner/goods/register',
    ),
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
class DefaultRoute extends GoRouteData {
  const DefaultRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // This should never be reached due to redirect
    return const MainScreen();
  }

  @override
  String? redirect(BuildContext context, GoRouterState state) {
    // 최초 실행일때만 하위 로직을 수행하기 위함
    if (state.uri.path != '/') return null;

    // ProviderContainer를 통해 userProvider 접근
    final ref = ProviderScope.containerOf(context);
    final userAsync = ref.read(userStateProvider);

    // 에러가 발생했거나 유저가 없으면 로그인 화면으로
    final user = userAsync.valueOrNull;
    if (user == null) return LoginRoute().location;

    // userRole에 따라 다른 홈 화면으로 리다이렉트
    switch (user.userRole) {
      case UserRole.owner:
        return OwnerHomeRoute().location;
      case UserRole.guest:
      case UserRole.admin: // TODO: 확인 필요
        return MainRoute().location;
    }
  }
}

class MainRoute extends GoRouteData {
  const MainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MainScreen();
  }
}
