import 'package:dartz/dartz.dart';
import 'package:flutter_eg990_mobile/domain/user/login/login_form.dart';

import '../user/user.dart';
import 'auth_failure.dart';

abstract class IAuthFacade {
  Future<Option<User>> getLoggedInUser();

  Future<Either<AuthFailure, Unit>> loginUser(LoginForm form);

  Future<void> logout();
}
