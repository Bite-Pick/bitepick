import 'package:flutter/material.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';

/// GoRouter용 Talker Route Observer
class TalkerRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name != null) {
      talker.info('[GoRouter] pushing ${route.settings.name}');
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (route.settings.name != null) {
      talker.info('[GoRouter] popping ${route.settings.name}');
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    if (route.settings.name != null) {
      talker.info('[GoRouter] removing ${route.settings.name}');
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute?.settings.name != null) {
      talker.info(
        '[GoRouter] replacing ${oldRoute?.settings.name} -> ${newRoute?.settings.name}',
      );
    }
  }
}
