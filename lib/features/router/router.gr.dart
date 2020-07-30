// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_ty_mobile/features/home/presentation/home_route.dart';
import 'package:flutter_ty_mobile/features/user/login/presentation/login_route.dart';
import 'package:flutter_ty_mobile/features/subfeatures/register/presentation/register_route.dart';
import 'package:flutter_ty_mobile/features/web/web_route.dart';
import 'package:flutter_ty_mobile/features/member/presentation/member_route.dart';
import 'package:flutter_ty_mobile/features/promo/presentation/promo_route.dart';
import 'package:flutter_ty_mobile/features/subfeatures/deposit/presentation/deposit_route.dart';
import 'package:flutter_ty_mobile/features/subfeatures/transfer/presentation/transfer_route.dart';
import 'package:flutter_ty_mobile/features/subfeatures/bankcard/presentation/bankcard_route.dart';
import 'package:flutter_ty_mobile/features/subfeatures/balance/presentation/balance_route.dart';
import 'package:flutter_ty_mobile/features/subfeatures/wallet/presentation/wallet_route.dart';
import 'package:flutter_ty_mobile/features/subfeatures/message/presentation/message_route.dart';
import 'package:flutter_ty_mobile/features/subfeatures/accountcenter/presentation/center_route.dart';
import 'package:flutter_ty_mobile/features/subfeatures/accountcenter/presentation/widgets/center_display_account_pwd.dart';
import 'package:flutter_ty_mobile/features/subfeatures/accountcenter/presentation/state/center_store.dart';
import 'package:flutter_ty_mobile/features/subfeatures/transactions/presentation/transaction_route.dart';
import 'package:flutter_ty_mobile/features/subfeatures/betrecord/presentation/bet_record_route.dart';
import 'package:flutter_ty_mobile/features/subfeatures/deals/presentation/deals_route.dart';
import 'package:flutter_ty_mobile/features/subfeatures/flows/presentation/flows_route.dart';
import 'package:flutter_ty_mobile/features/subfeatures/agent/presentation/agent_route.dart';
import 'package:flutter_ty_mobile/features/subfeatures/downloadarea/download_area_route.dart';
import 'package:flutter_ty_mobile/features/subfeatures/notice/presentation/notice_route.dart';
import 'package:flutter_ty_mobile/features/subfeatures/viplevel/presentation/vip_level_route.dart';
import 'package:flutter_ty_mobile/features/subfeatures/store/presentation/store_route.dart';
import 'package:flutter_ty_mobile/features/subfeatures/roller/presentation/roller_route.dart';
import 'package:flutter_ty_mobile/features/test_area_route.dart';
import 'package:flutter_ty_mobile/template/mobx/presentation/template_route.dart';

