import 'package:flutter/material.dart';

class AppNavigatorObserver extends NavigatorObserver {
  AppNavigatorObserver();

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    debugPrint('didPush from ${previousRoute?.settings.name} to ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    debugPrint('didPop ${route.settings.name}, back to ${previousRoute?.settings.name}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    debugPrint('didRemove ${route.settings.name}, back to ${previousRoute?.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    debugPrint('didReplace ${oldRoute?.settings.name} by ${newRoute?.settings.name}');
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
  }
}
