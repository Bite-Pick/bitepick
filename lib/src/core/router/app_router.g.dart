// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$loginRoute, $mainRoute];

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

RouteBase get $mainRoute => GoRouteData.$route(
  path: '/',
  name: 'MainRoute',

  factory: $MainRouteExtension._fromState,
  routes: [
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
  ],
);

extension $MainRouteExtension on MainRoute {
  static MainRoute _fromState(GoRouterState state) => const MainRoute();

  String get location => GoRouteData.$location('/');

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
