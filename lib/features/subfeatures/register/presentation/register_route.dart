import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/core/network/handler/request_status_model.dart';
import 'package:flutter_ty_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_ty_mobile/features/user/data/entity/user_entity.dart';
import 'package:flutter_ty_mobile/features/user/login/presentation/widgets/login_navigate.dart';

import '../data/form/register_form.dart';
import 'state/register_store.dart';

class RegisterRoute extends StatefulWidget {
  @override
  _RegisterRouteState createState() => _RegisterRouteState();
}

class _RegisterRouteState extends State<RegisterRoute> {
  static final GlobalKey<FormState> _formKey =
      new GlobalKey(debugLabel: 'form');
  final GlobalKey<CustomizeFieldWidgetState> _nameFieldKey =
      new GlobalKey(debugLabel: 'name');
  final GlobalKey<CustomizeFieldWidgetState> _pwdFieldKey =
      new GlobalKey(debugLabel: 'pwd');
  final GlobalKey<CustomizeFieldWidgetState> _confirmFieldKey =
      new GlobalKey(debugLabel: 'confirm');
  final GlobalKey<CustomizeFieldWidgetState> _introFieldKey =
      new GlobalKey(debugLabel: 'intro');

  RegisterStore _store;
  List<ReactionDisposer> _disposers;
  Function toastDismiss;

  void _validateForm() {
    if (_store == null || _store.waitForRegister) return;
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
//      print('The user wants to login with $_username and $_password');
      RegisterForm regForm = RegisterForm(
        username: _nameFieldKey.currentState.getInput,
        password: _pwdFieldKey.currentState.getInput,
        confirmPassword: _confirmFieldKey.currentState.getInput,
        intro: _introFieldKey.currentState.getInput,
      );
      if (regForm.isValid)
        _store.postRegister(regForm);
      else
        FLToast.showText(
          text: localeStr.messageActionFillForm,
          position: FLToastPosition.top,
          showDuration: ToastDuration.DEFAULT.value,
        );
    }
  }

  @override
  void initState() {
    _store ??= sl.get<RegisterStore>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    super.didChangeDependencies();
    _disposers ??= [
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.errorMessage,
        // Run some logic with the content of the observed field
        (String message) {
          if (message != null && message.isNotEmpty) {
            Future.delayed(Duration(milliseconds: 200)).then(
              (value) => FLToast.showError(
                text: message,
                showDuration: ToastDuration.DEFAULT.value,
              ),
            );
          }
        },
      ),
      /* Reaction on register action */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.waitForRegister,
        // Run some logic with the content of the observed field
        (bool wait) {
          print('reaction on wait register: $wait');
          if (wait) {
            toastDismiss = FLToast.showLoading(
              text: localeStr.messageWait,
            );
          } else if (toastDismiss != null) {
            toastDismiss();
            toastDismiss = null;
          }
        },
      ),
      /* Reaction on register result changed */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.registerResult,
        // Run some logic with the content of the observed field
        (RequestStatusModel result) {
          print('reaction on register result: $result');
          if (result == null) return;
          if (result.isSuccess) {
            FLToast.showSuccess(
              text: localeStr.messageSuccess,
              showDuration: ToastDuration.DEFAULT.value,
            );
          } else {
            FLToast.showError(
              text: result.msg,
              showDuration: ToastDuration.DEFAULT.value,
            );
          }
        },
      ),
    ];
  }

  @override
  void dispose() {
    try {
      _store.closeStreams();
      if (toastDismiss != null) {
        toastDismiss();
        toastDismiss = null;
      }
      _disposers.forEach((d) => d());
    } on Exception {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 6.0),
      alignment: Alignment.topCenter,
      child: InkWell(
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
              new CustomizeFieldWidget(
                key: _nameFieldKey,
                hint: '',
                persistHint: false,
                prefixText: localeStr.registerFieldTitleAccount,
                errorMsg: localeStr.messageInvalidAccount,
                validCondition: (value) =>
                    rangeCheck(value: value.length, min: 6, max: 12),
              ),
              new CustomizeFieldWidget(
                key: _pwdFieldKey,
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                fieldType: FieldType.Password,
                hint: '',
                persistHint: false,
                prefixText: localeStr.registerFieldTitlePassword,
                maxInputLength: 20,
                errorMsg: localeStr.messageInvalidPassword,
                validCondition: (value) =>
                    rangeCheck(value: value.length, min: 6, max: 20),
              ),
              new CustomizeFieldWidget(
                key: _confirmFieldKey,
                fieldType: FieldType.Password,
                hint: '',
                persistHint: false,
                prefixText: localeStr.registerFieldTitleConfirm,
                titleLetterSpacing: 2,
                maxInputLength: 20,
                errorMsg: localeStr.messageInvalidConfirmPassword,
                validCondition: (value) =>
                    rangeCheck(value: value.length, min: 6, max: 20) &&
                    value == _pwdFieldKey.currentState.getInput,
              ),
              new CustomizeFieldWidget(
                key: _introFieldKey,
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                fieldType: FieldType.Numbers,
                hint: '',
                persistHint: false,
                prefixText: localeStr.registerFieldTitleRecommend,
                titleLetterSpacing: 6,
                maxInputLength: 6,
              ),
              /* Register Button */
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        child: Text(localeStr.btnRegister),
                        onPressed: () {
                          // clear text field focus
                          FocusScope.of(context).requestFocus(new FocusNode());
                          // validate and send request
                          _validateForm();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                stream: _store.loginStream,
                builder: (_, snapshot) {
                  if (snapshot != null && snapshot.data != null) {
                    if (snapshot.data is UserEntity) {
                      return LoginNavigate(
                        user: snapshot.data,
                      );
                    } else if (snapshot.data is String) {
                      FLToast.showError(
                        text: localeStr.messageErrorAutoLogin,
                        showDuration: ToastDuration.DEFAULT.value,
                      );
                      Future.delayed(
                        Duration(milliseconds: 500),
                        () => RouterNavigate.navigateToPage(RoutePage.login),
                      );
                    }
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
