import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_eg990_mobile/domain/core/failures.dart';
import 'package:flutter_eg990_mobile/injection_container.dart' show sl;
import 'package:flutter_eg990_mobile/presentation/screens/user/user_info_store.dart';
import 'package:meta/meta.dart' show required;

export 'dart:async' show Stream, StreamController;

export 'package:dartz/dartz.dart' show Either, Left, Right;
export 'package:flutter/foundation.dart' show debugPrint;
export 'package:flutter_eg990_mobile/application/internal/local_strings.dart'
    show localeStr;
export 'package:flutter_eg990_mobile/domain/core/failures.dart';
export 'package:flutter_eg990_mobile/mylogger.dart';
export 'package:flutter_eg990_mobile/utils/value_util.dart';
export 'package:mobx/mobx.dart';

FailureType _errorFrom;

/// error message from repository
String _lastError;

String getErrorMsg({
  @required FailureType from,
  String msg,
  bool showOnce = false,
  FailureType type,
  int code = 0,
}) {
  debugPrint('failure from: ${from.value}, type: ${type?.value}');
  if (msg != null && msg.contains('code: 82')) {
    String code =
        msg.substring(msg.indexOf('code:')).replaceAll(RegExp('[^0-9]'), '');
    debugPrint('error msg code: $code');
    if (int.parse(code) >= 8200) {
      Future.delayed(Duration(milliseconds: 3000), () {
        sl.get<UserInfoStore>().logout(clean: true, navToLogin: true);
      });
      return msg;
    }
  }

  /// TODO avoid using null to check, instead, create a data class to check if the toast should show
  // if showOnce is true, and if message and message source are the same
  // return null to skip toast
  if (showOnce &&
      _errorFrom == from &&
      _lastError != null &&
      msg == _lastError) {
    return null;
  }

  _errorFrom = from;
  if (msg.isNotEmpty) {
    _lastError = msg;
  }
  return msg ??
      Failure.internal(FailureCode(
        type: type ?? from,
        code: code,
      )).message;
}
