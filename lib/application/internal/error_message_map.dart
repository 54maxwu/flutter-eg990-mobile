import 'package:flutter_eg990_mobile/presentation/router/data/route_enum.dart';
import 'package:flutter_eg990_mobile/utils/regex_util.dart';

import 'local_strings.dart';

export 'package:flutter_eg990_mobile/presentation/router/data/route_enum.dart';

class MessageMap {
  static String getSuccessMessage(String msgKey, RouteEnum from) {
    if (msgKey != null && msgKey.isNotEmpty && msgKey.hasChinese) return msgKey;
    switch (from) {
      // case RouteEnum.AGENT_REGISTER:
      //   return localeStr.agentRegisterSuccess;
      default:
        break;
    }
    return localeStr.msgSuccess;
  }

  static String getErrorMessage(String msgKey, RouteEnum from) {
    if (msgKey == null || msgKey.isEmpty) return localeStr.msgFailed;
    if (msgKey.hasChinese) return msgKey;
    // debugPrint('looking for error message: $msgKey');
    switch (msgKey) {
      case 'dobBefore':
        return localeStr.fieldErrorInvalidDate;
      case 'mobileRepeat':
        return localeStr.errorMobileAlreadyRegistered;
      case 'mobileError':
        return localeStr.errorInvalidMobile;
      case 'agentCodeError':
        return localeStr.errorInvalidReferral;
      case 'repeatAccount':
      case 'RepeatAccount':
      case 'accountRepeat':
        return localeStr.errorRegisterRepeatAccount;
      case 'accountError':
        return localeStr.errorAccount;
      case 'accountInvalid':
      case 'pwdErrorFiveStop':
        return localeStr.errorAccountLocked;
      case 'pwdError':
        return localeStr.errorInvalidPassword;
      case 'pwdErrorFive':
        return localeStr.errorInvalidPasswordFive;
      case 'wrongPassword':
        if (from == RouteEnum.WITHDRAW) {
          return localeStr.errorInvalidWithdrawPassword;
        } else {
          return localeStr.errorInvalidPassword;
        }
        break;
      case 'dobBefore':
        return localeStr.fieldErrorInvalidDateRange;
      case 'amountMoreThanBalance':
        return localeStr.errorInvalidAmountExceedRemain;
      case 'belowTheMinimum':
        return localeStr.fieldErrorInvalidCreditMin(100);
      case 'aboveTheCeiling':
        return localeStr.errorInvalidExceedOrderAmount;
      case 'amountExceedsTheUpperLimit':
        return localeStr.errorInvalidDepositAmountMaxLimit;
      case 'amountIsBelowTheLowerLimit':
        return localeStr.errorInvalidDepositAmountMinLimit;
      case 'YouHaveInsufficientCredit':
        return localeStr.msgNotEnoughCredit;
      case 'NoRecordsYet':
        return localeStr.hintNoHistoryData;
      case 'inMaintenance':
        return localeStr.hintMaintenance;
      case 'YouDoNotHavePpermissionToPlayThisPlatform,PleaseContact24-hourOnlineCustomerService':
        return localeStr.errorGameAccessPermission;
      default:
        break;
    }
    switch (from) {
      case RouteEnum.HOME:
        return localeStr.errorLoadingGame;
      case RouteEnum.LOGIN:
        return localeStr.errorLoginFailed;
      case RouteEnum.REGISTER:
        return localeStr.errorRegisterFailed;
      case RouteEnum.BANKCARD:
        return localeStr.errorTaskFailed(localeStr.msgPleaseBindBankcard);
      case RouteEnum.WITHDRAW:
        return localeStr.errorWithdraw;
      case RouteEnum.DEPOSIT:
        return localeStr.errorDeposit;
      case RouteEnum.BALANCE:
      case RouteEnum.TRANSFER:
        return localeStr.errorTransfer;
      default:
        if (msgKey.isNotEmpty) {
          return localeStr.errorStatus(msgKey);
        }
        break;
    }
    return localeStr.msgFailed;
  }
}
