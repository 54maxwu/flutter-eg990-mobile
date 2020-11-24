import 'package:dartz/dartz.dart';

import 'auth_failure.dart';
import '../../presentation/features/login/data/form/login_form.dart';
import '../user/user.dart';

abstract class IAuthFacade {
  Future<Option<User>> getLoggedInUser();
  Future<Either<AuthFailure, Unit>> loginUser(LoginForm form);
  Future<void> logout();
}
