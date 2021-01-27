import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_titled_container.dart';
import 'package:flutter_eg990_mobile/features/router/app_navigator_export.dart';
import 'package:flutter_eg990_mobile/features/user/data/entity/user_entity.dart';
import 'package:flutter_eg990_mobile/features/user/login/presentation/widgets/login_navigate.dart';

import '../../../data/form/register_form.dart';
import '../state/register_store.dart';
import 'register_store_inherited_widget.dart';

class RegisterFormWidget extends StatefulWidget {
  final double parentPadding;
  final bool transparent;
  final bool isDialog;

  RegisterFormWidget(this.parentPadding, this.transparent,
      {this.isDialog = false});

  @override
  _RegisterFormWidgetState createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final GlobalKey<FormState> _formKey = new GlobalKey(debugLabel: 'form');

  final GlobalKey<CustomizeFieldWidgetState> _accountFieldKey =
      new GlobalKey(debugLabel: 'name');
  final GlobalKey<CustomizeFieldWidgetState> _pwdFieldKey =
      new GlobalKey(debugLabel: 'pwd');
  final GlobalKey<CustomizeFieldWidgetState> _confirmFieldKey =
      new GlobalKey(debugLabel: 'confirm');
  final GlobalKey<CustomizeFieldWidgetState> _phoneFieldKey =
      new GlobalKey(debugLabel: 'phone');
  final GlobalKey<CustomizeFieldWidgetState> _introFieldKey =
      new GlobalKey(debugLabel: 'intro');
  // final GlobalKey<CheckboxWidgetState> _newsCheckKey =
  //     new GlobalKey(debugLabel: 'news');
  // final GlobalKey<CheckboxWidgetState> _termsCheckKey =
  //     new GlobalKey(debugLabel: 'terms');

  double _fieldInset;
  double _phoneCodeContainerHeight;
  double _errorTextPadding;
  Color _fieldPrefixBg;

  RegisterStore _store;

  bool _showAccountError = false;
  bool _showPasswordError = false;
  bool _showConfirmError = false;
  bool _showPhoneError = false;

