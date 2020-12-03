// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../domain/sector/home/platform/game_platform_entity.dart';
import '../../domain/sector/promo/promo_entity.dart';
import '../core/main_startup.dart';
import '../features/about_us/about_route.dart';
import '../features/home/home_route.dart';
import '../features/home/state/home_store.dart';
import '../features/home/widgets/pageview/games_page.dart';
import '../features/login/login_route.dart';
import '../features/member/member_route.dart';
import '../features/member_features/bet_record/bet_record_route.dart';
import '../features/member_features/deposit/deposit_route.dart';
import '../features/member_features/transfer/transfer_route.dart';
import '../features/promo/promo_route.dart';
import '../features/promo/widgets/promo_detail_page.dart';
import '../features/service/service_route.dart';
import '../features/sponsor/sponsor_route.dart';
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
  static const String promoDetailPage = '/promo-detail-page';
  static const String serviceRoute = '/service-route';
  static const String sponsorRoute = '/sponsor-route';
  static const String aboutRoute = '/about-route';
  static const String memberRoute = '/member-route';
  static const String depositRoute = '/deposit-route';
  static const String transferRoute = '/transfer-route';
  static const String betRecordRoute = '/bet-record-route';
  static const all = <String>{
    homeRoute,
    gamesPage,
    loginRoute,
    promoRoute,
    promoDetailPage,
    serviceRoute,
    sponsorRoute,
    aboutRoute,
    memberRoute,
    depositRoute,
    transferRoute,
    betRecordRoute,
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
    RouteDef(MainScreenRoutes.promoDetailPage, page: PromoDetailPage),
    RouteDef(MainScreenRoutes.serviceRoute, page: ServiceRoute),
    RouteDef(MainScreenRoutes.sponsorRoute, page: SponsorRoute),
    RouteDef(MainScreenRoutes.aboutRoute, page: AboutRoute),
    RouteDef(MainScreenRoutes.memberRoute, page: MemberRoute),
    RouteDef(MainScreenRoutes.depositRoute, page: DepositRoute),
    RouteDef(MainScreenRoutes.transferRoute, page: TransferRoute),
    RouteDef(MainScreenRoutes.betRecordRoute, page: BetRecordRoute),
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
    PromoDetailPage: (data) {
      final args = data.getArgs<PromoDetailPageArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PromoDetailPage(args.promo),
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
    AboutRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AboutRoute(),
        settings: data,
      );
    },
    MemberRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MemberRoute(),
        settings: data,
      );
    },
    DepositRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => DepositRoute(),
        settings: data,
      );
    },
    TransferRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => TransferRoute(),
        settings: data,
      );
    },
    BetRecordRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => BetRecordRoute(),
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

  Future<dynamic> pushPromoDetailPage({
    @required PromoEntity promo,
  }) =>
      push<dynamic>(
        MainScreenRoutes.promoDetailPage,
        arguments: PromoDetailPageArguments(promo: promo),
      );

  Future<dynamic> pushServiceRoute() =>
      push<dynamic>(MainScreenRoutes.serviceRoute);

  Future<dynamic> pushSponsorRoute() =>
      push<dynamic>(MainScreenRoutes.sponsorRoute);

  Future<dynamic> pushAboutRoute() =>
      push<dynamic>(MainScreenRoutes.aboutRoute);

  Future<dynamic> pushMemberRoute() =>
      push<dynamic>(MainScreenRoutes.memberRoute);

  Future<dynamic> pushDepositRoute() =>
      push<dynamic>(MainScreenRoutes.depositRoute);

  Future<dynamic> pushTransferRoute() =>
      push<dynamic>(MainScreenRoutes.transferRoute);

  Future<dynamic> pushBetRecordRoute() =>
      push<dynamic>(MainScreenRoutes.betRecordRoute);
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

/// PromoDetailPage arguments holder class
class PromoDetailPageArguments {
  final PromoEntity promo;
  PromoDetailPageArguments({@required this.promo});
}
