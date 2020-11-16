import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_eg990_mobile/core/internal/global.dart';
import 'package:flutter_eg990_mobile/mylogger.dart';
import 'package:vnum/vnum.dart';

import 'auto_router.gr.dart';
import 'route_enum.dart';
import 'route_info.dart';

export 'route_enum.dart';

part 'route_page_ext.dart';

const ROUTE_POSTFIX_SIDE = '-side';

@VnumDefinition
class RoutePage extends Vnum<RouteInfo> {
  /// Case Definition
  static const RoutePage home = const RoutePage.define(RouteInfo(
    id: RouteEnum.HOME,
    route: FeatureScreenRoutes.homeRoute,
    bottomNavIndex: 0,
    hideAppbarActions: false,
  ));

  static const RoutePage login = const RoutePage.define(RouteInfo(
    id: RouteEnum.LOGIN,
    route: FeatureScreenRoutes.loginRoute,
    bottomNavIndex: 4,
  ));

  static const RoutePage register = const RoutePage.define(RouteInfo(
    id: RouteEnum.REGISTER,
    route: FeatureScreenRoutes.registerRoute,
    webPageName: ('/register'),
    hideLanguageOption: true,
  ));

  static const RoutePage promo = const RoutePage.define(RouteInfo(
    id: RouteEnum.PROMO,
    route: FeatureScreenRoutes.promoRoute,
    webPageName: ('/promo/0'),
    bottomNavIndex: 2,
    hideAppbarActions: false,
  ));

  static const RoutePage service = const RoutePage.define(RouteInfo(
    id: RouteEnum.SERVICE,
    route: FeatureScreenRoutes.serviceRoute,
    webPageName: ('/customer_service'),
    bottomNavIndex: 3,
    hideAppbarActions: false,
    hideLanguageOption: true,
  ));

  static const RoutePage serviceWeb = const RoutePage.define(RouteInfo(
    id: RouteEnum.SERVICE_WEB,
    route: FeatureScreenRoutes.serviceWebRoute,
    root: FeatureScreenRoutes.serviceRoute,
    bottomNavIndex: 3,
    hideAppbarActions: false,
    hideLanguageOption: true,
  ));

  static const RoutePage member = const RoutePage.define(RouteInfo(
    id: RouteEnum.MEMBER,
    route: FeatureScreenRoutes.memberRoute,
    webPageName: ('/myaccount'),
    bottomNavIndex: 4,
    isUserOnly: true,
  ));

  static const RoutePage depositFeature = const RoutePage.define(RouteInfo(
    id: RouteEnum.DEPOSIT,
    route: FeatureScreenRoutes.depositFeatureRoute,
    webPageName: ('/deposit'),
    bottomNavIndex: 1,
    isUserOnly: true,
  ));

  static const RoutePage deposit = const RoutePage.define(RouteInfo(
    id: RouteEnum.DEPOSIT,
    route: FeatureScreenRoutes.depositRoute,
    root: FeatureScreenRoutes.memberRoute,
    isUserOnly: true,
  ));

  static const RoutePage depositWeb = const RoutePage.define(RouteInfo(
    id: RouteEnum.DEPOSIT,
    route: FeatureScreenRoutes.depositWebRoute,
    root: FeatureScreenRoutes.depositRoute,
    hideLanguageOption: true,
  ));

  static const RoutePage transfer = const RoutePage.define(RouteInfo(
    id: RouteEnum.TRANSFER,
    route: FeatureScreenRoutes.transferRoute,
    root: FeatureScreenRoutes.memberRoute,
    webPageName: ('/transfer'),
    isUserOnly: true,
  ));

  static const RoutePage bankcard = const RoutePage.define(RouteInfo(
    id: RouteEnum.BANKCARD,
    route: FeatureScreenRoutes.bankcardRoute,
    root: FeatureScreenRoutes.memberRoute,
    webPageName: ('/bankcard'),
    isUserOnly: true,
  ));

  static const RoutePage withdraw = const RoutePage.define(RouteInfo(
    id: RouteEnum.WITHDRAW,
    route: FeatureScreenRoutes.withdrawRoute,
    routeArg: BankcardRouteArguments(withdraw: true),
    root: FeatureScreenRoutes.memberRoute,
    webPageName: ('/withdrawal'),
    isUserOnly: true,
  ));

  static const RoutePage balance = const RoutePage.define(RouteInfo(
    id: RouteEnum.BALANCE,
    route: FeatureScreenRoutes.balanceRoute,
    root: FeatureScreenRoutes.memberRoute,
    webPageName: ('/platform'),
    isUserOnly: true,
  ));

  static const RoutePage wallet = const RoutePage.define(RouteInfo(
    id: RouteEnum.WALLET,
    route: FeatureScreenRoutes.walletRoute,
    root: FeatureScreenRoutes.memberRoute,
    webPageName: ('/wallet'),
    isUserOnly: true,
  ));

