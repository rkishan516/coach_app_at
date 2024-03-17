import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shiksha_dhra/app/routes/notifiers/app_router.dart';

part 'app_routes.g.dart';

final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter navigator(NavigatorRef ref) {
  final router = ref.watch(routerNotifierProvider.notifier);

  List<NavigatorObserver>? observers = [];

  return GoRouter(
    observers: observers,
    navigatorKey: appNavigatorKey,
    initialLocation: SplashPageRoute.path,
    refreshListenable: router,
    routes: router.routes,
    debugLogDiagnostics: kDebugMode,
  );
}

@riverpod
class RouterNotifier extends _$RouterNotifier implements Listenable {
  List<RouteBase> get routes => $appRoutes;

  @override
  void build() {}

  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}
}
