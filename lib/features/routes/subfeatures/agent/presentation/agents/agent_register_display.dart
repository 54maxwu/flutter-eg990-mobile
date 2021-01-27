import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/data/error/error_message_map.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/checkbox_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_titled_container.dart';
import 'package:flutter_eg990_mobile/features/router/route_enum.dart';
import 'package:flutter_eg990_mobile/utils/regex_util.dart';

import '../../data/form/agent_register_form.dart';
import '../state/agent_store.dart';

class AgentRegisterDisplay extends StatefulWidget {
  final AgentStore store;

  AgentRegisterDisplay({@required this.store});

  @override
  _AgentRegisterDisplayState createState() => _AgentRegisterDisplayState();
}

class _AgentRegisterDisplayState extends State<AgentRegisterDisplay> {
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
  final GlobalKey<CustomizeFieldWidgetState> _mailFieldKey =
      new GlobalKey(debugLabel: 'mail');
  final GlobalKey<CustomizeFieldWidgetState> _contactFieldKey =
      new GlobalKey(debugLabel: 'contact');

  final GlobalKey<CheckboxWidgetState> _newsCheckKey =
      new GlobalKey(debugLabel: 'news');
  final GlobalKey<CheckboxWidgetState> _termsCheckKey =
      new GlobalKey(debugLabel: 'terms');

  List<ReactionDisposer> _disposers;
  CancelFunc _toastDismiss;

  double _errorTextPadding;

  bool _showAccountError = false;
  bool _showPasswordError = false;
  bool _showConfirmError = false;
  bool _showPhoneError = false;
  bool _showEmailError = false;
  bool _showContactError = false;

  void _validateForm() {
    if (widget.store.waitForAgentRegister) return;
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
//      debugPrint('The user wants to login with $_username and $_password');
      AgentRegisterForm regForm = AgentRegisterForm(
        username: _accountFieldKey.currentState.getInput,
        password: _pwdFieldKey.currentState.getInput,
        confirmPassword: _confirmFieldKey.currentState.getInput,
        phone: _phoneFieldKey.currentState.getInput,
        email: _mailFieldKey.currentState.getInput,
        appContact: _contactFieldKey.currentState.getInput,
      );
      if (_termsCheckKey.currentState.boxChecked == false)
        callToast(localeStr.messageActionCheckTerms);
      else if (regForm.isValid)
        widget.store.registerAgent(regForm);
      else
        callToast(localeStr.messageActionFillForm);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      /* Reaction on register action */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.waitForAgentRegister,
        // Run some logic with the content of the observed field
        (bool wait) {
          debugPrint('reaction on wait agent register: $wait');
          if (wait) {
            _toastDismiss = callToastLoading();
          } else if (_toastDismiss != null) {
            _toastDismiss();
            _toastDismiss = null;
          }
        },
      ),
      /* Reaction on register result changed */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.registerResult,
        // Run some logic with the content of the observed field
        (result) {
          debugPrint('reaction on register result: $result');
          if (result == null) return;
          if (result.isSuccess) {
            callToastInfo(
                MessageMap.getSuccessMessage(
                    result.msg, RouteEnum.AGENT_REGISTER),
                icon: Icons.check_circle_outline);
          } else {
            callToastError(MessageMap.getErrorMessage(
                result.msg, RouteEnum.AGENT_REGISTER));
          }
        },
      ),
    ];
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
    if (widget.store == null) {
      return Center(
        child: WarningDisplay(
          message:
              Failure.internal(FailureCode(type: FailureType.INHERIT)).message,
        ),
      );
    }
    return ListView(
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
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
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
                        localeStr.messageInvalidAccount,
                        style: TextStyle(color: themeColor.defaultErrorColor),
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
                    hint: localeStr.hintPasswordInput,
                    persistHint: false,
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
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
                        localeStr.messageInvalidPasswordNew,
                        style: TextStyle(color: themeColor.defaultErrorColor),
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
                  backgroundColor: Colors.transparent,
                  requiredInput: true,
                  roundCorner: false,
                  child: new CustomizeFieldWidget(
                    key: _confirmFieldKey,
                    fieldType: FieldType.Password,
                    hint: localeStr.hintConfirmedInput,
                    persistHint: false,
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    maxInputLength: InputLimit.PASSWORD_MAX,
                    roundCorner: false,
                    onInputChanged: (input) {
                      setState(() {
                        _showConfirmError = input.isEmpty ||
                            input != _pwdFieldKey.currentState.getInput;
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
                        style: TextStyle(color: themeColor.defaultErrorColor),
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
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    maxInputLength: InputLimit.PHONE_MAX,
                    roundCorner: false,
                    onInputChanged: (input) {
                      setState(() {
                        _showPhoneError = input.length != InputLimit.PHONE_MAX;
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
                        localeStr.messageInvalidPhone(InputLimit.PHONE_MAX),
                        style: TextStyle(color: themeColor.defaultErrorColor),
                      ),
                    ),
                  ),
                ],
              ),

              ///
              /// Mail Field
              ///
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: new CustomizeTitledContainer(
                  prefixText: localeStr.registerFieldTitleEmail,
                  requiredInput: true,
                  roundCorner: false,
                  child: new CustomizeFieldWidget(
                    key: _mailFieldKey,
                    hint: localeStr.hintEmail,
                    persistHint: false,
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    maxInputLength: InputLimit.ADDRESS_MAX,
                    roundCorner: false,
                    onInputChanged: (input) {
                      setState(() {
                        _showEmailError = !rangeCheck(
                          value: input.length,
                          min: 0,
                          max: InputLimit.ADDRESS_MAX,
                        );
                        if (!_showEmailError)
                          _showEmailError = input.isEmail == false;
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
                      visible: _showEmailError,
                      child: Text(
                        localeStr.messageInvalidEmail,
                        style: TextStyle(color: themeColor.defaultErrorColor),
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
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
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
                        style: TextStyle(color: themeColor.defaultErrorColor),
                      ),
                    ),
                  ),
                ],
              ),

              ///
              /// Promo News Check Box
              ///
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: CheckboxWidget(
                  key: _newsCheckKey,
                  widgetPadding: EdgeInsets.zero,
                  textPadding: const EdgeInsets.only(left: 8.0),
                  label: localeStr.registerCheckButtonNews,
                  boxBackgroundColor: themeColor.fieldInputBgColor,
                  scale: 1.25,
                ),
              ),

              ///
              /// Terms Check Box
              ///
              CheckboxWidget(
                key: _termsCheckKey,
                widgetPadding: EdgeInsets.zero,
                textPadding: const EdgeInsets.only(left: 8.0),
                label: localeStr.registerCheckButtonTerms,
                boxBackgroundColor: themeColor.fieldInputBgColor,
                maxLines: 2,
                scale: 1.25,
              ),
            ],
          ),
        ),

        ///
        /// Confirm Button
        ///
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: RaisedButton(
                  child: Text(localeStr.btnRegister),
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
    );
  }
}