abstract class Routes {
  static const homeRoute = '/';
  static const loginRoute = '/login-route';
  static const registerRoute = '/register-route';
  static const serviceRoute = '/service-route';
  static const memberRoute = '/member-route';
  static const promoRoute = '/promo-route';
  static const depositRoute = '/deposit-route';
  static const depositWebPage = '/deposit-web-page';
  static const transferRoute = '/transfer-route';
  static const bankcardRoute = '/bankcard-route';
  static const balanceRoute = '/balance-route';
  static const walletRoute = '/wallet-route';
  static const messageRoute = '/message-route';
  static const centerRoute = '/center-route';
  static const centerPasswordPage = '/center-password-page';
  static const centerWebPage = '/center-web-page';
  static const transactionRoute = '/transaction-route';
  static const betRecordRoute = '/bet-record-route';
  static const dealsRoute = '/deals-route';
  static const flowsRoute = '/flows-route';
  static const agentRoute = '/agent-route';
  static const moreWebPage = '/more-web-page';
  static const downloadAreaRoute = '/download-area-route';
  static const noticeRoute = '/notice-route';
  static const levelRoute = '/level-route';
  static const storeRoute = '/store-route';
  static const rollerRoute = '/roller-route';
  static const testAreaRoute = '/test-area-route';
  static const templateRoute = '/template-route';
  static const all = {
    homeRoute,
    loginRoute,
    registerRoute,
    serviceRoute,
    memberRoute,
    promoRoute,
    depositRoute,
    depositWebPage,
    transferRoute,
    bankcardRoute,
    balanceRoute,
    walletRoute,
    messageRoute,
    centerRoute,
    centerPasswordPage,
    centerWebPage,
    transactionRoute,
    betRecordRoute,
    dealsRoute,
    flowsRoute,
    agentRoute,
    moreWebPage,
    downloadAreaRoute,
    noticeRoute,
    levelRoute,
    storeRoute,
    rollerRoute,
    testAreaRoute,
    templateRoute,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.homeRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomeRoute(),
          settings: settings,
        );
      case Routes.loginRoute:
        if (hasInvalidArgs<LoginRouteArguments>(args)) {
          return misTypedArgsRoute<LoginRouteArguments>(args);
        }
        final typedArgs = args as LoginRouteArguments ?? LoginRouteArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => LoginRoute(
              returnHomeAfterLogin: typedArgs.returnHomeAfterLogin,
              isDialog: typedArgs.isDialog),
          settings: settings,
        );
      case Routes.registerRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => RegisterRoute(),
          settings: settings,
        );
      case Routes.serviceRoute:
        if (hasInvalidArgs<WebRouteArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<WebRouteArguments>(args);
        }
        final typedArgs = args as WebRouteArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => WebRoute(
              startUrl: typedArgs.startUrl, hideBars: typedArgs.hideBars),
          settings: settings,
        );
      case Routes.memberRoute:
        if (hasInvalidArgs<MemberRouteArguments>(args)) {
          return misTypedArgsRoute<MemberRouteArguments>(args);
        }
        final typedArgs =
            args as MemberRouteArguments ?? MemberRouteArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => MemberRoute(key: typedArgs.key),
          settings: settings,
        );
      case Routes.promoRoute:
        if (hasInvalidArgs<PromoRouteArguments>(args)) {
          return misTypedArgsRoute<PromoRouteArguments>(args);
        }
        final typedArgs = args as PromoRouteArguments ?? PromoRouteArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => PromoRoute(openPromoId: typedArgs.openPromoId),
          settings: settings,
        );
      case Routes.depositRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => DepositRoute(),
          settings: settings,
        );
      case Routes.depositWebPage:
        if (hasInvalidArgs<WebRouteArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<WebRouteArguments>(args);
        }
        final typedArgs = args as WebRouteArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => WebRoute(
              startUrl: typedArgs.startUrl, hideBars: typedArgs.hideBars),
          settings: settings,
        );
      case Routes.transferRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => TransferRoute(),
          settings: settings,
        );
      case Routes.bankcardRoute:
        if (hasInvalidArgs<BankcardRouteArguments>(args)) {
          return misTypedArgsRoute<BankcardRouteArguments>(args);
        }
        final typedArgs =
            args as BankcardRouteArguments ?? BankcardRouteArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => BankcardRoute(withdraw: typedArgs.withdraw),
          settings: settings,
        );
      case Routes.balanceRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => BalanceRoute(),
          settings: settings,
        );
      case Routes.walletRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => WalletRoute(),
          settings: settings,
        );
      case Routes.messageRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => MessageRoute(),
          settings: settings,
        );
      case Routes.centerRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => CenterRoute(),
          settings: settings,
        );
      case Routes.centerPasswordPage:
        if (hasInvalidArgs<CenterDisplayAccountPasswordArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<CenterDisplayAccountPasswordArguments>(args);
        }
        final typedArgs = args as CenterDisplayAccountPasswordArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              CenterDisplayAccountPassword(store: typedArgs.store),
          settings: settings,
        );
      case Routes.centerWebPage:
        if (hasInvalidArgs<WebRouteArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<WebRouteArguments>(args);
        }
        final typedArgs = args as WebRouteArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => WebRoute(
              startUrl: typedArgs.startUrl, hideBars: typedArgs.hideBars),
          settings: settings,
        );
      case Routes.transactionRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => TransactionRoute(),
          settings: settings,
        );
      case Routes.betRecordRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => BetRecordRoute(),
          settings: settings,
        );
      case Routes.dealsRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => DealsRoute(),
          settings: settings,
        );
      case Routes.flowsRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => FlowsRoute(),
          settings: settings,
        );
      case Routes.agentRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => AgentRoute(),
          settings: settings,
        );
      case Routes.moreWebPage:
        if (hasInvalidArgs<WebRouteArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<WebRouteArguments>(args);
        }
        final typedArgs = args as WebRouteArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => WebRoute(
              startUrl: typedArgs.startUrl, hideBars: typedArgs.hideBars),
          settings: settings,
        );
      case Routes.downloadAreaRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => DownloadAreaRoute(),
          settings: settings,
        );
      case Routes.noticeRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => NoticeRoute(),
          settings: settings,
        );
      case Routes.levelRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => VipLevelRoute(),
          settings: settings,
        );
      case Routes.storeRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => StoreRoute(),
          settings: settings,
        );
      case Routes.rollerRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => RollerRoute(),
          settings: settings,
        );
      case Routes.testAreaRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => TestAreaRoute(),
          settings: settings,
        );
      case Routes.templateRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => TemplateRoute(),
          settings: settings,
          fullscreenDialog: true,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//LoginRoute arguments holder class
class LoginRouteArguments {
  final bool returnHomeAfterLogin;
  final bool isDialog;
  LoginRouteArguments(
      {this.returnHomeAfterLogin = false, this.isDialog = false});
}

//WebRoute arguments holder class
class WebRouteArguments {
  final String startUrl;
  final bool hideBars;
  WebRouteArguments({@required this.startUrl, this.hideBars = false});
}

//MemberRoute arguments holder class
class MemberRouteArguments {
  final Key key;
  MemberRouteArguments({this.key});
}

//PromoRoute arguments holder class
class PromoRouteArguments {
  final int openPromoId;
  PromoRouteArguments({this.openPromoId = -1});
}

//BankcardRoute arguments holder class
class BankcardRouteArguments {
  final bool withdraw;
  BankcardRouteArguments({this.withdraw = false});
}

//CenterDisplayAccountPassword arguments holder class
class CenterDisplayAccountPasswordArguments {
  final CenterStore store;
  CenterDisplayAccountPasswordArguments({@required this.store});
}
