import 'package:freezed_annotation/freezed_annotation.dart';

part 'agent_downline_form.freezed.dart';

@freezed
abstract class AgentDownlineForm with _$AgentDownlineForm {
  const factory AgentDownlineForm({
    @required String username,
    @required String password,
    @required String confirmPassword,
    @required String phone,
    @required String appContact,
  }) = _AgentDownlineForm;
}

extension AgentDownlineFormExtension on AgentDownlineForm {
  /// This method is not reversible
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': this.username,
      'password': this.password,
      'confirmPassword': this.confirmPassword,
      'mobileno': this.phone,
      'zalo': this.appContact,
    };
  }

  bool get isValid =>
      username.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      password == confirmPassword &&
      phone.isNotEmpty &&
      appContact.isNotEmpty;
}
