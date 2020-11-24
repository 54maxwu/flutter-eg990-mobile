import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/application/internal/input_limit.dart';
import 'package:flutter_eg990_mobile/presentation/common/fields/checkbox_widget.dart';
import 'package:flutter_eg990_mobile/presentation/common/fields/customize_field_widget.dart';
import 'package:flutter_eg990_mobile/presentation/export_internal_file.dart';
import 'package:flutter_eg990_mobile/presentation/features/login/data/form/login_form.dart';
import 'package:flutter_eg990_mobile/presentation/features/login/data/form/login_form_data.dart';
import 'package:flutter_eg990_mobile/presentation/features/login/data/form/login_form_hive.dart';

typedef OnRequestLogin = void Function(LoginForm);

class LoginFormWidget extends StatefulWidget {
  final LoginFormHive historyForm;
  final OnRequestLogin onRequestLogin;
  final Function callInitComplete;

  LoginFormWidget({
    Key key,
    @required this.historyForm,
    @required this.onRequestLogin,
    @required this.callInitComplete,
  }) : super(key: key);

  @override
  LoginFormWidgetState createState() => LoginFormWidgetState();
}

class LoginFormWidgetState extends State<LoginFormWidget>
    with AfterLayoutMixin {
  final GlobalKey<CustomizeFieldWidgetState> _usernameFieldKey =
      new GlobalKey(debugLabel: 'username');
  final GlobalKey<CustomizeFieldWidgetState> _passwordFieldKey =
      new GlobalKey(debugLabel: 'password');
  final GlobalKey<CheckboxWidgetState> _saveKey =
      new GlobalKey(debugLabel: 'save');

  Username _username = Username.pure();
  Password _password = Password.pure();

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          // TextFormField(
          //   decoration: const InputDecoration(
          //     prefixIcon: Icon(Icons.person),
          //     labelText: 'Account',
          //   ),
          //   autocorrect: false,
          //   initialValue: widget.historyForm?.username ?? '',
          //   onChanged: (value) => _username = Username.dirty(value: value),
          //   validator: (_) => (_username.valid) ? null : 'Account Error',
          // ),
          CustomizeFieldWidget(
            key: _usernameFieldKey,
            fieldType: FieldType.Account,
            persistHint: false,
            hint: localeStr.hintAccountInput,
            prefixIconData: Icons.person,
            prefixText: localeStr.registerFieldTitleAccount,
            prefixTextSize: FontSize.SUBTITLE.value,
            minusHeight: 16.0,
            maxInputLength: InputLimit.ACCOUNT_MAX,
            errorMsg: localeStr.messageInvalidAccount,
            onInputChanged: (value) => _username = Username.dirty(value: value),
            validCondition: (_) => _username.valid,
          ),
          const SizedBox(height: 8),
          CustomizeFieldWidget(
            key: _passwordFieldKey,
            fieldType: FieldType.Password,
            persistHint: false,
            hint: localeStr.hintPasswordInput,
            prefixIconData: Icons.lock,
            prefixText: localeStr.registerFieldTitlePassword,
            prefixTextSize: FontSize.SUBTITLE.value,
            minusHeight: 16.0,
            maxInputLength: InputLimit.PASSWORD_MAX,
            errorMsg: localeStr.messageInvalidPassword,
            onInputChanged: (value) => _password = Password.dirty(value: value),
            validCondition: (_) => _password.valid,
          ),
          const SizedBox(height: 8),
          CheckboxWidget(
            key: _saveKey,
            label: localeStr.btnFastLogin,
          ),
          const SizedBox(height: 8),
          RaisedButton(
            child: Text(
              localeStr.btnLogin,
              style: TextStyle(
                fontSize: FontSize.SUBTITLE.value,
                color: themeColor.secondaryTextColor1,
              ),
            ),
            onPressed: () {
              // clear text field focus
              FocusScope.of(context).unfocus();
              final form = LoginForm(
                username: _username,
                password: _password,
                saveForm: _saveKey.currentState.boxChecked,
              );
              debugPrint('login form: $form');
              if (form.validate.isRight()) {
                debugPrint('login form is valid');
                widget.onRequestLogin(form);
              } else if (form.status.index == 0) {
                callToast(localeStr.messageActionFillForm);
              } else {
                debugPrint(
                    'login form error: ${form.validate.getOrElse(() => null)}');
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (mounted && widget.historyForm != null) {
      Future.delayed(Duration(milliseconds: 100), () {
        _usernameFieldKey.currentState.setInput = widget.historyForm.username;
        _passwordFieldKey.currentState.setInput = widget.historyForm.password;
        _saveKey.currentState.setChecked = true;
      });
      Future.delayed(Duration(milliseconds: 500), widget.callInitComplete);
    }
  }
}
