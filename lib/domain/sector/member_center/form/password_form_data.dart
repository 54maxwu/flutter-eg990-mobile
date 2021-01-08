import 'package:flutter_eg990_mobile/application/internal/input_limit.dart';
import 'package:formz/formz.dart';

enum PasswordInputError { limit, confirm }

class PasswordOld extends FormzInput<String, PasswordInputError> {
  // Call super.pure to represent an unmodified form input.
  const PasswordOld.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const PasswordOld.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  PasswordInputError validator(String value) {
    return value?.isNotEmpty == true &&
            value.length >= InputLimit.PASSWORD_MIN_OLD &&
            value.length <= InputLimit.PASSWORD_MAX
        ? null
        : PasswordInputError.limit;
  }
}

class PasswordNew extends FormzInput<String, PasswordInputError> {
  // Call super.pure to represent an unmodified form input.
  const PasswordNew.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const PasswordNew.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  PasswordInputError validator(String value) {
    return value?.isNotEmpty == true &&
            value.length >= InputLimit.PASSWORD_MIN &&
            value.length <= InputLimit.PASSWORD_MAX
        ? null
        : PasswordInputError.limit;
  }
}
