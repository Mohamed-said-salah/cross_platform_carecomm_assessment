import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType =>
      RouteType.cupertino(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        // home
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: ProductDetailsRoute.page),
      ];

  @override
  List<AutoRouteGuard> get guards => [];
}
