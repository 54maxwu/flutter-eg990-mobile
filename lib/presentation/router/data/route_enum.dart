import 'package:flutter_eg990_mobile/application/internal/local_strings.dart';

enum RouteEnum {
  HOME,
  GAMES,

  ///
  PROMO,
  PROMO_DETAIL,
  SERVICE,
  SERVICE_WEB,
  SPONSOR,
  MEMBER,

  ///
  DEPOSIT,
  TRANSFER,
  BANKCARD,
  WITHDRAW,
  ACCOUNT_CENTER,
  BALANCE,
  WALLET,
  TRANSFER_RECORD,
  DEALS,
  BET_RECORD,
  ROLLBACK,
  AGENT,
  AGENT_LOGIN,
  AGENT_REGISTER,

  ///
  NOTICE,
  DOWNLOAD,
  TUTORIAL,
  AGENT_ABOUT,
  VIP,
  VIP_ABOUT,
  STORE,
  SIGN,
  WEBSITE,
  ABOUT_US,
  LINE_QR,
  EXCHANGE_RECORD,
  HELP,
  INVITE,
  JOIN_US,

  ///
  MORE,
  ROUTE_CHANGE,
  ROLLER,
  TASK,
  COLLECT,

  ///
  LOGIN,
  REGISTER,
  PASSWORD,
  LOGOUT,

  ///
  TEMPLATE,
  TEST_UI,
  TEST,

  ///
  BACK_HOME,
  ROTATE,
  ROTATE_LOCK,
}

extension RouteEnumExtension on RouteEnum {
  String get title {
    switch (this) {
      case RouteEnum.HOME:
        return localeStr.pageTitleHome;

      /// First Layer
      case RouteEnum.PROMO:
      case RouteEnum.PROMO_DETAIL:
        return localeStr.pageTitlePromo;
      case RouteEnum.SPONSOR:
        return localeStr.pageTitleSponsor;
      case RouteEnum.SERVICE:
      case RouteEnum.SERVICE_WEB:
        return localeStr.pageTitleService;
      case RouteEnum.MEMBER:
        return localeStr.pageTitleMember;

      /// Home Shortcuts
      case RouteEnum.DEPOSIT:
        return localeStr.pageTitleDeposit;
      case RouteEnum.TRANSFER:
        return localeStr.pageTitleMemberTransfer;
      case RouteEnum.WITHDRAW:
        return localeStr.pageTitleMemberWithdraw;
      case RouteEnum.VIP:
        return localeStr.pageTitleVipAbout;

      /// User
      case RouteEnum.LOGIN:
        return localeStr.pageTitleLogin;
      case RouteEnum.REGISTER:
        return localeStr.pageTitleRegister;
      case RouteEnum.PASSWORD:
        return localeStr.pageTitleMemberPassword;
      case RouteEnum.LOGOUT:
        return localeStr.memberGridTitleLogout;

      /// Member
      case RouteEnum.VIP_ABOUT:
        return localeStr.pageTitleVipAbout;
      case RouteEnum.STORE:
        return localeStr.pageTitleStore;
      case RouteEnum.BET_RECORD:
        return localeStr.pageTitleMemberBets;
      case RouteEnum.TRANSFER_RECORD:
        return localeStr.pageTitleMemberTransaction;
      case RouteEnum.WALLET:
        return localeStr.pageTitleMemberWallet;
      case RouteEnum.ACCOUNT_CENTER:
        return localeStr.pageTitleMemberCenter;
      case RouteEnum.EXCHANGE_RECORD:
        return localeStr.pageTitleExchangeRecord;
      case RouteEnum.HELP:
        return localeStr.pageTitleHelpCenter;
      case RouteEnum.INVITE:
        return localeStr.pageTitleInvite;
      case RouteEnum.JOIN_US:
        return localeStr.pageTitleJoinUs;
      case RouteEnum.ABOUT_US:
        return localeStr.pageTitleAboutUs;
      case RouteEnum.WEBSITE:
        return localeStr.pageHintWebsite;

      /// Tests
      case RouteEnum.TEMPLATE:
        return 'TEST MOBX';
      case RouteEnum.TEST_UI:
        return 'TEST UI';
      case RouteEnum.TEST:
        return 'TEST PAGE';

      /// Float Tools
      case RouteEnum.BACK_HOME:
        return localeStr.sideBtnBackHome;
      case RouteEnum.ROTATE:
        return localeStr.sideBtnRotate;
      case RouteEnum.ROTATE_LOCK:
        return localeStr.sideBtnLockRotate;

      /// TODO Not Using
      case RouteEnum.BALANCE:
        return localeStr.pageTitleMemberBalance;
      case RouteEnum.DEALS:
        return localeStr.pageTitleMemberDeals;
      case RouteEnum.ROLLBACK:
        return localeStr.pageTitleMemberFlow;
      case RouteEnum.AGENT:
        return localeStr.pageTitleMemberAgent;
      case RouteEnum.AGENT_LOGIN:
        return localeStr.pageTitleMemberAgentLogin;
      case RouteEnum.AGENT_REGISTER:
        return localeStr.pageTitleMemberAgentRegister;
      case RouteEnum.NOTICE:
        return localeStr.pageTitleNotice;
      case RouteEnum.DOWNLOAD:
        return localeStr.pageTitleDownload;
      case RouteEnum.TUTORIAL:
        return localeStr.pageTitleTutorial;
      case RouteEnum.AGENT_ABOUT:
        return localeStr.pageTitleMemberAgentAbout;
      case RouteEnum.ROLLER:
        return localeStr.pageTitleRoller;
      case RouteEnum.SIGN:
        return localeStr.pageTitleSign;
      case RouteEnum.LINE_QR:
        return 'LINE';
      case RouteEnum.MORE:
        return localeStr.pageTitleMore;
      case RouteEnum.ROUTE_CHANGE:
        return localeStr.pageTitleRouter;
      case RouteEnum.TASK:
        return localeStr.pageTitleTask;
      case RouteEnum.COLLECT:
        return localeStr.pageTitleCollect;
      default:
        return '???';
    }
  }

  String get pageHint {
    switch (this) {
      case RouteEnum.EXCHANGE_RECORD:
        return localeStr.pageHintExchangeRecord;
      case RouteEnum.HELP:
        return localeStr.pageHintHelpCenter;
      case RouteEnum.INVITE:
        return localeStr.pageHintInvite;
      case RouteEnum.JOIN_US:
        return localeStr.pageHintJoinUs;
      default:
        return '';
    }
  }

  bool get isUserOnly {
    switch (this) {
      case RouteEnum.DEPOSIT:
      case RouteEnum.TRANSFER:
      case RouteEnum.BANKCARD:
      case RouteEnum.WITHDRAW:
      case RouteEnum.ACCOUNT_CENTER:
      case RouteEnum.BALANCE:
      case RouteEnum.WALLET:
      case RouteEnum.TRANSFER_RECORD:
      case RouteEnum.DEALS:
      case RouteEnum.BET_RECORD:
      case RouteEnum.ROLLBACK:
      case RouteEnum.STORE:
      case RouteEnum.EXCHANGE_RECORD:
      case RouteEnum.INVITE:
      case RouteEnum.PASSWORD:
      case RouteEnum.LOGOUT:
        return true;
        break;
      default:
        return false;
    }
  }
}