  void _validateForm() {
    if (_store == null || _store.waitForRegister) return;
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
//      debugPrint('The user wants to login with $_username and $_password');
      RegisterForm regForm = RegisterForm(
        username: _accountFieldKey.currentState.getInput,
        password: _pwdFieldKey.currentState.getInput,
        confirmPassword: _confirmFieldKey.currentState.getInput,
        mobileno: _phoneFieldKey.currentState.getInput,
        intro: _introFieldKey.currentState.getInput,
      );
      // if (regForm.isValid && _termsCheckKey.currentState.boxChecked) {
      if (regForm.isValid) {
        _store.postRegister(regForm);
      } else {
        callToast(localeStr.messageActionFillForm);
      }
    }
  }

  @override
  void initState() {
    _fieldInset = widget.parentPadding;
    _fieldPrefixBg = (widget.transparent)
        ? Colors.transparent
        : themeColor.fieldPrefixBgColor;
    _phoneCodeContainerHeight = ((Global.device.isIos)
            ? ThemeInterface.fieldHeight + 8
            : ThemeInterface.fieldHeight) -
        ThemeInterface.minusSize;
    _errorTextPadding = (Global.device.width.roundToDouble() - _fieldInset) *
            ThemeInterface.prefixTextWidthFactor -
        ThemeInterface.minusSize +
        10.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _store ??= RegisterStoreInheritedWidget.of(context).store;
    if (_store == null) {
      return Center(
        child: WarningDisplay(
          message:
              Failure.internal(FailureCode(type: FailureType.INHERIT)).message,
        ),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
//        SizedBox(height: 24.0),
        new Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              ///
              /// Account Field
              ///
              ///
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: new CustomizeTitledContainer(
                  prefixText: localeStr.registerFieldTitleAccount,
                  prefixBgColor: _fieldPrefixBg,
                  backgroundColor: themeColor.fieldPrefixBgColor,
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
                        localeStr.messageInvalidAccount(
                          InputLimit.ACCOUNT_MIN,
                          InputLimit.ACCOUNT_MAX,
                        ),
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
                  prefixBgColor: _fieldPrefixBg,
                  backgroundColor: Colors.transparent,
                  requiredInput: true,
                  roundCorner: false,
                  child: new CustomizeFieldWidget(
                    key: _pwdFieldKey,
                    fieldType: FieldType.Password,
                    hint: localeStr.hintAccountPassword,
                    persistHint: false,
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    roundCorner: false,
                    maxInputLength: InputLimit.PASSWORD_MAX,
                    onInputChanged: (input) {
                      setState(() {
                        _showPasswordError = !rangeCheck(
                          value: input.length,
                          min: InputLimit.PASSWORD_MIN_OLD,
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
                          InputLimit.PASSWORD_MIN_OLD,
                          InputLimit.PASSWORD_MAX,
                        ),
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
                  prefixBgColor: _fieldPrefixBg,
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
                  prefixTextSize: FontSize.SUBTITLE.value,
                  prefixBgColor: _fieldPrefixBg,
                  backgroundColor: Colors.transparent,
                  horizontalInset: _fieldInset,
                  requiredInput: true,
                  roundCorner: false,
                  child: new CustomizeFieldWidget(
                    key: _phoneFieldKey,
                    fieldType: FieldType.Numbers,
                    hint: localeStr.hintPhoneInput,
                    persistHint: false,
                    roundCorner: false,
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    maxInputLength: InputLimit.PHONE_MAX,
                    onInputChanged: (input) {
                      setState(() {
                        _showPhoneError = !rangeCheck(
                          value: input.length,
                          min: InputLimit.PHONE_MIN,
                          max: InputLimit.PHONE_MAX,
                        );
                      });
                    },
                  ),
                  // child: Row(
                  //   mainAxisSize: MainAxisSize.max,
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   crossAxisAlignment: CrossAxisAlignment.stretch,
                  //   children: [
                  //     Container(
                  //       width: 64.0,
                  //       height: _phoneCodeContainerHeight,
                  //       color: themeColor.fieldInputBgColor,
                  //       alignment: Alignment.center,
                  //       child: Text(
                  //         '+84',
                  //         style: TextStyle(fontSize: FontSize.SUBTITLE.value),
                  //       ),
                  //     ),
                  //     SizedBox(width: 8.0),
                  //     Expanded(
                  //       child: new CustomizeFieldWidget(
                  //         key: _phoneFieldKey,
                  //         fieldType: FieldType.Numbers,
                  //         hint: localeStr.hintPhoneInput,
                  //         persistHint: false,
                  //         roundCorner: false,
                  //         padding: const EdgeInsets.symmetric(vertical: 0.0),
                  //         maxInputLength: InputLimit.PHONE_MAX,
                  //         onInputChanged: (input) {
                  //           setState(() {
                  //             _showPhoneError = !rangeCheck(
                  //               value: input.length,
                  //               min: InputLimit.PHONE_MIN,
                  //               max: InputLimit.PHONE_MAX,
                  //             );
                  //           });
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
              /// Referral Code Field
              ///
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: new CustomizeTitledContainer(
                  prefixText: localeStr.registerFieldTitleRecommend,
                  prefixBgColor: _fieldPrefixBg,
                  backgroundColor: themeColor.fieldPrefixBgColor,
                  roundCorner: false,
                  child: new CustomizeFieldWidget(
                    key: _introFieldKey,
                    fieldType: FieldType.Numbers,
                    hint: localeStr.hintReferralInput,
                    persistHint: false,
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    maxInputLength: InputLimit.RECOMMEND,
                    roundCorner: false,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Padding(
        //   padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 0.0),
        //   child: Divider(height: 16.0),
        // ),
        //
        // ///
        // /// Promo News Check Box
        // ///
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        //   child: CheckboxWidget(
        //     key: _newsCheckKey,
        //     widgetPadding: EdgeInsets.zero,
        //     textPadding: const EdgeInsets.only(left: 8.0),
        //     label: localeStr.registerCheckButtonNews,
        //     boxBackgroundColor: themeColor.fieldInputBgColor,
        //     textSize: FontSize.SUBTITLE.value,
        //     scale: 1.25,
        //   ),
        // ),
        //
        // ///
        // /// Terms Check Box
        // ///
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        //   child: CheckboxWidget(
        //     key: _termsCheckKey,
        //     widgetPadding: EdgeInsets.zero,
        //     textPadding: const EdgeInsets.only(left: 8.0),
        //     label: localeStr.registerCheckButtonTerms,
        //     boxBackgroundColor: themeColor.fieldInputBgColor,
        //     textSize: FontSize.SUBTITLE.value,
        //     maxLines: 2,
        //     scale: 1.25,
        //   ),
        // ),

        ///
        /// Confirm Button
        ///
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 24.0),
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

        ///
        /// Customer Service Hint
        ///
//        Padding(
//          padding: const EdgeInsets.symmetric(horizontal: 20.0),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: [
//              IconButton(
//                visualDensity: VisualDensity.compact,
//                padding: EdgeInsets.zero,
//                icon: Icon(
//                  const IconData(0xf27a, fontFamily: 'FontAwesome'),
//                  color: themeColor.defaultTextColor,
//                ),
//                onPressed: () {
//                  AppNavigator.navigateToPage(
//                    RoutePage.service,
//                    arg: WebRouteArguments(
//                      startUrl: Global.currentService,
//                      hideBars: true,
//                    ),
//                  );
//                },
//              ),
//              Expanded(
//                child: Text(
//                  localeStr.registerButtonServiceHint,
//                  style: TextStyle(fontSize: FontSize.SUBTITLE.value),
//                  maxLines: 3,
//                  overflow: TextOverflow.visible,
//                ),
//              ),
//            ],
//          ),
//        ),

        ///
        /// Auto Login
        ///
        StreamBuilder(
          stream: _store.loginStream,
          builder: (_, snapshot) {
            if (snapshot != null && snapshot.data != null) {
              if (snapshot.data is UserEntity) {
                return LoginNavigate(
                  user: snapshot.data,
                  closeDialog: widget.isDialog,
                );
              } else if (snapshot.data is String) {
                callToastError(localeStr.messageErrorAutoLogin);
                Future.delayed(
                  Duration(milliseconds: 500),
                  () => AppNavigator.navigateTo(RoutePage.login),
                );
              }
            }
            return SizedBox.shrink();
          },
        ),
        SizedBox(height: 24.0),
      ],
    );
  }
}
