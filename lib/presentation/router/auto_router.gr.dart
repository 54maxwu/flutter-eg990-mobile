// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/main_startup.dart';
import '../features/home/data/entity/game_platform_entity.dart';
import '../features/home/presentation/home_route.dart';
import '../features/home/presentation/state/home_store.dart';
import '../features/home/presentation/widgets/pageview/games_page.dart';
import '../features/login/presentation/login_route.dart';
import '../features/member/member_route.dart';
import '../features/promo/presentation/promo_route.dart';
import '../features/service/presentation/service_route.dart';
import '../features/sponsor/presentation/sponsor_route.dart';
import '../screens/main_screen.dart';

class Routes {
  static const String mainStartup = '/';
  static const all = <String>{
    mainStartup,
  };
}

class AutoRouter2 extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(
      Routes.mainStartup,
      page: MainStartup,
      generator: MainStartupRouter(),
    ),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    MainStartup: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => MainStartup(),
        settings: data,
        maintainState: true,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension AutoRouter2ExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushMainStartup() => push<dynamic>(Routes.mainStartup);
}

class MainStartupRoutes {
  static const String mainScreen = '/';
  static const all = <String>{
    mainScreen,
  };
}

class MainStartupRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(
      MainStartupRoutes.mainScreen,
      page: MainScreen,
      generator: MainScreenRouter(),
    ),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    MainScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MainScreen(),
        settings: data,
        maintainState: true,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension MainStartupRouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushMainScreen() =>
      push<dynamic>(MainStartupRoutes.mainScreen);
}

class MainScreenRoutes {
  static const String homeRoute = '/';
  static const String gamesPage = '/games-page';
  static const String loginRoute = '/login-route';
  static const String promoRoute = '/promo-route';
  static const String serviceRoute = '/service-route';
  static const String sponsorRoute = '/sponsor-route';
  static const String memberRoute = '/member-route';
  static const all = <String>{
    homeRoute,
    gamesPage,
    loginRoute,
    promoRoute,
    serviceRoute,
    sponsorRoute,
    memberRoute,
  };
}

class MainScreenRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(MainScreenRoutes.homeRoute, page: HomeRoute),
    RouteDef(MainScreenRoutes.gamesPage, page: GamesPage),
    RouteDef(MainScreenRoutes.loginRoute, page: LoginRoute),
    RouteDef(MainScreenRoutes.promoRoute, page: PromoRoute),
    RouteDef(MainScreenRoutes.serviceRoute, page: ServiceRoute),
    RouteDef(MainScreenRoutes.sponsorRoute, page: SponsorRoute),
    RouteDef(MainScreenRoutes.memberRoute, page: MemberRoute),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    HomeRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeRoute(),
        settings: data,
        maintainState: true,
      );
    },
    GamesPage: (data) {
      final args = data.getArgs<GamesPageArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => GamesPage(
          key: args.key,
          store: args.store,
          platform: args.platform,
        ),
        settings: data,
      );
    },
    LoginRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginRoute(),
        settings: data,
      );
    },
    PromoRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => PromoRoute(),
        settings: data,
      );
    },
    ServiceRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ServiceRoute(),
        settings: data,
      );
    },
    SponsorRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SponsorRoute(),
        settings: data,
      );
    },
    MemberRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MemberRoute(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension MainScreenRouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushHomeRoute() => push<dynamic>(MainScreenRoutes.homeRoute);

  Future<dynamic> pushGamesPage({
    Key key,
    @required HomeStore store,
    @required GamePlatformEntity platform,
  }) =>
      push<dynamic>(
        MainScreenRoutes.gamesPage,
        arguments:
            GamesPageArguments(key: key, store: store, platform: platform),
      );

  Future<dynamic> pushLoginRoute() =>
      push<dynamic>(MainScreenRoutes.loginRoute);

  Future<dynamic> pushPromoRoute() =>
      push<dynamic>(MainScreenRoutes.promoRoute);

  Future<dynamic> pushServiceRoute() =>
      push<dynamic>(MainScreenRoutes.serviceRoute);

  Future<dynamic> pushSponsorRoute() =>
      push<dynamic>(MainScreenRoutes.sponsorRoute);

  Future<dynamic> pushMemberRoute() =>
      push<dynamic>(MainScreenRoutes.memberRoute);
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// GamesPage arguments holder class
class GamesPageArguments {
  final Key key;
  final HomeStore store;
  final GamePlatformEntity platform;
  GamesPageArguments({this.key, @required this.store, @required this.platform});
}
