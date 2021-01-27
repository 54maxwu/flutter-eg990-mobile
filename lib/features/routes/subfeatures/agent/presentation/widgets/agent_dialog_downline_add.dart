import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_titled_container.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/dialog_widget.dart';
import 'package:flutter_eg990_mobile/utils/value_util.dart';

import '../../data/form/agent_downline_form.dart';

typedef OnSubmitDownlineAgent = Future<bool> Function(AgentDownlineForm);

class AgentDialogDownlineAdd extends StatefulWidget {
  final OnSubmitDownlineAgent onSubmit;
  final Function onRefresh;

  AgentDialogDownlineAdd({this.onSubmit, this.onRefresh});

  @override
  _AgentDialogDownlineAddState createState() => _AgentDialogDownlineAddState();
}

class _AgentDialogDownlineAddState extends State<AgentDialogDownlineAdd> {
  static final GlobalKey<FormState> _formKey =
      new GlobalKey(debugLabel: 'form');

  final GlobalKey<CustomizeFieldWidgetState> _accountFieldKey =
      new GlobalKey(debugLabel: 'name');
  final GlobalKey<CustomizeFieldWidgetState> _pwdFieldKey =
      new GlobalKey(debugLabel: 'pwd');
  final GlobalKey<CustomizeFieldWidgetState> _confirmFieldKey =
      new GlobalKey(debugLabel: 'confirm');
  final GlobalKey<CustomizeFieldWidgetState> _phoneFieldKey =
      new GlobalKey(debugLabel: 'phone');
  final GlobalKey<CustomizeFieldWidgetState> _contactFieldKey =
      new GlobalKey(debugLabel: 'contact');

  CancelFunc _toastDismiss;

  double _errorTextPadding;

  bool _showAccountError = false;
  bool _showPasswordError = false;
  bool _showConfirmError = false;
  bool _showPhoneError = false;
  bool _showContactError = false;

