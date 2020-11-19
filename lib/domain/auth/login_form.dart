import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:formz/formz.dart';

import 'login_form_data.dart';

@immutable
class LoginForm with FormzMixin {
  LoginForm({@required this.username, @required this.password});

  final Username username;
  final Password password;

  @override
  List<FormzInput> get inputs => [username, password];

  @override
  String toString() {
    return 'LoginForm(username: $username, password: $password)' +
        '\nLoginForm Status: ${this.status}';
  }
}

extension LoginFormExtension on LoginForm {
  Either<LoginInputError, Unit> get validate =>
      (this.status == FormzStatus.valid)
          ? right(unit)
          : left(this.username.error ?? this.password.error);
}
