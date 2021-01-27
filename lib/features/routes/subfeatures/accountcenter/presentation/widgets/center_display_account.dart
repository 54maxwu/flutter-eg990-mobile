import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_eg990_mobile/features/router/app_navigator_export.dart';
import 'package:flutter_eg990_mobile/utils/datetime_format.dart';
import 'package:flutter_eg990_mobile/utils/regex_util.dart';

import '../../data/entity/center_account_entity.dart'
    show CenterAccountEntity, CenterAccountEntityExtension;
import '../state/center_store.dart';
import 'center_dialog_mobile.dart';
import 'center_store_inherit_widget.dart';

class CenterDisplayAccount extends StatefulWidget {
  @override
  _CenterDisplayAccountState createState() => _CenterDisplayAccountState();
}

class _CenterDisplayAccountState extends State<CenterDisplayAccount>
    with AfterLayoutMixin {
  static final Key _streamKey = new Key('accountstream');

  final GlobalKey<FormState> _formKey = new GlobalKey(debugLabel: 'dataform');

  final GlobalKey<CustomizeFieldWidgetState> _accountFieldKey =
      new GlobalKey(debugLabel: 'account');
  final GlobalKey<CustomizeFieldWidgetState> _nameFieldKey =
      new GlobalKey(debugLabel: 'name');
  final GlobalKey<CustomizeFieldWidgetState> _birthFieldKey =
      new GlobalKey(debugLabel: 'birth');
  final GlobalKey<CustomizeFieldWidgetState> _phoneFieldKey =
      new GlobalKey(debugLabel: 'phone');
  final GlobalKey<CustomizeFieldWidgetState> _mailFieldKey =
      new GlobalKey(debugLabel: 'mail');
  // final GlobalKey<CustomizeFieldWidgetState> _wechatFieldKey =
  //     new GlobalKey(debugLabel: 'wechat');
  // final GlobalKey<CustomizeFieldWidgetState> _zaloFieldKey =
  //     new GlobalKey(debugLabel: 'wechat');

  CenterStore _store;
  CenterAccountEntity _storeData;
  bool layoutReady = false;
  Widget contentWidget;

  void updateField() {
    if (_store == null) return;
    List<String> initTexts = _store.accountEntity.getInitInput;
    debugPrint('field data: $initTexts');
    _accountFieldKey.currentState.setInput = initTexts[0];
    _nameFieldKey.currentState.setInput = initTexts[1];
    _birthFieldKey.currentState.setInput = initTexts[2];
    _phoneFieldKey.currentState.setInput = initTexts[3];
    _mailFieldKey.currentState.setInput = initTexts[4];
    // _wechatFieldKey.currentState.setInput = initTexts[5];
    // _zaloFieldKey.currentState.setInput = initTexts[6];
    debugPrint('field updated');
  }

  void checkAndPost(BuildContext context, Function postCall) {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_store == null) return;
    if (_store.waitForResponse) {
      callToast(localeStr.messageWait);
      return;
    }
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      postCall();
    }
  }

  @override
  Widget build(BuildContext context) {
    _store ??= CenterStoreInheritedWidget.of(context).store;
    if (_store == null) {
      return Center(
        child: WarningDisplay(
          message:
              Failure.internal(FailureCode(type: FailureType.INHERIT)).message,
        ),
      );
    }
    return StreamBuilder(
      key: _streamKey,
      stream: _store.accountStream,
      builder: (context, snapshot) {
//        debugPrint('account stream snapshot: $snapshot');
        if (_storeData != _store.accountEntity) {
          _storeData = _store.accountEntity;
          if (layoutReady) updateField();
          contentWidget = _buildContent();
        }
        contentWidget ??= _buildContent();
        return contentWidget;
      },
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(bottom: 4.0),
        constraints: BoxConstraints(
          maxWidth: Global.device.width - 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
              child: Text(
                localeStr.centerViewTitleData,
                style: TextStyle(
                  color: themeColor.secondaryTextColor2,
                ),
              ),
            ),
            InkWell(
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
                  primary: false,
                  shrinkWrap: true,
                  children: <Widget>[
                    /* Account Field */
                    new CustomizeFieldWidget(
                      key: _accountFieldKey,
                      hint: '',
                      persistHint: false,
                      prefixText: localeStr.centerTextTitleAccount,
                      maxInputLength: InputLimit.ACCOUNT_MAX,
                      titleLetterSpacing: 4,
                      suffixText: localeStr.centerTextButtonChangePwd,
                      suffixAction: (account) {
                        AppNavigator.navigateTo(RoutePage.centerPassword,
                            arg: CenterDisplayAccountPasswordArguments(
                                store: _store));
                      },
                      readOnly: true,
                    ),
                    /* Name Field */
                    new CustomizeFieldWidget(
                      key: _nameFieldKey,
                      hint: localeStr.centerHintNoName,
                      persistHint: false,
                      coloredHint: true,
                      maxInputLength: InputLimit.NAME_MAX,
                      prefixText: localeStr.centerTextTitleName,
                      suffixText: (_storeData.canBindCard)
                          ? localeStr.centerTextButtonBind
                          : null,
                      suffixAction: (_) {
                        AppNavigator.navigateTo(RoutePage.bankcard);
                      },
                      readOnly: true,
                    ),
                    /* Birth Date Field */
                    new CustomizeFieldWidget(
                      key: _birthFieldKey,
                      fieldType: FieldType.Date,
                      maxInputLength: InputLimit.DATE,
                      hint: localeStr.centerTextTitleDateHint,
                      persistHint: false,
                      prefixText: localeStr.centerTextTitleBirth,
                      suffixText: (_storeData.canBindBirthDate)
                          ? localeStr.centerTextButtonBind
                          : null,
                      suffixAction: (input) {
                        debugPrint('request bind birth date: $input');
                        checkAndPost(context, () {
                          if (input.isDate) {
                            if (checkDateRange(input, getDate())) {
                              _store.bindBirth(input);
                            } else {
                              callToast(localeStr.messageInvalidDate);
                            }
                          } else {
                            callToast(localeStr.messageInvalidFormat);
                          }
                        });
                      },
                      readOnly: _storeData.canBindBirthDate == false,
                      errorMsg: localeStr.messageInvalidFormat,
                      validCondition: (input) => input.isDate,
                    ),
                    /* Phone Field */
                    new CustomizeFieldWidget(
                      key: _phoneFieldKey,
                      hint: '',
                      persistHint: false,
                      prefixText: localeStr.centerTextTitlePhone,
                      maxInputLength: InputLimit.PHONE_MAX,
                      titleLetterSpacing: 4,
                      // suffixText: (_storeData.canVerifyPhone)
                      //     ? localeStr.centerTextButtonSend
                      //     : null,
                      // suffixAction: (_) {
                      //   showDialog(
                      //     context: context,
                      //     barrierDismissible: false,
                      //     builder: (context) => new CenterDialogMobile(
                      //       store: _store,
                      //       mobile: _phoneFieldKey.currentState.getInput
                      //           .split('(')[0],
                      //     ),
                      //   );
                      // },
                      readOnly: true,
                    ),
                    /* E-Mail Field */
                    new CustomizeFieldWidget(
                      key: _mailFieldKey,
                      fieldType: FieldType.Email,
                      hint: '',
                      persistHint: false,
                      prefixText: localeStr.centerTextTitleMail,
                      suffixText: (_storeData.canBindMail)
                          ? localeStr.centerTextButtonBind
                          : null,
                      suffixAction: (input) {
                        debugPrint('request bind email: $input');
                        checkAndPost(context, () {
                          if (input.isEmail)
                            _store.bindEmail(input);
                          else
                            callToast(localeStr.messageInvalidFormat);
                        });
                      },
                      readOnly: _storeData.canBindMail == false,
                      validCondition: (value) => value.isEmail,
                      errorMsg: localeStr.messageInvalidEmail,
                      maxInputLength: InputLimit.ADDRESS_MAX,
                    ),
                    // /* WeChat Field */
                    // new CustomizeFieldWidget(
                    //   key: _zaloFieldKey,
                    //   hint: '',
                    //   persistHint: false,
                    //   prefixText: 'Zalo',
                    //   suffixText: (_storeData.canBindZalo)
                    //       ? localeStr.centerTextButtonBind
                    //       : null,
                    //   suffixAction: (input) {
                    //     debugPrint('request bind zalo: $input');
                    //     if (input.isNotEmpty) {
                    //       checkAndPost(context, () {
                    //         _store.bindZalo(input);
                    //       });
                    //     } else {
                    //       callToast(localeStr.messageInvalidFormat);
                    //     }
                    //   },
                    //   readOnly: _storeData.canBindZalo == false,
                    //   validCondition: (value) => rangeCheck(
                    //       value: value.length,
                    //       min: InputLimit.WECHAT_MIN,
                    //       max: InputLimit.WECHAT_MAX),
                    //   errorMsg: localeStr.messageInvalidZalo,
                    //   maxInputLength: InputLimit.WECHAT_MAX,
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    layoutReady = true;
    updateField();
    setState(() {});
  }
}
