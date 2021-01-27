// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/internal/global.dart';

import '../main_startup.dart';
import '../routes/home/presentation/home_route.dart';
import '../routes/member/presentation/member_route.dart';
import '../routes/subfeatures/accountcenter/presentation/center_route.dart';
import '../routes/subfeatures/accountcenter/presentation/state/center_store.dart';
import '../routes/subfeatures/accountcenter/presentation/widgets/center_display_account_pwd.dart';
import '../routes/subfeatures/balance/presentation/balance_route.dart';
import '../routes/subfeatures/bankcard/presentation/bankcard_route.dart';
import '../routes/subfeatures/betrecord/presentation/bet_record_route.dart';
import '../routes/subfeatures/deals/presentation/deals_route.dart';
import '../routes/subfeatures/deposit/presentation/deposit_route.dart';
import '../routes/subfeatures/downloadarea/download_area_route.dart';
import '../routes/subfeatures/message/presentation/message_route.dart';
import '../routes/subfeatures/notice/presentation/notice_route.dart';
import '../routes/subfeatures/promo/presentation/promo_route.dart';
import '../routes/subfeatures/rollback/presentation/rollback_route.dart';
import '../routes/subfeatures/service/presentation/service_route.dart';
import '../routes/subfeatures/store/presentation/store_route.dart';
import '../routes/subfeatures/transactions/presentation/transaction_route.dart';
import '../routes/subfeatures/transfer/presentation/transfer_route.dart';
import '../routes/subfeatures/viplevel/presentation/vip_level_route.dart';
import '../routes/subfeatures/wallet/presentation/wallet_route.dart';
import '../routes/web/web_route.dart';
import '../screen/feature_screen.dart';
import '../screen/web_game_screen.dart';
import '../user/login/presentation/login_route.dart';
import '../user/register/presentation/register_route.dart';

class Routes {
  static const String mainStartup = '/';
  static const all = <String>{
    mainStartup,
  };
}

class AutoRouter extends RouterBase {
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

extension AutoRouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushMainStartup() => push<dynamic>(Routes.mainStartup);
}

class MainStartupRoutes {
  static const String featureScreen = '/';
  static const String webGameScreen = '/game-web';
  static const all = <String>{
    featureScreen,
    webGameScreen,
  };
}

class MainStartupRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(
      MainStartupRoutes.featureScreen,
      page: FeatureScreen,
      generator: FeatureScreenRouter(),
    ),
    RouteDef(MainStartupRoutes.webGameScreen, page: WebGameScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    FeatureScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => FeatureScreen(),
        settings: data,
        maintainState: true,
      );
    },
    WebGameScreen: (data) {
      final args = data.getArgs<WebGameScreenArguments>(
        orElse: () => WebGameScreenArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => WebGameScreen(startUrl: args.startUrl),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension MainStartupRouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushFeatureScreen() =>
      push<dynamic>(MainStartupRoutes.featureScreen);

  Future<dynamic> pushWebGameScreen({
    String startUrl = Global.CURRENT_BASE,
  }) =>
      push<dynamic>(
        MainStartupRoutes.webGameScreen,
        arguments: WebGameScreenArguments(startUrl: startUrl),
      );
}

class FeatureScreenRoutes {
  static const String homeRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String serviceRoute = '/service';
  static const String webRoute = '/web';
  static const String serviceWebRoute = '/service-web';
  static const String memberRoute = '/member';
  static const String depositRoute = '/deposit';
  static const String depositWebRoute = '/deposit-web';
  static const String transferRoute = '/transfer';
  static const String bankcardRoute = '/bankcard';
  static const String withdrawRoute = '/withdraw';
  static const String balanceRoute = '/balance';
  static const String walletRoute = '/wallet';
  static const String messageRoute = '/message';
  static const String centerRoute = '/center';
  static const String centerPasswordRoute = '/center-pwd';
  static const String centerWebRoute = '/center-web';
  static const String transactionRoute = '/transaction';
  static const String betRecordRoute = '/bets';
  static const String dealsRoute = '/deals';
  static const String rollbackRoute = '/rollback';
  static const String promoRoute = '/promo';
  static const String depositFeatureRoute = '/deposit-nav';
  static const String downloadAreaRoute = '/download';
  static const String tutorialWebRoute = '/tutorial-web';
  static const String noticeRoute = '/notice';
  static const String storeRoute = '/store';
  static const String vipLevelRoute = '/level';
  static const all = <String>{
    homeRoute,
    loginRoute,
    registerRoute,
    serviceRoute,
    webRoute,
    serviceWebRoute,
    memberRoute,
    depositRoute,
    depositWebRoute,
    transferRoute,
    bankcardRoute,
    withdrawRoute,
    balanceRoute,
    walletRoute,
    messageRoute,
    centerRoute,
    centerPasswordRoute,
    centerWebRoute,
    transactionRoute,
    betRecordRoute,
    dealsRoute,
    rollbackRoute,
    promoRoute,
    depositFeatureRoute,
    downloadAreaRoute,
    tutorialWebRoute,
    noticeRoute,
    storeRoute,
    vipLevelRoute,
  };
}

class FeatureScreenRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(FeatureScreenRoutes.homeRoute, page: HomeRoute),
    RouteDef(FeatureScreenRoutes.loginRoute, page: LoginRoute),
    RouteDef(FeatureScreenRoutes.registerRoute, page: RegisterRoute),
    RouteDef(FeatureScreenRoutes.serviceRoute, page: ServiceRoute),
    RouteDef(FeatureScreenRoutes.webRoute, page: WebRoute),
    RouteDef(FeatureScreenRoutes.serviceWebRoute, page: WebRoute),
    RouteDef(FeatureScreenRoutes.memberRoute, page: MemberRoute),
    RouteDef(FeatureScreenRoutes.depositRoute, page: DepositRoute),
    RouteDef(FeatureScreenRoutes.depositWebRoute, page: WebRoute),
    RouteDef(FeatureScreenRoutes.transferRoute, page: TransferRoute),
    RouteDef(FeatureScreenRoutes.bankcardRoute, page: BankcardRoute),
    RouteDef(FeatureScreenRoutes.withdrawRoute, page: BankcardRoute),
    RouteDef(FeatureScreenRoutes.balanceRoute, page: BalanceRoute),
    RouteDef(FeatureScreenRoutes.walletRoute, page: WalletRoute),
    RouteDef(FeatureScreenRoutes.messageRoute, page: MessageRoute),
    RouteDef(FeatureScreenRoutes.centerRoute, page: CenterRoute),
    RouteDef(FeatureScreenRoutes.centerPasswordRoute,
        page: CenterDisplayAccountPassword),
    RouteDef(FeatureScreenRoutes.centerWebRoute, page: WebRoute),
    RouteDef(FeatureScreenRoutes.transactionRoute, page: TransactionRoute),
    RouteDef(FeatureScreenRoutes.betRecordRoute, page: BetRecordRoute),
    RouteDef(FeatureScreenRoutes.dealsRoute, page: DealsRoute),
    RouteDef(FeatureScreenRoutes.rollbackRoute, page: RollbackRoute),
    RouteDef(FeatureScreenRoutes.promoRoute, page: PromoRoute),
    RouteDef(FeatureScreenRoutes.depositFeatureRoute, page: DepositRoute),
    RouteDef(FeatureScreenRoutes.downloadAreaRoute, page: DownloadAreaRoute),
    RouteDef(FeatureScreenRoutes.tutorialWebRoute, page: WebRoute),
    RouteDef(FeatureScreenRoutes.noticeRoute, page: NoticeRoute),
    RouteDef(FeatureScreenRoutes.storeRoute, page: StoreRoute),
    RouteDef(FeatureScreenRoutes.vipLevelRoute, page: VipLevelRoute),
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
    LoginRoute: (data) {
      final args = data.getArgs<LoginRouteArguments>(
        orElse: () => LoginRouteArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginRoute(
          returnHomeAfterLogin: args.returnHomeAfterLogin,
          isDialog: args.isDialog,
        ),
        settings: data,
      );
    },
    RegisterRoute: (data) {
      final args = data.getArgs<RegisterRouteArguments>(
        orElse: () => RegisterRouteArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisterRoute(isDialog: args.isDialog),
        settings: data,
      );
    },
    ServiceRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ServiceRoute(),
        settings: data,
      );
    },
    WebRoute: (data) {
      final args = data.getArgs<WebRouteArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => WebRoute(
          startUrl: args.startUrl,
          showUrl: args.showUrl,
          hideHtmlBars: args.hideHtmlBars,
        ),
        settings: data,
      );
    },
    MemberRoute: (data) {
      final args = data.getArgs<MemberRouteArguments>(
        orElse: () => MemberRouteArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => MemberRoute(key: args.key),
        settings: data,
        maintainState: true,
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
    BankcardRoute: (data) {
      final args = data.getArgs<BankcardRouteArguments>(
        orElse: () => BankcardRouteArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => BankcardRoute(withdraw: args.withdraw),
        settings: data,
      );
    },
    BalanceRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => BalanceRoute(),
        settings: data,
      );
    },
    WalletRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => WalletRoute(),
        settings: data,
      );
    },
    MessageRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MessageRoute(),
        settings: data,
      );
    },
    CenterRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CenterRoute(),
        settings: data,
      );
    },
    CenterDisplayAccountPassword: (data) {
      final args =
          data.getArgs<CenterDisplayAccountPasswordArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => CenterDisplayAccountPassword(store: args.store),
        settings: data,
      );
    },
    TransactionRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => TransactionRoute(),
        settings: data,
      );
    },
    BetRecordRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => BetRecordRoute(),
        settings: data,
      );
    },
    DealsRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => DealsRoute(),
        settings: data,
      );
    },
    RollbackRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RollbackRoute(),
        settings: data,
      );
    },
    PromoRoute: (data) {
      final args = data.getArgs<PromoRouteArguments>(
        orElse: () => PromoRouteArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => PromoRoute(openPromoId: args.openPromoId),
        settings: data,
      );
    },
    DownloadAreaRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => DownloadAreaRoute(),
        settings: data,
      );
    },
    NoticeRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => NoticeRoute(),
        settings: data,
      );
    },
    StoreRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StoreRoute(),
        settings: data,
      );
    },
    VipLevelRoute: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => VipLevelRoute(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension FeatureScreenRouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushHomeRoute() =>
      push<dynamic>(FeatureScreenRoutes.homeRoute);

  Future<dynamic> pushLoginRoute({
    bool returnHomeAfterLogin = false,
    bool isDialog = false,
  }) =>
      push<dynamic>(
        FeatureScreenRoutes.loginRoute,
        arguments: LoginRouteArguments(
            returnHomeAfterLogin: returnHomeAfterLogin, isDialog: isDialog),
      );

  Future<dynamic> pushRegisterRoute({
    bool isDialog = false,
  }) =>
      push<dynamic>(
        FeatureScreenRoutes.registerRoute,
        arguments: RegisterRouteArguments(isDialog: isDialog),
      );

  Future<dynamic> pushServiceRoute() =>
      push<dynamic>(FeatureScreenRoutes.serviceRoute);

  Future<dynamic> pushWebRoute({
    @required String startUrl,
    bool showUrl = false,
    bool hideHtmlBars = false,
  }) =>
      push<dynamic>(
        FeatureScreenRoutes.webRoute,
        arguments: WebRouteArguments(
            startUrl: startUrl, showUrl: showUrl, hideHtmlBars: hideHtmlBars),
      );

  Future<dynamic> pushServiceWebRoute({
    @required String startUrl,
    bool showUrl = false,
    bool hideHtmlBars = false,
  }) =>
      push<dynamic>(
        FeatureScreenRoutes.serviceWebRoute,
        arguments: WebRouteArguments(
            startUrl: startUrl, showUrl: showUrl, hideHtmlBars: hideHtmlBars),
      );

  Future<dynamic> pushMemberRoute({
    Key key,
  }) =>
      push<dynamic>(
        FeatureScreenRoutes.memberRoute,
        arguments: MemberRouteArguments(key: key),
      );

  Future<dynamic> pushDepositRoute() =>
      push<dynamic>(FeatureScreenRoutes.depositRoute);

  Future<dynamic> pushDepositWebRoute({
    @required String startUrl,
    bool showUrl = false,
    bool hideHtmlBars = false,
  }) =>
      push<dynamic>(
        FeatureScreenRoutes.depositWebRoute,
        arguments: WebRouteArguments(
            startUrl: startUrl, showUrl: showUrl, hideHtmlBars: hideHtmlBars),
      );

  Future<dynamic> pushTransferRoute() =>
      push<dynamic>(FeatureScreenRoutes.transferRoute);

  Future<dynamic> pushBankcardRoute({
    bool withdraw = false,
  }) =>
      push<dynamic>(
        FeatureScreenRoutes.bankcardRoute,
        arguments: BankcardRouteArguments(withdraw: withdraw),
      );

  Future<dynamic> pushWithdrawRoute({
    bool withdraw = false,
  }) =>
      push<dynamic>(
        FeatureScreenRoutes.withdrawRoute,
        arguments: BankcardRouteArguments(withdraw: withdraw),
      );

  Future<dynamic> pushBalanceRoute() =>
      push<dynamic>(FeatureScreenRoutes.balanceRoute);

  Future<dynamic> pushWalletRoute() =>
      push<dynamic>(FeatureScreenRoutes.walletRoute);

  Future<dynamic> pushMessageRoute() =>
      push<dynamic>(FeatureScreenRoutes.messageRoute);

  Future<dynamic> pushCenterRoute() =>
      push<dynamic>(FeatureScreenRoutes.centerRoute);

  Future<dynamic> pushCenterPasswordRoute({
    @required CenterStore store,
  }) =>
      push<dynamic>(
        FeatureScreenRoutes.centerPasswordRoute,
        arguments: CenterDisplayAccountPasswordArguments(store: store),
      );

  Future<dynamic> pushCenterWebRoute({
    @required String startUrl,
    bool showUrl = false,
    bool hideHtmlBars = false,
  }) =>
      push<dynamic>(
        FeatureScreenRoutes.centerWebRoute,
        arguments: WebRouteArguments(
            startUrl: startUrl, showUrl: showUrl, hideHtmlBars: hideHtmlBars),
      );

  Future<dynamic> pushTransactionRoute() =>
      push<dynamic>(FeatureScreenRoutes.transactionRoute);

  Future<dynamic> pushBetRecordRoute() =>
      push<dynamic>(FeatureScreenRoutes.betRecordRoute);

  Future<dynamic> pushDealsRoute() =>
      push<dynamic>(FeatureScreenRoutes.dealsRoute);

  Future<dynamic> pushRollbackRoute() =>
      push<dynamic>(FeatureScreenRoutes.rollbackRoute);

  Future<dynamic> pushPromoRoute({
    int openPromoId = -1,
  }) =>
      push<dynamic>(
        FeatureScreenRoutes.promoRoute,
        arguments: PromoRouteArguments(openPromoId: openPromoId),
      );

  Future<dynamic> pushDepositFeatureRoute() =>
      push<dynamic>(FeatureScreenRoutes.depositFeatureRoute);

  Future<dynamic> pushDownloadAreaRoute() =>
      push<dynamic>(FeatureScreenRoutes.downloadAreaRoute);

  Future<dynamic> pushTutorialWebRoute({
    @required String startUrl,
    bool showUrl = false,
    bool hideHtmlBars = false,
  }) =>
      push<dynamic>(
        FeatureScreenRoutes.tutorialWebRoute,
        arguments: WebRouteArguments(
            startUrl: startUrl, showUrl: showUrl, hideHtmlBars: hideHtmlBars),
      );

  Future<dynamic> pushNoticeRoute() =>
      push<dynamic>(FeatureScreenRoutes.noticeRoute);

  Future<dynamic> pushStoreRoute() =>
      push<dynamic>(FeatureScreenRoutes.storeRoute);

  Future<dynamic> pushVipLevelRoute() =>
      push<dynamic>(FeatureScreenRoutes.vipLevelRoute);
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// WebGameScreen arguments holder class
class WebGameScreenArguments {
  final String startUrl;
  WebGameScreenArguments({this.startUrl = Global.CURRENT_BASE});
}

/// LoginRoute arguments holder class
class LoginRouteArguments {
  final bool returnHomeAfterLogin;
  final bool isDialog;
  LoginRouteArguments(
      {this.returnHomeAfterLogin = false, this.isDialog = false});
}

/// RegisterRoute arguments holder class
class RegisterRouteArguments {
  final bool isDialog;
  RegisterRouteArguments({this.isDialog = false});
}

/// WebRoute arguments holder class
class WebRouteArguments {
  final String startUrl;
  final bool showUrl;
  final bool hideHtmlBars;
  const WebRouteArguments(
      {@required this.startUrl,
      this.showUrl = false,
      this.hideHtmlBars = false});
}

/// MemberRoute arguments holder class
class MemberRouteArguments {
  final Key key;
  MemberRouteArguments({this.key});
}

/// BankcardRoute arguments holder class
class BankcardRouteArguments {
  final bool withdraw;
  const BankcardRouteArguments({this.withdraw = false});
}

/// CenterDisplayAccountPassword arguments holder class
class CenterDisplayAccountPasswordArguments {
  final CenterStore store;
  CenterDisplayAccountPasswordArguments({@required this.store});
}

/// PromoRoute arguments holder class
class PromoRouteArguments {
  final int openPromoId;
  PromoRouteArguments({this.openPromoId = -1});
}
