import 'package:flutter_ty_mobile/core/error/exceptions.dart'
    show UnknownConditionException;
import 'package:flutter_ty_mobile/core/internal/local_strings.dart'
    show localeStr;

import 'route_info.dart';
import 'router.gr.dart';

import 'package:vnum/vnum.dart';

@VnumDefinition
class RoutePage extends Vnum<RouteInfo> {
  /// Case Definition
  static RoutePage home = RoutePage.define(RouteInfo(
    route: Routes.homeRoute,
//    title: localeStr.pageTitleHome,
    title: '',
    isFeature: true,
    bottomNavIndex: 0,
    hideAppbarActions: false,
  ));

  static RoutePage login = RoutePage.define(RouteInfo(
    route: Routes.loginRoute,
    title: localeStr.pageTitleLogin,
  ));

  static RoutePage register = RoutePage.define(RouteInfo(
    route: Routes.registerRoute,
    title: localeStr.pageTitleRegister,
  ));

  static RoutePage promo = RoutePage.define(RouteInfo(
    route: Routes.promoRoute,
    title: localeStr.pageTitlePromo,
    isFeature: true,
    bottomNavIndex: 2,
    hideAppbarActions: false,
  ));

  static RoutePage service = RoutePage.define(RouteInfo(
    route: Routes.serviceRoute,
    title: localeStr.pageTitleService,
    isFeature: true,
    bottomNavIndex: 3,
    hideAppbarActions: false,
  ));

  static RoutePage member = RoutePage.define(RouteInfo(
    route: Routes.memberRoute,
    title: localeStr.pageTitleMember,
    isFeature: true,
    bottomNavIndex: 4,
  ));

