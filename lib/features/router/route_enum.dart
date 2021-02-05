import 'package:flutter_eg990_mobile/core/internal/local_strings.dart';

enum RouteEnum {
  HOME,
  PROMO,
  SERVICE,
  SERVICE_WEB,

  ///
  MEMBER,
  DEPOSIT,
  TRANSFER,
  BANKCARD,
  WITHDRAW,
  CENTER,
  MESSAGE,
  BALANCE,
  WALLET,
  TRANSFER_RECORD,
  DEALS,
  BETS,
  ROLLBACK,

  ///
  NOTICE,
  DOWNLOAD,
  TUTORIAL,
  AGENT_ABOUT,
  VIP,
  STORE,
  SIGN,
  MISSION,
  WEBSITE,
  LINE_QR,

  ///
  LOGIN,
  REGISTER,
  PASSWORD,
  LOGOUT,

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
      case RouteEnum.PROMO:
        return localeStr.pageTitlePromo;
      case RouteEnum.SERVICE:
      case RouteEnum.SERVICE_WEB:
        return localeStr.pageTitleService;

      /// Member
      case RouteEnum.MEMBER:
        return localeStr.pageTitleMember;
      case RouteEnum.DEPOSIT:
        return localeStr.pageTitleDeposit;
      case RouteEnum.TRANSFER:
        return localeStr.pageTitleMemberTransfer;
      case RouteEnum.BANKCARD:
        return localeStr.pageTitleMemberCard;
      case RouteEnum.WITHDRAW:
        return localeStr.pageTitleMemberWithdraw;
      case RouteEnum.CENTER:
        return localeStr.pageTitleMemberCenter;
      case RouteEnum.MESSAGE:
        return localeStr.pageTitleMemberMessage;
      case RouteEnum.BALANCE:
        return localeStr.pageTitleMemberBalance;
      case RouteEnum.WALLET:
        return localeStr.pageTitleMemberWallet;
      case RouteEnum.TRANSFER_RECORD:
        return localeStr.pageTitleMemberTransaction;
      case RouteEnum.DEALS:
        return localeStr.pageTitleMemberDeals;
      case RouteEnum.BETS:
        return localeStr.pageTitleMemberBets;
      case RouteEnum.ROLLBACK:
        return localeStr.pageTitleMemberFlow;

      /// Side
      case RouteEnum.NOTICE:
        return localeStr.pageTitleNotice;
      case RouteEnum.DOWNLOAD:
        return localeStr.pageTitleDownload;
      case RouteEnum.TUTORIAL:
        return localeStr.pageTitleTutorial;
      case RouteEnum.AGENT_ABOUT:
        return localeStr.pageTitleMemberAgentAbout;
      case RouteEnum.VIP:
        return localeStr.pageTitleVip;
      case RouteEnum.STORE:
        return localeStr.pageTitleStore;
      // case RouteEnum.ROLLER:
      //   return localeStr.pageTitleRoller;
      case RouteEnum.SIGN:
        return localeStr.pageTitleSign;
      case RouteEnum.MISSION:
        return localeStr.pageTitleMission;
      case RouteEnum.WEBSITE:
        return localeStr.gameCategoryWeb;
      case RouteEnum.LINE_QR:
        return 'LINE';

      /// User
      case RouteEnum.PASSWORD:
        return localeStr.pageTitleMemberPassword;
      case RouteEnum.LOGIN:
        return localeStr.pageTitleLogin;
      case RouteEnum.REGISTER:
        return localeStr.pageTitleRegister;
      case RouteEnum.LOGOUT:
        return localeStr.memberGridTitleLogout;

      /// Float Tools
      case RouteEnum.BACK_HOME:
        return localeStr.sideBtnBackHome;
      case RouteEnum.ROTATE:
        return localeStr.sideBtnRotate;
      case RouteEnum.ROTATE_LOCK:
        return localeStr.sideBtnLockRotate;

      default:
        return '???';
    }
  }

  String get gridTitle {
    switch (this) {
      case RouteEnum.DEPOSIT:
        return localeStr.memberGridTitleDeposit;
      case RouteEnum.TRANSFER:
        return localeStr.memberGridTitleTransfer;
      case RouteEnum.BANKCARD:
        return localeStr.memberGridTitleCard;
      case RouteEnum.WITHDRAW:
        return localeStr.memberGridTitleWithdraw;
      case RouteEnum.BALANCE:
        return localeStr.memberGridTitleBalance;
      case RouteEnum.WALLET:
        return localeStr.memberGridTitleWallet;
      case RouteEnum.MESSAGE:
        return localeStr.memberGridTitleMessage;
      case RouteEnum.CENTER:
        return localeStr.memberGridTitleAccount;
      case RouteEnum.TRANSFER_RECORD:
        return localeStr.memberGridTitleTransaction;
      case RouteEnum.BETS:
        return localeStr.memberGridTitleBet;
      case RouteEnum.DEALS:
        return localeStr.memberGridTitleDeal;
      case RouteEnum.ROLLBACK:
        return localeStr.memberGridTitleFlow;
      default:
        return null;
    }
  }
}
