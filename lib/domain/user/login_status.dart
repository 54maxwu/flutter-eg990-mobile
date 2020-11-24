import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'login_status.freezed.dart';

@freezed
abstract class LoginStatus with _$LoginStatus {
  const factory LoginStatus({
    @required bool loggedIn,
    User user,
  }) = _LoginStatus;
}
