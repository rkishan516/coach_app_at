import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shiksha_dhra/app/auth/presentation/welcome_view.dart';
import 'package:shiksha_dhra/app/developer_menu/presentation/page.dart';
import 'package:shiksha_dhra/app/home/presentation/page.dart';
import 'package:shiksha_dhra/app/splash/presentation/page.dart';

part 'app_router.g.dart';

@TypedGoRoute<HomePageRoute>(
  path: HomePageRoute.path,
  name: HomePageRoute.name,
  routes: [
    // Other routes nested under the home route
  ],
)
class HomePageRoute extends GoRouteData {
  static const path = '/';
  static const name = 'home';
  const HomePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}

@TypedGoRoute<SplashPageRoute>(
  path: SplashPageRoute.path,
  name: SplashPageRoute.name,
)
class SplashPageRoute extends GoRouteData {
  static const path = '/splash';
  static const name = 'splash';
  const SplashPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SplashPage();
}

@TypedGoRoute<DeveloperMenuPageRoute>(
  path: DeveloperMenuPageRoute.path,
  name: DeveloperMenuPageRoute.name,
)
class DeveloperMenuPageRoute extends GoRouteData {
  static const path = '/developerMenu';
  static const name = 'developerMenu';
  const DeveloperMenuPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DeveloperMenuPage();
}

@TypedGoRoute<WelcomeViewRoute>(
  path: WelcomeViewRoute.path,
  name: WelcomeViewRoute.name,
)
class WelcomeViewRoute extends GoRouteData {
  static const path = '/welcomeView';
  static const name = 'welcomeView';
  const WelcomeViewRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const WelcomeView();
}
