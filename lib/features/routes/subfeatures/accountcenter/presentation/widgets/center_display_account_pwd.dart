import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_eg990_mobile/features/router/app_navigator.dart';

import '../../data/form/center_password_form.dart';
import '../state/center_store.dart';

class CenterDisplayAccountPassword extends StatefulWidget {
  final CenterStore store;

  CenterDisplayAccountPassword({@required this.store});

  @override
  _CenterDisplayAccountPasswordState createState() =>
      _CenterDisplayAccountPasswordState();
}

class _CenterDisplayAccountPasswordState
    extends State<CenterDisplayAccountPassword> {
  final GlobalKey<FormState> _formKey = new GlobalKey(debugLabel: 'form');
  final GlobalKey<CustomizeFieldWidgetState> _oldPwdFieldKey =
      new GlobalKey(debugLabel: 'oldpwd');
  final GlobalKey<CustomizeFieldWidgetState> _newPwdFieldKey =
      new GlobalKey(debugLabel: 'newpwd');
  final GlobalKey<CustomizeFieldWidgetState> _conPwdFieldKey =
      new GlobalKey(debugLabel: 'conpwd');

  @override
  void initState() {
    widget.store.initLoginDataBox();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.store == null) {
      return Center(
        child: WarningDisplay(
          message:
              Failure.internal(FailureCode(type: FailureType.INHERIT)).message,
        ),
      );
    }
    return WillPopScope(
      onWillPop: () {
        debugPrint('pop center password route');
        AppNavigator.back();
        return Future(() => true);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: InkWell(
          // to dismiss the keyboard when the user tabs out of the TextField
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 30.0, 16.0, 8.0),
            child: new Form(
              key: _formKey,
              child: ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  new CustomizeFieldWidget(
                    key: _oldPwdFieldKey,
                    fieldType: FieldType.Password,
                    hint: localeStr.userPwdFieldHintOld,
                    prefixText: localeStr.userPwdFieldTitleOld,
                    titleLetterSpacing: 8,
                    maxInputLength: InputLimit.PASSWORD_MAX,
                    errorMsg: localeStr.messageInvalidPassword(
                      InputLimit.PASSWORD_MIN_OLD,
                      InputLimit.PASSWORD_MAX,
                    ),
                    validCondition: (value) => rangeCheck(
                      value: value.length,
                      min: InputLimit.PASSWORD_MIN_OLD,
                      max: InputLimit.PASSWORD_MAX,
                    ),
                  ),
                  new CustomizeFieldWidget(
                    key: _newPwdFieldKey,
                    fieldType: FieldType.Password,
                    hint: localeStr.userPwdFieldHintNew,
                    prefixText: localeStr.userPwdFieldTitleNew,
                    titleLetterSpacing: 8,
                    maxInputLength: InputLimit.PASSWORD_MAX,
                    errorMsg: localeStr.messageInvalidPassword(
                      InputLimit.PASSWORD_MIN,
                      InputLimit.PASSWORD_MAX,
                    ),
                    validCondition: (value) => rangeCheck(
                      value: value.length,
                      min: InputLimit.PASSWORD_MIN,
                      max: InputLimit.PASSWORD_MAX,
                    ),
                  ),
                  new CustomizeFieldWidget(
                    key: _conPwdFieldKey,
                    fieldType: FieldType.Password,
                    hint: localeStr.userPwdFieldHintConfirm,
                    prefixText: localeStr.userPwdFieldTitleConfirm,
                    titleLetterSpacing: 3,
                    maxInputLength: InputLimit.PASSWORD_MAX,
                    errorMsg: localeStr.messageInvalidConfirmPassword,
                    validCondition: (value) =>
                        _conPwdFieldKey.currentState.getInput ==
                        _newPwdFieldKey.currentState.getInput,
                  ),
                  /* Change Buttons */
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            child: Text(localeStr.centerTextButtonChangePwd),
                            onPressed: () {
                              // clear text field focus
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              _validateForm();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
//      debugPrint('The user wants to login with $_username and $_password');
      CenterPasswordForm pwdForm = CenterPasswordForm(
        oldPwd: _oldPwdFieldKey.currentState.getInput,
        newPwd: _newPwdFieldKey.currentState.getInput,
        confirmPwd: _conPwdFieldKey.currentState.getInput,
      );
      if (pwdForm.isValid)
        widget.store.postPassword(pwdForm);
      else
        callToast(localeStr.messageActionFillForm);
    }
  }
}
