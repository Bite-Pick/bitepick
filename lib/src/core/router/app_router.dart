import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/core/utils/talker_route_observer.dart';
import 'package:magambell/src/core/utils/talker_screen.dart';
import 'package:magambell/src/features/address/presentation/search_address_screen.dart';
import 'package:magambell/src/features/address/presentation/select_address_screen.dart';
import 'package:magambell/src/features/admin/presentation/admin_home_screen.dart';
import 'package:magambell/src/features/admin/presentation/admin_banner_list_screen.dart';
import 'package:magambell/src/features/auth/domain/entities/user_role.dart';
import 'package:magambell/src/features/auth/presenation/join_basic_info_screen.dart';
import 'package:magambell/src/features/auth/presenation/join_success_screen.dart';
import 'package:magambell/src/features/auth/presenation/login_screen.dart';
import 'package:magambell/src/features/auth/presenation/owner/owner_join_info_screen.dart';
import 'package:magambell/src/features/auth/presenation/select_user_type_screen.dart';
import 'package:magambell/src/features/favorite/presentation/favorite_screen.dart';
import 'package:magambell/src/features/goods/presentation/goods_edit_screen.dart';
import 'package:magambell/src/features/goods/presentation/goods_register_screen.dart';
import 'package:magambell/src/features/main/presentation/main_screen.dart';
import 'package:magambell/src/features/map/presentation/store_map_screen.dart';
import 'package:magambell/src/features/order/presentation/order_caution_screen.dart';
import 'package:magambell/src/features/order/presentation/order_pay_screen.dart';
import 'package:magambell/src/features/owner/prsentation/owner_goods_empty_screen.dart';
import 'package:magambell/src/features/owner/prsentation/owner_home_screen.dart';
import 'package:magambell/src/features/owner/prsentation/widgets/owner_approved_view.dart';
import 'package:magambell/src/features/review/presentation/my_review_list_screen.dart';
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
    observers: [TalkerRouteObserver()],
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
    TypedGoRoute<SelectAddressRoute>(
      name: 'SelectAddressRoute',
      path: 'guest/adress/select',
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
    TypedGoRoute<OwnerStoreApprovedRoute>(
      name: 'OwnerStoreApprovedRoute',
      path: 'owner/store/approved',
    ),
    TypedGoRoute<OwnerStoreWaitingRoute>(
      name: 'OwnerStoreWaitingRoute',
      path: 'owner/store/waiting',
    ),
    TypedGoRoute<OwnerGoodsEmptyRoute>(
      name: 'OwnerGoodsEmptyRoute',
      path: 'owner/goods/empty',
    ),
    TypedGoRoute<GoodsEditRoute>(
      name: 'GoodsEditRoute',
      path: 'owner/store/edit',
    ),
    TypedGoRoute<TalkerRoute>(name: 'TalkerRoute', path: 'talker'),
    TypedGoRoute<FavoriteRoute>(name: 'FavoriteRoute', path: 'favorite'),
    TypedGoRoute<MyReviewListRoute>(
      name: 'MyReviewListRoute',
      path: 'my-reviews',
    ),
    TypedGoRoute<AdminHomeRoute>(
      name: 'AdminHomeRoute',
      path: 'admin',
      routes: [
        TypedGoRoute<AdminBannerListRoute>(
          name: 'AdminBannerListRoute',
          path: 'banner',
        ),
      ],
    ),
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
  Future<String?> redirect(BuildContext context, GoRouterState state) async {
    // 최초 실행일때만 하위 로직을 수행하기 위함
    if (state.uri.path != '/') return null;

    try {
      // ProviderContainer를 통해 userProvider 접근
      final ref = ProviderScope.containerOf(context);
      final user = await ref.read(userStateProvider.future);
      if (user == null) return LoginRoute().location;

      // userRole에 따라 다른 홈 화면으로 리다이렉트
      switch (user.userRole) {
        case UserRole.owner:
          if (user.goodsId == "null") {
            return OwnerGoodsEmptyRoute().location;
          }
          if (user.approved == ApprovedStatus.waiting) {
            return OwnerStoreWaitingRoute().location;
          }
          return OwnerHomeRoute().location;
        case UserRole.customer:
          return MainRoute().location;
        case UserRole.admin: // TODO: 확인 필요
          return AdminHomeRoute().location;
      }
    } catch (error) {
      // NOTE: [AppInterceptor]에서 처리
      // // 에러 체크 - STORE_NOT_FOUND인 경우 Owner 매장 등록 화면으로
      // if (error is DioException && error.response?.data != null) {
      //   final errorCode = error.response?.data['code'];
      //   if (errorCode == 'STORE_NOT_FOUND') {
      //     // STORE_NOT_FOUND 에러면 매장 등록 화면으로
      //     return OwnerJoinInfoRoute().location;
      //   }
      //   return LoginRoute().location;
      // }
    }
    return null; // Default return if no redirection is needed or error handled
  }
}

class MainRoute extends GoRouteData {
  const MainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MainScreen();
  }
}
