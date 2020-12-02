import 'package:dartz/dartz.dart';
import 'package:flutter_eg990_mobile/domain/user/login/login_form_data.dart';
import 'package:flutter_eg990_mobile/domain/user/login/login_form_hive.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

@immutable
class LoginForm with FormzMixin {
  LoginForm({
    @required this.username,
    @required this.password,
    this.saveForm = false,
  });

  final Username username;
  final Password password;
  final bool saveForm;

  @override
  List<FormzInput> get inputs => [username, password];

  @override
  String toString() {
    return 'LoginForm(username: $username, password: $password, save: $saveForm)' +
        '\nLoginForm Status: ${this.status}';
  }
}

extension LoginFormExtension on LoginForm {
  Either<LoginInputError, Unit> get validate =>
      (this.status == FormzStatus.valid)
          ? right(unit)
          : left(this.username.error ?? this.password.error);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'accountcode': this.username.value,
        'password': this.password.value,
      };

  LoginFormHive toHive() => LoginFormHive(
        username: username.value,
        password: password.value,
        save: saveForm,
      );
}
