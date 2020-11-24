import 'package:flutter_eg990_mobile/presentation/router/data/route_enum.dart';
import 'package:flutter_eg990_mobile/utils/regex_util.dart';

import 'local_strings.dart';

export 'package:flutter_eg990_mobile/presentation/router/data/route_enum.dart';

class MessageMap {
  static String getSuccessMessage(String msgKey, RouteEnum from) {
    if (msgKey != null && msgKey.isNotEmpty && msgKey.hasChinese) return msgKey;
    switch (from) {
      case RouteEnum.LOGIN:
        return localeStr.messageWelcomeUser(msgKey);
      default:
        break;
    }
    return localeStr.messageSuccess;
  }

  static String getErrorMessage(String msgKey, RouteEnum from) {
    if (msgKey == null || msgKey.isEmpty) return localeStr.messageFailed;
    if (msgKey.hasChinese) return msgKey;
    switch (msgKey) {
      case 'mobileRepeat':
        return localeStr.messageRegisterFailed;
      case 'repeatAccount':
      case 'RepeatAccount':
      case 'accountRepeat':
        return localeStr.messageRepeatAccount;
      case 'accountError':
        return localeStr.messageErrorAccount;
      case 'pwdError':
        return localeStr.messageErrorPassword;
      case 'pwdErrorFive':
        return localeStr.messageErrorPasswordHint;
      default:
        break;
    }
    switch (from) {
      case RouteEnum.LOGIN:
        return localeStr.messageLoginFailed;
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
