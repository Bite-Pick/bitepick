// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$loginRoute, $defaultRoute];

RouteBase get $loginRoute => GoRouteData.$route(
  path: '/auth',
  name: 'LoginRoute',

  factory: $LoginRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: 'select-user-type',
      name: 'SelectUserTypeRoute',

      factory: $SelectUserTypeRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: 'join/basic-info',
      name: 'JoinBasicInfoRoute',

      factory: $JoinBasicInfoRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: 'join/success',
      name: 'JoinSuccessRoute',

      factory: $JoinSuccessRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: 'owner/join/info',
      name: 'OwnerJoinInfoRoute',

      factory: $OwnerJoinInfoRouteExtension._fromState,
    ),
  ],
);

extension $LoginRouteExtension on LoginRoute {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  String get location => GoRouteData.$location('/auth');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SelectUserTypeRouteExtension on SelectUserTypeRoute {
  static SelectUserTypeRoute _fromState(GoRouterState state) =>
      const SelectUserTypeRoute();

  String get location => GoRouteData.$location('/auth/select-user-type');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $JoinBasicInfoRouteExtension on JoinBasicInfoRoute {
  static JoinBasicInfoRoute _fromState(GoRouterState state) =>
      const JoinBasicInfoRoute();

  String get location => GoRouteData.$location('/auth/join/basic-info');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $JoinSuccessRouteExtension on JoinSuccessRoute {
  static JoinSuccessRoute _fromState(GoRouterState state) =>
      const JoinSuccessRoute();

  String get location => GoRouteData.$location('/auth/join/success');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $OwnerJoinInfoRouteExtension on OwnerJoinInfoRoute {
  static OwnerJoinInfoRoute _fromState(GoRouterState state) =>
      const OwnerJoinInfoRoute();

  String get location => GoRouteData.$location('/auth/owner/join/info');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $defaultRoute => GoRouteData.$route(
  path: '/',
  name: 'DefaultRoute',

  factory: $DefaultRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: 'main',
      name: 'MainRoute',

      factory: $MainRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: 'owner/home',
      name: 'OwnerHomeRoute',

      factory: $OwnerHomeRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: 'owner/goods/register',
      name: 'GoodsRegisterRoute',

      factory: $GoodsRegisterRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: 'store/:id',
      name: 'StoreRoute',

      factory: $StoreRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'map',
          name: 'StoreMapRoute',

          factory: $StoreMapRouteExtension._fromState,
        ),
      ],
    ),
    GoRouteData.$route(
      path: 'search',
      name: 'SearchRoute',

      factory: $SearchRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: 'address/search',
      name: 'SearchAddressRoute',

      factory: $SearchAddressRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: 'order/caution',
      name: 'OrderCautionRoute',

      factory: $OrderCautionRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: 'order/pay',
      name: 'OrderPayRoute',

      factory: $OrderPayRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: 'owner/store/approved',
      name: 'OwnerStoreApprovedRoute',

      factory: $OwnerStoreApprovedRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: 'owner/store/waiting',
      name: 'OwnerStoreWaitingRoute',

      factory: $OwnerStoreWaitingRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: 'owner/goods/empty',
      name: 'OwnerGoodsEmptyRoute',

      factory: $OwnerGoodsEmptyRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: 'owner/store/edit',
      name: 'GoodsEditRoute',

      factory: $GoodsEditRouteExtension._fromState,
    ),
  ],
);

extension $DefaultRouteExtension on DefaultRoute {
  static DefaultRoute _fromState(GoRouterState state) => const DefaultRoute();

  String get location => GoRouteData.$location('/');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MainRouteExtension on MainRoute {
  static MainRoute _fromState(GoRouterState state) => const MainRoute();

  String get location => GoRouteData.$location('/main');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $OwnerHomeRouteExtension on OwnerHomeRoute {
  static OwnerHomeRoute _fromState(GoRouterState state) =>
      const OwnerHomeRoute();

  String get location => GoRouteData.$location('/owner/home');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $GoodsRegisterRouteExtension on GoodsRegisterRoute {
  static GoodsRegisterRoute _fromState(GoRouterState state) =>
      const GoodsRegisterRoute();

  String get location => GoRouteData.$location('/owner/goods/register');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $StoreRouteExtension on StoreRoute {
  static StoreRoute _fromState(GoRouterState state) =>
      StoreRoute(id: state.pathParameters['id']!);

  String get location =>
      GoRouteData.$location('/store/${Uri.encodeComponent(id)}');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $StoreMapRouteExtension on StoreMapRoute {
  static StoreMapRoute _fromState(GoRouterState state) => StoreMapRoute(
    id: state.pathParameters['id']!,
    $extra: state.extra as StoreMapExtra,
  );

  String get location =>
      GoRouteData.$location('/store/${Uri.encodeComponent(id)}/map');

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $SearchRouteExtension on SearchRoute {
  static SearchRoute _fromState(GoRouterState state) => const SearchRoute();

  String get location => GoRouteData.$location('/search');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SearchAddressRouteExtension on SearchAddressRoute {
  static SearchAddressRoute _fromState(GoRouterState state) =>
      const SearchAddressRoute();

  String get location => GoRouteData.$location('/address/search');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $OrderCautionRouteExtension on OrderCautionRoute {
  static OrderCautionRoute _fromState(GoRouterState state) =>
      const OrderCautionRoute();

  String get location => GoRouteData.$location('/order/caution');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $OrderPayRouteExtension on OrderPayRoute {
  static OrderPayRoute _fromState(GoRouterState state) => const OrderPayRoute();

  String get location => GoRouteData.$location('/order/pay');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $OwnerStoreApprovedRouteExtension on OwnerStoreApprovedRoute {
  static OwnerStoreApprovedRoute _fromState(GoRouterState state) =>
      const OwnerStoreApprovedRoute();

  String get location => GoRouteData.$location('/owner/store/approved');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $OwnerStoreWaitingRouteExtension on OwnerStoreWaitingRoute {
  static OwnerStoreWaitingRoute _fromState(GoRouterState state) =>
      const OwnerStoreWaitingRoute();

  String get location => GoRouteData.$location('/owner/store/waiting');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $OwnerGoodsEmptyRouteExtension on OwnerGoodsEmptyRoute {
  static OwnerGoodsEmptyRoute _fromState(GoRouterState state) =>
      OwnerGoodsEmptyRoute();

  String get location => GoRouteData.$location('/owner/goods/empty');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $GoodsEditRouteExtension on GoodsEditRoute {
  static GoodsEditRoute _fromState(GoRouterState state) =>
      GoodsEditRoute($extra: state.extra as Map<String, dynamic>?);

  String get location => GoRouteData.$location('/owner/store/edit');

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}
