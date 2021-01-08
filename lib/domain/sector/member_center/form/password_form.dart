import 'package:dartz/dartz.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart' show required, immutable;

import 'password_form_data.dart';

@immutable
class PasswordForm with FormzMixin {
  PasswordForm({
    @required this.oldPassword,
    @required this.newPassword,
    @required this.confirmPassword,
  });

  final PasswordOld oldPassword;
  final PasswordNew newPassword;
  final PasswordNew confirmPassword;

  @override
  List<FormzInput> get inputs => [oldPassword, newPassword, confirmPassword];

  @override
  String toString() {
    return 'PasswordForm(old: $oldPassword, new: $newPassword, confirm: $confirmPassword)' +
        '\nPasswordForm Status: ${this.status}';
  }
}

extension PasswordFormExtension on PasswordForm {
  Either<PasswordInputError, Unit> get validate =>
      (this.status == FormzStatus.valid)
          ? (this.newPassword.value == this.confirmPassword.value)
              ? right(unit)
              : left(PasswordInputError.confirm)
          : left(this.oldPassword.error ??
              this.newPassword.error ??
              this.confirmPassword.error);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'oldpassword': this.oldPassword.value,
        'newpassword': this.newPassword.value,
        'conpassword': this.confirmPassword.value,
      };
}
