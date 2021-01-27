import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_eg990_mobile/features/user/data/form/login_form.dart';
import 'package:flutter_mobx/flutter_mobx.dart' show Observer;

import '../state/agent_store.dart';
import 'agent_login_navigate.dart';

class AgentLoginDisplay extends StatefulWidget {
  final AgentStore store;

  AgentLoginDisplay({Key key, @required this.store}) : super(key: key);

  @override
  _AgentLoginDisplayState createState() => _AgentLoginDisplayState();
}

class _AgentLoginDisplayState extends State<AgentLoginDisplay> {
  static final GlobalKey<FormState> _formKey =
      new GlobalKey(debugLabel: 'form');
  final GlobalKey<CustomizeFieldWidgetState> _accountFieldKey =
      new GlobalKey(debugLabel: 'name');
  final GlobalKey<CustomizeFieldWidgetState> _pwdFieldKey =
      new GlobalKey(debugLabel: 'pwd');

  List<ReactionDisposer> _disposers;
  bool _loginSuccess = false;
  bool _waiting = false;
  Widget formWidget;

  void _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      // debugPrint('The user wants to login with $_username and $_password');
      LoginForm _loginForm = LoginForm(
        account: _accountFieldKey.currentState.getInput,
        password: _pwdFieldKey.currentState.getInput,
      );
      if (_loginForm.isValid) {
        widget.store.loginAgent(_loginForm);
      } else {
        _waiting = false;
        callToast(localeStr.messageActionFillForm);
      }
    } else {
      _waiting = false;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.waitForAgentLogin,
        // Run some logic with the content of the observed field
        (bool wait) {
          debugPrint('reaction on wait for agent login: $wait');
          if (!wait && _waiting) {
            _waiting = false;
            if (widget.store.agent.hasValidToken) {
              setState(() {
                _loginSuccess = true;
              });
            } else {
              callToastError(localeStr.messageLoginFailed);
            }
          }
        },
      ),
    ];
  }

  @override
  void didUpdateWidget(AgentLoginDisplay oldWidget) {
    debugPrint('didUpdateWidget');
    formWidget = null;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('rebuild login display');
    formWidget ??= _buildFormWidget();
    return Stack(
      children: [
        /// loading icon
        Positioned(
          top: 20,
          right: 24,
          child: Observer(
            builder: (context) {
              if (widget.store.waitForAgentLogin)
                return SizedBox(
                  height: 14,
                  width: 14,
                  child: CircularProgressIndicator(strokeWidth: 3.0),
                );
              else
                return SizedBox.shrink();
            },
          ),
        ),

        /// content box
        Container(
          constraints: BoxConstraints(
            maxWidth: Global.device.width,
            maxHeight: Global.device.featureContentHeight,
          ),
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            primary: true,
            child: Container(
              constraints: BoxConstraints(minHeight: 270.0),
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                    child: formWidget,
                  ),

                  ///
                  /// login button
                  ///
                  Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: RaisedButton(
                              child: RichText(
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: localeStr.agentActionLogin,
                                  style: TextStyle(
                                      color: themeColor.buttonTextPrimaryColor),
                                ),
                              ),
                              onPressed: () {
                                if (_waiting) return;
                                _waiting = true;
                                // clear text field focus
                                FocusScope.of(context).unfocus();
                                _validateForm();
                              },
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Expanded(
                            flex: 1,
                            child: RaisedButton(
                              color: themeColor.buttonDisabledColor,
                              child: RichText(
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: localeStr.agentActionRegister,
                                  style: TextStyle(
                                    color: themeColor.buttonDisabledTextColor,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                // clear text field focus
                                FocusScope.of(context).unfocus();
                                // Future.delayed(
                                //     Duration(milliseconds: 100),
                                //     RouterNavigate.navigateToPage(
                                //         RoutePage.agentRegister));
                              },
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
        if (_loginSuccess) AgentLoginNavigate(),
      ],
    );
  }

  Widget _buildFormWidget() {
    debugPrint('rebuild login display form');
    return InkWell(
      // to dismiss the keyboard when the user tabs out of the TextField
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: new Form(
        key: _formKey,
        child: ListView(
          primary: false,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            /* Login Hint Text*/
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                localeStr.agentActionLoginHint,
                textAlign: TextAlign.left,
                style: TextStyle(color: themeColor.defaultHintColor),
              ),
            ),
            new CustomizeFieldWidget(
              key: _accountFieldKey,
              fieldType: FieldType.Account,
              persistHint: false,
              hint: localeStr.hintAccountInput,
              prefixIconData: const IconData(0xf2bd, fontFamily: 'FontAwesome'),
              maxInputLength: InputLimit.AGENT_ACCOUNT_MAX,
              errorMsg: localeStr.messageInvalidAccount(
                InputLimit.AGENT_ACCOUNT_MIN,
                InputLimit.AGENT_ACCOUNT_MAX,
              ),
              validCondition: (value) => rangeCheck(
                value: value.length,
                min: InputLimit.AGENT_ACCOUNT_MIN,
                max: InputLimit.AGENT_ACCOUNT_MAX,
              ),
            ),
            SizedBox(height: 8.0),
            new CustomizeFieldWidget(
              key: _pwdFieldKey,
              fieldType: FieldType.Password,
              persistHint: false,
              hint: localeStr.hintPasswordInput,
              prefixIconData: const IconData(0xf13e, fontFamily: 'FontAwesome'),
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
          ],
        ),
      ),
    );
  }
}
