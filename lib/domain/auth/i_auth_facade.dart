import 'package:dartz/dartz.dart';

import 'auth_failure.dart';
import 'login_form.dart';
import 'user.dart';

abstract class IAuthFacade {
  Future<Option<User>> getLoggedInUser();
  Future<Either<AuthFailure, Unit>> loginUser(LoginForm form);
  Future<void> logout();
}