  static const RoutePage message = const RoutePage.define(RouteInfo(
    id: RouteEnum.MESSAGE,
    route: FeatureScreenRoutes.messageRoute,
    root: FeatureScreenRoutes.memberRoute,
    webPageName: ('/station'),
    hideLanguageOption: true,
    isUserOnly: true,
  ));

  static const RoutePage center = const RoutePage.define(RouteInfo(
    id: RouteEnum.CENTER,
    route: FeatureScreenRoutes.centerRoute,
    root: FeatureScreenRoutes.memberRoute,
    webPageName: ('/center'),
    hideLanguageOption: true,
    isUserOnly: true,
  ));

  static const RoutePage centerPassword = const RoutePage.define(RouteInfo(
    id: RouteEnum.PASSWORD,
    route: FeatureScreenRoutes.centerPasswordRoute,
    root: FeatureScreenRoutes.centerRoute,
    hideLanguageOption: true,
  ));

  static const RoutePage centerWeb = const RoutePage.define(RouteInfo(
    id: RouteEnum.CENTER,
    route: FeatureScreenRoutes.centerWebRoute,
    root: FeatureScreenRoutes.centerRoute,
    hideLanguageOption: true,
  ));

  static const RoutePage transaction = const RoutePage.define(RouteInfo(
    id: RouteEnum.TRANSFER_RECORD,
    route: FeatureScreenRoutes.transactionRoute,
    root: FeatureScreenRoutes.memberRoute,
    webPageName: ('/transfer_record'),
    isUserOnly: true,
  ));

  static const RoutePage betRecord = const RoutePage.define(RouteInfo(
    id: RouteEnum.BETS,
    route: FeatureScreenRoutes.betRecordRoute,
    root: FeatureScreenRoutes.memberRoute,
    webPageName: ('/bet_history'),
    isUserOnly: true,
  ));

  static const RoutePage deals = const RoutePage.define(RouteInfo(
    id: RouteEnum.DEALS,
    route: FeatureScreenRoutes.dealsRoute,
    root: FeatureScreenRoutes.memberRoute,
    webPageName: ('/transaction'),
    isUserOnly: true,
  ));

  static const RoutePage rollback = const RoutePage.define(RouteInfo(
    id: RouteEnum.ROLLBACK,
    route: FeatureScreenRoutes.rollbackRoute,
    root: FeatureScreenRoutes.memberRoute,
    webPageName: ('/bet_rollback'),
    isUserOnly: true,
  ));

  static const RoutePage noticeBoard = const RoutePage.define(RouteInfo(
    id: RouteEnum.NOTICE,
    route: FeatureScreenRoutes.noticeRoute,
    root: FeatureScreenRoutes.memberRoute,
    webPageName: ('/remind'),
    bottomNavIndex: 4,
    isUserOnly: true,
  ));

  static const RoutePage vipLevel = const RoutePage.define(RouteInfo(
    id: RouteEnum.VIP,
    route: FeatureScreenRoutes.vipLevelRoute,
    root: FeatureScreenRoutes.memberRoute,
    bottomNavIndex: 4,
  ));

  ///
  /// agent route
  ///
  static const RoutePage agentFeatureOld = const RoutePage.define(RouteInfo(
    id: RouteEnum.AGENT,
    route: FeatureScreenRoutes.agentFeatureRoute,
    bottomNavIndex: 1,
    hideLanguageOption: true,
    isUserOnly: true,
  ));

  static const RoutePage agentOld = const RoutePage.define(RouteInfo(
    id: RouteEnum.AGENT,
    route: FeatureScreenRoutes.agentRoute,
    root: FeatureScreenRoutes.memberRoute,
    hideLanguageOption: true,
    isUserOnly: true,
  ));
  //
  // static const RoutePage agentLogin = const RoutePage.define(RouteInfo(
  //   id: RouteEnum.AGENT_LOGIN,
  //   route: FeatureScreenRoutes.agentLoginRoute,
  //   bottomNavIndex: 5,
  //   hideAppbarActions: true,
  // ));
  //
  // static const RoutePage agentRegister = const RoutePage.define(RouteInfo(
  //   id: RouteEnum.AGENT_REGISTER,
  //   route: FeatureScreenRoutes.agentRegisterRoute,
  //   root: FeatureScreenRoutes.agentLoginRoute,,
  //   showDrawer: false,
  //   hideAppbarActions: true,
  // ));
  //
  // static const RoutePage agent = const RoutePage.define(RouteInfo(
  //   id: RouteEnum.AGENT,
  //   route: FeatureScreenRoutes.agentRoute,
  //   showDrawer: false,
  //   hideAppbarActions: true,
  //   bottomNavIndex: 10,
  // ));

