// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$onboardingRoute, $splashRoute, $loginRoute, $defaultRoute];

RouteBase get $onboardingRoute => GoRouteData.$route(
  path: '/onboarding',
  name: 'OnboardingRoute',

  factory: $OnboardingRouteExtension._fromState,
);

extension $OnboardingRouteExtension on OnboardingRoute {
  static OnboardingRoute _fromState(GoRouterState state) => const OnboardingRoute();

  String get location => GoRouteData.$location('/onboarding');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $splashRoute => GoRouteData.$route(
  path: '/splash',
  name: 'SplashRoute',

  factory: $SplashRouteExtension._fromState,
);

extension $SplashRouteExtension on SplashRoute {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  String get location => GoRouteData.$location('/splash');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

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
    GoRouteData.$route(
      path: 'guest/adress/select',
      name: 'SelectAddressRoute',

      factory: $SelectAddressRouteExtension._fromState,
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

extension $SelectAddressRouteExtension on SelectAddressRoute {
  static SelectAddressRoute _fromState(GoRouterState state) =>
      SelectAddressRoute();

  String get location => GoRouteData.$location('/auth/guest/adress/select');

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
      path: 'service-region/select',
      name: 'SelectServiceRegionRoute',

      factory: $SelectServiceRegionRouteExtension._fromState,
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
      path: 'home/map',
      name: 'HomeMapRoute',

      factory: $HomeMapRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: 'search',
      name: 'SearchRoute',

      factory: $SearchRouteExtension._fromState,
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
      path: 'order/payment',
      name: 'PortOnePaymentRoute',

      factory: $PortOnePaymentRouteExtension._fromState,
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
    GoRouteData.$route(
      path: 'talker',
      name: 'TalkerRoute',

      factory: $TalkerRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: 'favorite',
      name: 'FavoriteRoute',

      factory: $FavoriteRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: 'my-reviews',
      name: 'MyReviewListRoute',

      factory: $MyReviewListRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: 'admin',
      name: 'AdminHomeRoute',

      factory: $AdminHomeRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'banner',
          name: 'AdminBannerListRoute',

          factory: $AdminBannerListRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'waiting-store',
          name: 'WaitingStoreListRoute',

          factory: $AdminPendingStoreListRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'approval',
              name: 'AdminPendingStoreDetailRoute',

              factory: $AdminPendingStoreDetailRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'approved-store',
          name: 'ApprovedStoreListRoute',

          factory: $AdminRegisteredStoreListRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'management',
              name: 'AdminRegisteredStoreDetailRoute',

              factory: $AdminRegisteredStoreDetailRouteExtension._fromState,
            ),
          ],
        ),
      ],
    ),
    GoRouteData.$route(
      path: 'review/register/:orderGoodsId',
      name: 'ReviewRegisterRoute',

      factory: $ReviewRegisterRouteExtension._fromState,
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

extension $SelectServiceRegionRouteExtension on SelectServiceRegionRoute {
  static SelectServiceRegionRoute _fromState(GoRouterState state) =>
      SelectServiceRegionRoute();

  String get location => GoRouteData.$location('/service-region/select');

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

extension $HomeMapRouteExtension on HomeMapRoute {
  static HomeMapRoute _fromState(GoRouterState state) => const HomeMapRoute();

  String get location => GoRouteData.$location('/home/map');

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

extension $OrderCautionRouteExtension on OrderCautionRoute {
  static OrderCautionRoute _fromState(GoRouterState state) =>
      OrderCautionRoute(storeId: state.uri.queryParameters['store-id']!);

  String get location => GoRouteData.$location(
    '/order/caution',
    queryParams: {'store-id': storeId},
  );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $OrderPayRouteExtension on OrderPayRoute {
  static OrderPayRoute _fromState(GoRouterState state) =>
      OrderPayRoute(storeId: state.uri.queryParameters['store-id']!);

  String get location =>
      GoRouteData.$location('/order/pay', queryParams: {'store-id': storeId});

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PortOnePaymentRouteExtension on PortOnePaymentRoute {
  static PortOnePaymentRoute _fromState(GoRouterState state) =>
      PortOnePaymentRoute(
        storeId: state.uri.queryParameters['store-id']!,
        paymentId: state.uri.queryParameters['payment-id']!,
        amount: int.parse(state.uri.queryParameters['amount']!),
      );

  String get location => GoRouteData.$location(
    '/order/payment',
    queryParams: {
      'store-id': storeId,
      'payment-id': paymentId,
      'amount': amount.toString(),
    },
  );

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

extension $TalkerRouteExtension on TalkerRoute {
  static TalkerRoute _fromState(GoRouterState state) => const TalkerRoute();

  String get location => GoRouteData.$location('/talker');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $FavoriteRouteExtension on FavoriteRoute {
  static FavoriteRoute _fromState(GoRouterState state) => const FavoriteRoute();

  String get location => GoRouteData.$location('/favorite');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MyReviewListRouteExtension on MyReviewListRoute {
  static MyReviewListRoute _fromState(GoRouterState state) =>
      const MyReviewListRoute();

  String get location => GoRouteData.$location('/my-reviews');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AdminHomeRouteExtension on AdminHomeRoute {
  static AdminHomeRoute _fromState(GoRouterState state) =>
      const AdminHomeRoute();

  String get location => GoRouteData.$location('/admin');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AdminBannerListRouteExtension on AdminBannerListRoute {
  static AdminBannerListRoute _fromState(GoRouterState state) =>
      AdminBannerListRoute();

  String get location => GoRouteData.$location('/admin/banner');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AdminPendingStoreListRouteExtension on AdminPendingStoreListRoute {
  static AdminPendingStoreListRoute _fromState(GoRouterState state) =>
      AdminPendingStoreListRoute();

  String get location => GoRouteData.$location('/admin/waiting-store');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AdminPendingStoreDetailRouteExtension
    on AdminPendingStoreDetailRoute {
  static AdminPendingStoreDetailRoute _fromState(GoRouterState state) =>
      AdminPendingStoreDetailRoute(
        $extra: state.extra as AdminPendingStoreDetailExtra,
      );

  String get location => GoRouteData.$location('/admin/waiting-store/approval');

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $AdminRegisteredStoreListRouteExtension
    on AdminRegisteredStoreListRoute {
  static AdminRegisteredStoreListRoute _fromState(GoRouterState state) =>
      AdminRegisteredStoreListRoute();

  String get location => GoRouteData.$location('/admin/approved-store');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AdminRegisteredStoreDetailRouteExtension
    on AdminRegisteredStoreDetailRoute {
  static AdminRegisteredStoreDetailRoute _fromState(GoRouterState state) =>
      AdminRegisteredStoreDetailRoute(
        $extra: state.extra as AdminRegisteredStoreDetailExtra,
      );

  String get location =>
      GoRouteData.$location('/admin/approved-store/management');

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $ReviewRegisterRouteExtension on ReviewRegisterRoute {
  static ReviewRegisterRoute _fromState(GoRouterState state) =>
      ReviewRegisterRoute(orderGoodsId: state.pathParameters['orderGoodsId']!);

  String get location => GoRouteData.$location(
    '/review/register/${Uri.encodeComponent(orderGoodsId)}',
  );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
