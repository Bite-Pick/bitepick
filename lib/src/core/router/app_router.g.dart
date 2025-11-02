// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$mainRoute];

RouteBase get $mainRoute => GoRouteData.$route(
  path: '/',
  name: 'MainRoute',

  factory: $MainRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: 'store/:id',
      name: 'StoreRoute',

      factory: $StoreRouteExtension._fromState,
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
  static OrderCautionRoute _fromState(GoRouterState state) => OrderCautionRoute(
    count:
        _$convertMapValue('count', state.uri.queryParameters, int.parse) ?? 1,
  );

  String get location => GoRouteData.$location(
    '/order/caution',
    queryParams: {if (count != 1) 'count': count.toString()},
  );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $OrderPayRouteExtension on OrderPayRoute {
  static OrderPayRoute _fromState(GoRouterState state) =>
      OrderPayRoute(int.parse(state.uri.queryParameters['count']!));

  String get location => GoRouteData.$location(
    '/order/pay',
    queryParams: {'count': count.toString()},
  );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}
