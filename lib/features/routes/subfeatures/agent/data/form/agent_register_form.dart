import 'package:freezed_annotation/freezed_annotation.dart';

part 'agent_register_form.freezed.dart';

@freezed
abstract class AgentRegisterForm with _$AgentRegisterForm {
  const factory AgentRegisterForm({
    @required String username,
    @required String password,
    @required String confirmPassword,
    @required String phone,
    @required String email,
    @required String appContact,
  }) = _AgentRegisterForm;
}

extension AgentRegisterFormExtension on AgentRegisterForm {
  /// This method is not reversible
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': this.username,
      'userpassword': this.password,
      'phoneno': this.phone ?? '',
      'email': this.email ?? '',
      'contact_app': this.appContact ?? '',
    };
  }

  bool get isValid =>
      username.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      password == confirmPassword &&
      phone.isNotEmpty &&
      email.isNotEmpty &&
      appContact.isNotEmpty;
}
