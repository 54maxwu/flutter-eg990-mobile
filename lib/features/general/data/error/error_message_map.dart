import 'package:flutter_eg990_mobile/core/internal/local_strings.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_eg990_mobile/features/router/route_enum.dart';
import 'package:flutter_eg990_mobile/utils/regex_util.dart';

class MessageMap {
  static String getSuccessMessage(String msgKey, RouteEnum from) {
    if (msgKey != null && msgKey.isNotEmpty && msgKey.hasChinese) return msgKey;
    switch (from) {
      case RouteEnum.AGENT_REGISTER:
        return localeStr.agentRegisterSuccess;
      default:
        break;
    }
    return localeStr.messageSuccess;
  }

  static String getErrorMessage(String msgKey, RouteEnum from) {
    if (msgKey == null || msgKey.isEmpty) return localeStr.messageFailed;
    if (msgKey.hasChinese) return msgKey;
    debugPrint('looking for error message: $msgKey');
    switch (msgKey) {
      case 'dobBefore':
        return localeStr.messageInvalidBirthDate;
      case 'mobileRepeat':
        return localeStr.messageRepeatPhone;
      case 'repeatAccount':
      case 'RepeatAccount':
      case 'accountRepeat':
        return localeStr.messageRepeatAccount;
      case 'accountError':
        return localeStr.messageErrorAccount;
      case 'wrongPassword':
        return localeStr.messageInvalidWithdrawPassword;
      case 'pwdErrorFive':
        return localeStr.messageInvalidPasswordFive;
      case 'pwdErrorFiveStop':
        return localeStr.messageInvalidPasswordLocked;
      case 'belowTheMinimum':
        return localeStr.messageInvalidWithdrawUnderAmount;
      case 'amountMoreThanBalance':
        return localeStr.messageInvalidWithdrawAmount;
      case 'NoRecordsYet':
        return localeStr.messageWarnNoHistoryData;
      default:
        break;
    }
    switch (from) {
      case RouteEnum.REGISTER:
        return localeStr.messageRegisterFailed;
      case RouteEnum.BANKCARD:
        return localeStr.messageTaskFailed(localeStr.messageErrorBindBankcard);
      case RouteEnum.WITHDRAW:
        return localeStr.messageErrorWithdraw;
      case RouteEnum.BALANCE:
        return localeStr.messageTaskFailed(localeStr.transferResultAlertTitle);
      default:
        if (msgKey.isNotEmpty) {
          return localeStr.messageErrorStatus(msgKey);
        }
        break;
    }
    return localeStr.messageFailed;
  }
}
