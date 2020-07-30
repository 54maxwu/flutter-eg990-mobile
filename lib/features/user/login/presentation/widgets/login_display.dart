import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/checkbox_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_field_widget.dart';

import '../state/login_store.dart';
import '../../../data/form/login_form.dart';
import 'login_navigate.dart';

class LoginDisplay extends StatefulWidget {
  final LoginStore store;
  final bool returnHome;
  final bool isDialog;

  LoginDisplay(this.store, this.returnHome, this.isDialog);

  @override
  _LoginDisplayState createState() => _LoginDisplayState();
}

class _LoginDisplayState extends State<LoginDisplay> {
  static final GlobalKey<FormState> _formKey =
      new GlobalKey(debugLabel: 'form');
  final GlobalKey<CustomizeFieldWidgetState> _nameFieldKey =
      new GlobalKey(debugLabel: 'name');
  final GlobalKey<CustomizeFieldWidgetState> _pwdFieldKey =
      new GlobalKey(debugLabel: 'pwd');
  final GlobalKey<CheckboxWidgetState> _fastKey =
      new GlobalKey(debugLabel: 'fast');

  bool _useFastLoginData = false;
  bool _waitForClose = false;
  int _loadingStack = 0;
  LoginHiveForm _hiveForm;

  Widget formWidget;

  void _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
//      print('The user wants to login with $_username and $_password');
      _hiveForm = LoginHiveForm(
        account: _nameFieldKey.currentState.getInput,
        password: _pwdFieldKey.currentState.getInput,
        fastLogin: _fastKey.currentState.boxChecked,
      );
      if (_hiveForm.isValid)
        widget.store.login(_hiveForm.simple, _hiveForm.fastLogin);
      else
        FLToast.showText(
          text: localeStr.messageActionFillForm,
          position: FLToastPosition.top,
          showDuration: ToastDuration.DEFAULT.value,
        );
    }
  }

  void _updateFields() {
    if (!_useFastLoginData &&
        _hiveForm != null &&
        _nameFieldKey != null &&
        _pwdFieldKey != null) {
      _useFastLoginData = true;
      try {
        _fastKey.currentState.setChecked = _hiveForm.fastLogin;
        if (_hiveForm.fastLogin) {
          Future.delayed(Duration(milliseconds: 100), () {
            _nameFieldKey.currentState.setInput = _hiveForm.account;
          });
          Future.delayed(Duration(milliseconds: 200), () {
            _pwdFieldKey.currentState.setInput = _hiveForm.password;
          });
        }
      } catch (e) {
        MyLogger.error(msg: 'update dialog failed!! $e', error: e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    formWidget ??= _buildFormWidget();
    return Stack(
      children: [
        Positioned(
          top: (widget.isDialog == false) ? 34 : 14,
          right: (widget.isDialog == false) ? 16 : 42,
          child: Container(
            height: 14,
            width: 14,
            child: IndexedStack(
              index: _loadingStack,
              children: [
                Observer(
                  builder: (_) {
                    if (widget.store.waitForHive)
                      return CircularProgressIndicator(strokeWidth: 3.0);

                    if (widget.store.hiveLoginForm != null) {
                      _hiveForm = widget.store.hiveLoginForm;

                      if (_hiveForm != null)
                        Future.delayed(Duration(milliseconds: 200), () {
                          if (!mounted) return;
                          if (_loadingStack != 1)
                            setState(() {
                              _loadingStack = 1;
                            });
                          _updateFields();
                        });
                    }
                    return SizedBox.shrink();
                  },
                ),
                Observer(builder: (_) {
                  if (widget.store.waitForLogin)
                    return CircularProgressIndicator(
                      strokeWidth: 3.0,
                    );
                  else if (getRouteUserStreams.hasUser && !_waitForClose) {
                    _waitForClose = true;
                    return LoginNavigate(
                      returnHomePage: widget.returnHome,
                      closeDialog: widget.isDialog,
                    );
                  }
                  return SizedBox.shrink();
                }),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 30.0, 16.0, 8.0),
          child: formWidget,
        ),
      ],
    );
  }

  Widget _buildFormWidget() {
    return InkWell(
      // to dismiss the keyboard when the user tabs out of the TextField
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: new Form(
        key: _formKey,
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            /* Login Hint Text*/
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                localeStr.hintTitleLogin,
                textAlign: TextAlign.left,
                style: TextStyle(color: Themes.defaultHintColor),
              ),
            ),
            new CustomizeFieldWidget(
              key: _nameFieldKey,
              fieldType: FieldType.Normal,
              hint: localeStr.hintAccount,
              prefixIconData: const IconData(0xf2bd, fontFamily: 'FontAwesome'),
              errorMsg: localeStr.messageInvalidAccount,
              validCondition: (value) =>
                  rangeCheck(value: value.length, min: 6, max: 12),
            ),
            new CustomizeFieldWidget(
              key: _pwdFieldKey,
              fieldType: FieldType.Password,
              hint: localeStr.hintAccountPassword,
              prefixIconData: const IconData(0xf13e, fontFamily: 'FontAwesome'),
              maxInputLength: 20,
              errorMsg: localeStr.messageInvalidPassword,
              validCondition: (value) =>
                  rangeCheck(value: value.length, min: 6, max: 20),
            ),
            /* Login CheckBox */
            CheckboxWidget(
              key: _fastKey,
              label: localeStr.btnFastLogin,
              initValue: _hiveForm?.fastLogin ?? false,
            ),
            /* Login Buttons */
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      child: Text(localeStr.btnLogin),
                      textColor: Themes.defaultTextColorBlack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      onPressed: () {
                        // clear text field focus
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _validateForm();
                      },
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: RaisedButton(
                        child: Text(localeStr.btnResetPassword),
                        color: Themes.buttonDisabledColor,
                        textColor: Themes.buttonDisabledTextColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        onPressed: () {
                          RouterNavigate.navigateToPage(
                            RoutePage.service,
                            arg: WebRouteArguments(
                              startUrl: Global.TY_SERVICE_URL,
                            ),
                          );
                          // close dialog
                          if (widget.isDialog) Navigator.of(context).pop();
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
