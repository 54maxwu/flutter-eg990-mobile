import 'package:flutter_eg990_mobile/core/internal/local_strings.dart';
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
    switch (msgKey) {
      case 'mobileRepeat':
        return localeStr.messageRegisterFailed;
      case 'repeatAccount':
      case 'RepeatAccount':
      case 'accountRepeat':
        return localeStr.messageRepeatAccount;
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
