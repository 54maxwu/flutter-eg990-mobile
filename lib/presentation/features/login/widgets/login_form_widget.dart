import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/application/internal/input_limit.dart';
import 'package:flutter_eg990_mobile/domain/user/login/login_form.dart';
import 'package:flutter_eg990_mobile/domain/user/login/login_form_data.dart';
import 'package:flutter_eg990_mobile/domain/user/login/login_form_hive.dart';
import 'package:flutter_eg990_mobile/presentation/common/fields/checkbox_widget.dart';
import 'package:flutter_eg990_mobile/presentation/common/fields/field_wrapper_widget.dart';
import 'package:flutter_eg990_mobile/presentation/common/fields/field_input_widget.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';

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
  final GlobalKey<FieldInputWidgetState> _usernameFieldKey =
      new GlobalKey(debugLabel: 'username');
  final GlobalKey<FieldInputWidgetState> _passwordFieldKey =
      new GlobalKey(debugLabel: 'password');
  final GlobalKey<CheckboxWidgetState> _saveKey =
      new GlobalKey(debugLabel: 'save');

  Username _username = Username.pure();
  Password _password = Password.pure();

  InputBorder _fieldBorder;

  InputDecoration get _fieldBasicDecor => InputDecoration(
        labelStyle: TextStyle(
          fontSize: FontSize.MESSAGE.value,
          color: themeColor.fieldPrefixTextColor,
        ),
        border: _fieldBorder,
        enabledBorder: _fieldBorder,
        disabledBorder: _fieldBorder,
        focusedBorder: _fieldBorder,
        focusedErrorBorder: _fieldBorder,
        errorBorder: _fieldBorder,
      );

  @override
  Widget build(BuildContext context) {
    _fieldBorder ??= OutlineInputBorder(
      borderSide: BorderSide(color: themeColor.defaultBorderColor),
      borderRadius: BorderRadius.circular(24.0),
    );
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          FieldWrapperWidget(
            inputWidget: FieldInputWidget(
              key: _usernameFieldKey,
              inputType: FieldInputType.Account,
              maxInputLength: InputLimit.ACCOUNT_MAX,
              enableSuggestions: false,
              inputDecoration: _fieldBasicDecor.copyWith(
                prefixIcon: Icon(
                  Icons.person,
                  color: themeColor.fieldPrefixTextColor,
                ),
                labelText: localeStr.registerFieldTitleAccount,
                hintText: localeStr.hintAccountInput,
              ),
              onChanged: (value) => _username = Username.dirty(value: value),
              validator: (_) =>
                  _username.valid ? null : localeStr.messageErrorAccount,
            ),
          ),
          const SizedBox(height: 8.0),
          FieldWrapperWidget(
            inputWidget: FieldInputWidget(
              key: _passwordFieldKey,
              inputType: FieldInputType.Password,
              maxInputLength: InputLimit.PASSWORD_MAX,
              enableSuggestions: false,
              inputDecoration: _fieldBasicDecor.copyWith(
                prefixIcon: Icon(
                  Icons.lock,
                  color: themeColor.fieldPrefixTextColor,
                ),
                labelText: localeStr.registerFieldTitlePassword,
                hintText: localeStr.hintPasswordInput,
              ),
              onChanged: (value) => _password = Password.dirty(value: value),
              validator: (_) =>
                  _password.valid ? null : localeStr.messageInvalidPassword,
            ),
          ),
          const SizedBox(height: 8.0),
          CheckboxWidget(
            key: _saveKey,
            label: localeStr.btnFastLogin,
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: RaisedButton(
              child: Text(
                localeStr.btnLogin,
                style: TextStyle(
                  fontSize: FontSize.MESSAGE.value,
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
          ),
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (mounted && widget.historyForm != null) {
      _username = Username.dirty(value: widget.historyForm.username);
      _password = Password.dirty(value: widget.historyForm.password);
      Future.delayed(Duration(milliseconds: 100), () {
        _usernameFieldKey.currentState.setInput = _username.value;
        _passwordFieldKey.currentState.setInput = _password.value;
        _saveKey.currentState.setChecked = true;
      });
      Future.delayed(Duration(milliseconds: 500), widget.callInitComplete);
    }
  }
}