  static RoutePage deposit = RoutePage.define(RouteInfo(
    route: Routes.depositRoute,
    title: localeStr.pageTitleDeposit,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage depositWeb = RoutePage.define(RouteInfo(
    route: Routes.depositWebPage,
    title: localeStr.pageTitleDeposit,
    parentRoute: Routes.depositRoute,
  ));

  static RoutePage transfer = RoutePage.define(RouteInfo(
    route: Routes.transferRoute,
    title: localeStr.pageTitleMemberTransfer,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage bankcard = RoutePage.define(RouteInfo(
    route: Routes.bankcardRoute,
    title: localeStr.pageTitleMemberCard,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage withdraw = RoutePage.define(RouteInfo(
    route: Routes.bankcardRoute,
    title: localeStr.pageTitleMemberWithdraw,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage balance = RoutePage.define(RouteInfo(
    route: Routes.balanceRoute,
    title: localeStr.pageTitleMemberBalance,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage wallet = RoutePage.define(RouteInfo(
    route: Routes.walletRoute,
    title: localeStr.pageTitleMemberWallet,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage message = RoutePage.define(RouteInfo(
    route: Routes.messageRoute,
    title: localeStr.pageTitleMemberMessage,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage center = RoutePage.define(RouteInfo(
    route: Routes.centerRoute,
    title: localeStr.pageTitleMemberCenter,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage centerPassword = RoutePage.define(RouteInfo(
    route: Routes.centerPasswordPage,
    title: localeStr.pageTitleMemberPassword,
    parentRoute: Routes.centerRoute,
  ));

  static RoutePage centerWeb = RoutePage.define(RouteInfo(
    route: Routes.centerWebPage,
    title: localeStr.pageTitleMemberCenter,
    parentRoute: Routes.centerRoute,
  ));

  static RoutePage transaction = RoutePage.define(RouteInfo(
    route: Routes.transactionRoute,
    title: localeStr.pageTitleMemberTransaction,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage betRecord = RoutePage.define(RouteInfo(
    route: Routes.betRecordRoute,
    title: localeStr.pageTitleMemberBets,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage deals = RoutePage.define(RouteInfo(
    route: Routes.dealsRoute,
    title: localeStr.pageTitleMemberDeals,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage flows = RoutePage.define(RouteInfo(
    route: Routes.flowsRoute,
    title: localeStr.pageTitleMemberFlow,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage agentFeature = RoutePage.define(RouteInfo(
    route: Routes.agentRoute,
    title: localeStr.pageTitleMemberAgent,
    parentRoute: Routes.homeRoute,
    isFeature: true,
    bottomNavIndex: 1,
  ));

  static RoutePage agent = RoutePage.define(RouteInfo(
    route: Routes.agentRoute,
    title: localeStr.pageTitleMemberAgent,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage moreWeb = RoutePage.define(RouteInfo(
    route: Routes.moreWebPage,
    title: '',
    parentRoute: Routes.homeRoute,
    showDrawer: true,
  ));

  /// side menu route
  static RoutePage downloadArea = RoutePage.define(RouteInfo(
    route: Routes.downloadAreaRoute,
    title: localeStr.pageTitleDownload,
    showDrawer: true,
  ));

  static RoutePage noticeBoard = RoutePage.define(RouteInfo(
    route: Routes.noticeRoute,
    title: localeStr.pageTitleNotice,
    showDrawer: true,
  ));

  static RoutePage sideWallet = RoutePage.define(RouteInfo(
    route: Routes.walletRoute,
    title: localeStr.pageTitleMemberWallet,
    showDrawer: true,
  ));

  static RoutePage vipLevel = RoutePage.define(RouteInfo(
    route: Routes.levelRoute,
    title: localeStr.pageTitleRank,
    showDrawer: true,
  ));

  static RoutePage pointStore = RoutePage.define(RouteInfo(
    route: Routes.storeRoute,
    title: localeStr.pageTitleStore,
    showDrawer: true,
  ));

  static RoutePage roller = RoutePage.define(RouteInfo(
    route: Routes.rollerRoute,
    title: localeStr.pageTitleRoller,
    showDrawer: true,
  ));

  /// test route
  static RoutePage template = RoutePage.define(RouteInfo(
    route: Routes.templateRoute,
    title: 'Test Mobx',
  ));

  static RoutePage testArea = RoutePage.define(RouteInfo(
    route: Routes.testAreaRoute,
    title: 'Test Widget',
  ));

  /// Used for defining cases
  const RoutePage.define(RouteInfo fromValue) : super.define(fromValue);

  /// Used for loading enum using value
  factory RoutePage(RouteInfo value) => Vnum.fromValue(value, RoutePage);

  /// Iterating cases
  List<Vnum> get listAll => Vnum.allCasesFor(RoutePage);

  /// (optional) Extend your Vnums
  //RouteInfo example() {
  //  switch(value) {
  //    default:
  //      return RoutePage.example.value;
  //  };
  //}

  String get page => value.route;
  String get pageTitle => value.title;
  String get pageRoot => value.parentRoute;
  bool get isFeature => value.isFeature;
  bool get hideBarAction => value.hideAppbarActions;
  int get navIndex => value.bottomNavIndex;
}

extension PagesNameExtension on String {
  /// Get route info by router name which generates in [Router.gr.dart]
  RoutePage get toRoutePage {
    print("asking route by name: $this");
    switch (this) {
      case '/':
      case Routes.homeRoute:
        return RoutePage.home;
      case Routes.loginRoute:
        return RoutePage.login;
      case Routes.agentRoute:
        return RoutePage.agent;
      case Routes.depositRoute:
        return RoutePage.deposit;
      case Routes.promoRoute:
        return RoutePage.promo;
      case Routes.serviceRoute:
        return RoutePage.service;
      case Routes.memberRoute:
        return RoutePage.member;
      case Routes.centerRoute:
        return RoutePage.center;
      case Routes.templateRoute:
        return RoutePage.template;
      case Routes.testAreaRoute:
        return RoutePage.testArea;
      default:
        throw UnknownConditionException();
    }
  }
}
