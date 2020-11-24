import 'package:flutter_eg990_mobile/application/internal/input_limit.dart';
import 'package:formz/formz.dart';

enum LoginInputError { name, password }

class Username extends FormzInput<String, LoginInputError> {
  // Call super.pure to represent an unmodified form input.
  const Username.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Username.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  LoginInputError validator(String value) {
    return value?.isNotEmpty == true &&
            value.length >= InputLimit.ACCOUNT_MIN &&
            value.length <= InputLimit.ACCOUNT_MAX
        ? null
        : LoginInputError.name;
  }
}

class Password extends FormzInput<String, LoginInputError> {
  // Call super.pure to represent an unmodified form input.
  const Password.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Password.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  LoginInputError validator(String value) {
    return value?.isNotEmpty == true &&
            value.length >= InputLimit.PASSWORD_MIN &&
            value.length <= InputLimit.PASSWORD_MAX
        ? null
        : LoginInputError.password;
  }
}