  ///
  /// side menu route
  /// * important:
  /// change route name if duplicate
  ///
  static const RoutePage sideStore = const RoutePage.define(RouteInfo(
    id: RouteEnum.STORE,
    route: FeatureScreenRoutes.storeRoute,
    webPageName: ('/mall/0'),
    showDrawer: true,
    hideLanguageOption: true,
    isUserOnly: true,
    bottomNavIndex: 5,
  ));

  static const RoutePage sideRoller = const RoutePage.define(RouteInfo(
    id: RouteEnum.ROLLER,
    route: FeatureScreenRoutes.rollerRoute,
    webPageName: ('/turntable'),
    showDrawer: true,
    hideLanguageOption: true,
    isUserOnly: true,
  ));

  static const RoutePage sideDownload = const RoutePage.define(RouteInfo(
    id: RouteEnum.DOWNLOAD,
    route: FeatureScreenRoutes.downloadAreaRoute,
    showDrawer: true,
    hideLanguageOption: true,
    bottomNavIndex: 5,
  ));

  static const RoutePage sideNoticeBoard = const RoutePage.define(RouteInfo(
    id: RouteEnum.NOTICE,
    route: '${FeatureScreenRoutes.noticeRoute}$ROUTE_POSTFIX_SIDE',
    showDrawer: true,
    bottomNavIndex: 5,
  ));

  static const RoutePage sideTutorial = const RoutePage.define(RouteInfo(
    id: RouteEnum.TUTORIAL,
    route: '${FeatureScreenRoutes.moreRoute}$ROUTE_POSTFIX_SIDE-newbie',
    routeArg: const WebRouteArguments(
      startUrl: '${Global.CURRENT_BASE}newbie',
      hideHtmlBars: true,
    ),
    webPageName: ('/newbie'),
    showDrawer: true,
    hideLanguageOption: true,
    bottomNavIndex: 5,
  ));

  static const RoutePage sideVipLevel = const RoutePage.define(RouteInfo(
    id: RouteEnum.VIP,
    route: '${FeatureScreenRoutes.vipLevelRoute}$ROUTE_POSTFIX_SIDE',
    showDrawer: true,
    bottomNavIndex: 5,
  ));

  static const RoutePage sideWallet = const RoutePage.define(RouteInfo(
    id: RouteEnum.WALLET,
    route: '${FeatureScreenRoutes.walletRoute}$ROUTE_POSTFIX_SIDE',
    showDrawer: true,
    isUserOnly: true,
    bottomNavIndex: 5,
  ));

  ///
  /// more route
  /// * important:
  /// change route name if duplicate
  ///
  static const RoutePage moreAgentAbout = const RoutePage.define(RouteInfo(
    id: RouteEnum.AGENT_ABOUT,
    route: '${FeatureScreenRoutes.moreRoute}-agent0',
    routeArg: const WebRouteArguments(
      startUrl: '${Global.CURRENT_BASE}agentPage',
      hideHtmlBars: true,
    ),
    hideLanguageOption: true,
    bottomNavIndex: 5,
  ));

  static const RoutePage moreTutorial = const RoutePage.define(RouteInfo(
    id: RouteEnum.TUTORIAL,
    route: '${FeatureScreenRoutes.moreRoute}-newbie',
    routeArg: const WebRouteArguments(
      startUrl: '${Global.CURRENT_BASE}newbie',
      hideHtmlBars: true,
    ),
    hideLanguageOption: true,
    bottomNavIndex: 5,
  ));

  ///
  /// test route
  ///
  static const RoutePage template = const RoutePage.define(RouteInfo(
    id: RouteEnum.TEMPLATE,
    route: FeatureScreenRoutes.templateRoute,
    hideLanguageOption: true,
    bottomNavIndex: 5,
  ));

  static const RoutePage testArea = const RoutePage.define(RouteInfo(
    id: RouteEnum.TEST_UI,
    route: FeatureScreenRoutes.testAreaRoute,
    hideLanguageOption: true,
    bottomNavIndex: 5,
  ));

  /// Used for defining cases
  const RoutePage.define(RouteInfo fromValue) : super.define(fromValue);

  /// Used for loading enum using value
  factory RoutePage(RouteInfo value) => Vnum.fromValue(value, RoutePage);

  /// Iterating cases
  /// All value needs to be constant for this to work
  static List<Vnum> get listAll => Vnum.allCasesFor(RoutePage);

  String get pageName => value.route;

  RouteEnum get pageId => value.id;

  String get pageTitle => value.id.title;

  String get pageRoot => value.root;

  bool get isUserOnly => value.isUserOnly;

  bool get hideBarAction => value.hideAppbarActions;

  int get navIndex => value.bottomNavIndex;

  bool get hasBottomNav => value.bottomNavIndex != -1;
}
