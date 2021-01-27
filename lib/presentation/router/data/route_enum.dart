import 'package:flutter_eg990_mobile/application/internal/local_strings.dart';

enum RouteEnum {
  HOME,
  GAMES,

  ///
  NOTICE_BOARD,
  PROMO,
  PROMO_DETAIL,
  SERVICE,
  SERVICE_WEB,
  MEMBER,

  ///
  MEMBER_CENTER,
  DEPOSIT,
  TRANSFER,
  BANKCARD,
  BANKCARD_NEW,
  WITHDRAW,
  BALANCE,
  WALLET,
  TRANSFER_RECORD,
  BET_RECORD,

  ///
  STORE,
  EXCHANGE_RECORD,
  VIP,
  VIP_ABOUT,
  ABOUT_US,
  SPONSOR,
  HELP,
  INVITE,
  JOIN_US,
  WEBSITE,

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
        return localeStr.pageBtnChangePassword;
      case RouteEnum.LOGOUT:
        return localeStr.pageBtnLogout;

      /// Member
      case RouteEnum.MEMBER_CENTER:
        return localeStr.pageTitleMemberCenter;
      case RouteEnum.BANKCARD:
        return localeStr.pageTitleMemberCard;
      case RouteEnum.BANKCARD_NEW:
        return localeStr.hintAddBankcard;
      case RouteEnum.WALLET:
        return localeStr.pageTitleMemberWallet;
      case RouteEnum.BET_RECORD:
        return localeStr.pageTitleMemberBets;
      case RouteEnum.TRANSFER_RECORD:
        return localeStr.pageTitleMemberTransaction;
      case RouteEnum.EXCHANGE_RECORD:
        return localeStr.pageTitleExchangeRecord;
      case RouteEnum.STORE:
        return localeStr.pageTitleStore;
      case RouteEnum.HELP:
        return localeStr.pageTitleHelpCenter;
      case RouteEnum.VIP_ABOUT:
        return localeStr.pageTitleVipAbout;
      case RouteEnum.INVITE:
        return localeStr.pageTitleInvite;
      case RouteEnum.JOIN_US:
        return localeStr.pageTitleJoinUs;
      case RouteEnum.ABOUT_US:
        return localeStr.pageTitleAboutUs;
      case RouteEnum.WEBSITE:
        return localeStr.pageHintWebsite;

      /// Other
      case RouteEnum.NOTICE_BOARD:
        return localeStr.pageTitleNotice;

      /// Tests
      case RouteEnum.TEMPLATE:
        return 'TEST MOBX';
      case RouteEnum.TEST_UI:
        return 'TEST UI';
      case RouteEnum.TEST:
        return 'TEST PAGE';

      /// Float Tools
      case RouteEnum.BACK_HOME:
        return localeStr.gameToolBtnBackHome;
      case RouteEnum.ROTATE:
        return localeStr.gameToolBtnRotate;
      case RouteEnum.ROTATE_LOCK:
        return localeStr.gameToolBtnLockRotate;

      /// TODO Not Using
      case RouteEnum.BALANCE:
        return localeStr.pageTitleMemberBalance;
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
      case RouteEnum.MEMBER_CENTER:
      case RouteEnum.BANKCARD:
      case RouteEnum.BANKCARD_NEW:
      case RouteEnum.BALANCE:
      case RouteEnum.WALLET:
      case RouteEnum.TRANSFER_RECORD:
      case RouteEnum.BET_RECORD:
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
