import 'package:dartz/dartz.dart';
import 'package:flutter_eg990_mobile/presentation/features/login/form/login_form.dart';

import 'auth_failure.dart';
import '../user/user.dart';

abstract class IAuthFacade {
  Future<Option<User>> getLoggedInUser();
  Future<Either<AuthFailure, Unit>> loginUser(LoginForm form);
  Future<void> logout();
}
