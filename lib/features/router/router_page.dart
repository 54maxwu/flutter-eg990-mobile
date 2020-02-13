part of 'router_navigate.dart';

class RouteInfo {
  final String route;
  final String title;
  final String parentRoute;
  final bool isFeature;
  final bool hideAppbarActions;

  RouteInfo(
      {@required this.route,
      @required this.title,
      this.parentRoute = Router.homeRoute,
      this.isFeature = false,
      this.hideAppbarActions = false});
}

enum RouterPage {
  HomeRoute,
  LoginRoute,
}

extension PagesExtension on RouterPage {
  RouteInfo get info {
    switch (this) {
      case RouterPage.HomeRoute:
        return RouteInfo(
            route: Router.homeRoute,
            title: localeStr.pageTitleHome,
            isFeature: true);
      case RouterPage.LoginRoute:
        return RouteInfo(
            route: Router.loginRoute,
            title: localeStr.pageTitleLogin,
            hideAppbarActions: true);
      default:
        throw UnknownConditionException();
    }
  }
}

extension PagesNameExtension on String {
  RouteInfo get toRouteInfo {
    switch (this) {
      case Router.loginRoute:
        return RouterPage.HomeRoute.info;
      case Router.loginRoute:
        return RouterPage.LoginRoute.info;
      default:
        throw UnknownConditionException();
    }
  }
}