  void _validateForm() async {
    if (_toastDismiss != null) return;
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
//      debugPrint('The user wants to login with $_username and $_password');
      AgentDownlineForm regForm = AgentDownlineForm(
        username: _accountFieldKey.currentState.getInput,
        password: _pwdFieldKey.currentState.getInput,
        confirmPassword: _confirmFieldKey.currentState.getInput,
        phone: _phoneFieldKey.currentState.getInput,
        appContact: _contactFieldKey.currentState.getInput,
      );
      if (regForm.isValid && widget.onSubmit != null) {
        _toastDismiss = callToastLoading();
        bool success = await widget.onSubmit(regForm);
        if (_toastDismiss != null) {
          _toastDismiss();
          _toastDismiss = null;
        }
        if (success) {
          callToastInfo(localeStr.messageSuccess,
              icon: Icons.check_circle_outline);
          if (widget.onRefresh != null) widget.onRefresh();
          Navigator.of(context).pop();
        } else {
          callToastError(
              localeStr.messageTaskFailed(localeStr.agentDownlineButtonAdd));
        }
      } else {
        callToast(localeStr.messageActionFillForm);
      }
    }
  }

  @override
  void initState() {
    _errorTextPadding = (Global.device.width.roundToDouble() - 24.0) *
            ThemeInterface.prefixTextWidthFactor -
        ThemeInterface.minusSize +
        4.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      heightFactor: 0.5,
      maxHeight: 424,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                localeStr.agentDownlineButtonAdd,
                style: TextStyle(
                  fontSize: FontSize.TITLE.value,
                  color: themeColor.dialogTitleColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                primary: true,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: [
                  new Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        ///
                        /// Account Field
                        ///
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: new CustomizeTitledContainer(
                            prefixText: localeStr.registerFieldTitleAccount,
                            requiredInput: true,
                            roundCorner: false,
                            child: new CustomizeFieldWidget(
                              key: _accountFieldKey,
                              fieldType: FieldType.Account,
                              hint: localeStr.hintAccountInput,
                              persistHint: false,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 0.0),
                              maxInputLength: InputLimit.ACCOUNT_MAX,
                              roundCorner: false,
                              onInputChanged: (input) {
                                setState(() {
                                  _showAccountError = !rangeCheck(
                                    value: input.length,
                                    min: InputLimit.ACCOUNT_MIN,
                                    max: InputLimit.ACCOUNT_MAX,
                                  );
                                });
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: _errorTextPadding),
                              child: Visibility(
                                visible: _showAccountError,
                                child: Text(
                                  localeStr.messageInvalidAccount(
                                    InputLimit.AGENT_ACCOUNT_MIN,
                                    InputLimit.AGENT_ACCOUNT_MAX,
                                  ),
                                  style: TextStyle(
                                      color: themeColor.defaultErrorColor),
                                ),
                              ),
                            ),
                          ],
                        ),

                        ///
                        /// Password Field
                        ///
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: new CustomizeTitledContainer(
                            prefixText: localeStr.registerFieldTitlePassword,
                            requiredInput: true,
                            roundCorner: false,
                            child: new CustomizeFieldWidget(
                              key: _pwdFieldKey,
                              fieldType: FieldType.Password,
                              hint: localeStr.hintAccountPassword,
                              persistHint: false,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 0.0),
                              roundCorner: false,
                              maxInputLength: InputLimit.PASSWORD_MAX,
                              onInputChanged: (input) {
                                setState(() {
                                  _showPasswordError = !rangeCheck(
                                    value: input.length,
                                    min: InputLimit.PASSWORD_MIN,
                                    max: InputLimit.PASSWORD_MAX,
                                  );
                                });
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: _errorTextPadding),
                              child: Visibility(
                                visible: _showPasswordError,
                                child: Text(
                                  localeStr.messageInvalidPassword(
                                    InputLimit.PASSWORD_MIN,
                                    InputLimit.PASSWORD_MAX,
                                  ),
                                  style: TextStyle(
                                      color: themeColor.defaultErrorColor),
                                ),
                              ),
                            ),
                          ],
                        ),

                        ///
                        /// Confirm Password Field
                        ///
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: new CustomizeTitledContainer(
                            prefixText: localeStr.registerFieldTitleConfirm,
                            titleLetterSpacing: 2.0,
                            backgroundColor: Colors.transparent,
                            requiredInput: true,
                            roundCorner: false,
                            child: new CustomizeFieldWidget(
                              key: _confirmFieldKey,
                              fieldType: FieldType.Password,
                              hint: localeStr.hintConfirmedInput,
                              persistHint: false,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 0.0),
                              maxInputLength: InputLimit.PASSWORD_MAX,
                              roundCorner: false,
                              onInputChanged: (input) {
                                setState(() {
                                  _showConfirmError = input.isEmpty ||
                                      input !=
                                          _pwdFieldKey.currentState.getInput;
                                });
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: _errorTextPadding),
                              child: Visibility(
                                visible: _showConfirmError,
                                child: Text(
                                  localeStr.messageInvalidConfirmPassword,
                                  style: TextStyle(
                                      color: themeColor.defaultErrorColor),
                                ),
                              ),
                            ),
                          ],
                        ),

                        ///
                        /// Phone Field
                        ///
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: new CustomizeTitledContainer(
                            prefixText: localeStr.registerFieldTitlePhone,
                            requiredInput: true,
                            roundCorner: false,
                            child: new CustomizeFieldWidget(
                              key: _phoneFieldKey,
                              fieldType: FieldType.Numbers,
                              hint: localeStr.hintPhoneInput,
                              persistHint: false,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 0.0),
                              maxInputLength: InputLimit.PHONE_MAX,
                              roundCorner: false,
                              onInputChanged: (input) {
                                setState(() {
                                  _showPhoneError =
                                      input.length != InputLimit.PHONE_MAX;
                                });
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: _errorTextPadding),
                              child: Visibility(
                                visible: _showPhoneError,
                                child: Text(
                                  localeStr.messageInvalidPhone(
                                      InputLimit.PHONE_MAX),
                                  style: TextStyle(
                                      color: themeColor.defaultErrorColor),
                                ),
                              ),
                            ),
                          ],
                        ),

                        ///
                        /// App-Contact Field
                        ///
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: new CustomizeTitledContainer(
                            prefixText: localeStr.registerFieldTitleLine,
                            requiredInput: true,
                            roundCorner: false,
                            child: new CustomizeFieldWidget(
                              key: _contactFieldKey,
                              hint: '',
                              persistHint: false,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 0.0),
                              maxInputLength: InputLimit.WECHAT_MAX,
                              roundCorner: false,
                              onInputChanged: (input) {
                                setState(() {
                                  _showContactError = !rangeCheck(
                                    value: input.length,
                                    min: InputLimit.WECHAT_MIN,
                                    max: InputLimit.WECHAT_MAX,
                                  );
                                });
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: _errorTextPadding),
                              child: Visibility(
                                visible: _showContactError,
                                child: Text(
                                  localeStr.messageInvalidFormat,
                                  style: TextStyle(
                                      color: themeColor.defaultErrorColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  ///
                  /// Confirm Button
                  ///
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: RaisedButton(
                            child: Text(localeStr.btnSubmit),
                            onPressed: () {
                              // clear text field focus
                              FocusScope.of(context).unfocus();
                              // validate and send request
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
          ],
        ),
      ],
    );
  }
}
