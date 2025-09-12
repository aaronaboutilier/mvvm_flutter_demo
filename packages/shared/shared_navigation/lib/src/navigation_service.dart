import 'package:flutter/widgets.dart';

abstract class NavigationService {
  Future<void> go(String location, {Object? extra});
  Future<void> push(String location, {Object? extra});
  void pop<T extends Object?>([T? result]);
}

class NavigatorKeyNavigationService implements NavigationService {
  NavigatorKeyNavigationService(this.navigatorKey);
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Future<void> go(String location, {Object? extra}) async {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(location, (route) => false, arguments: extra);
  }

  @override
  Future<void> push(String location, {Object? extra}) async {
    await navigatorKey.currentState?.pushNamed(location, arguments: extra);
  }

  @override
  void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState?.pop(result);
  }
}
