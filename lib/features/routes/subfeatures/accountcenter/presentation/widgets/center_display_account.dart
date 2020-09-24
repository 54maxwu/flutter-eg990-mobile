import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_eg990_mobile/features/router/app_navigate.dart';
import 'package:flutter_eg990_mobile/utils/regex_util.dart';

import '../../data/entity/center_account_entity.dart'
    show CenterAccountEntity, CenterAccountEntityExtension;
import '../state/center_store.dart';
import 'center_dialog_cpw.dart';
import 'center_dialog_mobile.dart';
import 'center_store_inherit_widget.dart';

class CenterDisplayAccount extends StatefulWidget {
  @override
  _CenterDisplayAccountState createState() => _CenterDisplayAccountState();
}

class _CenterDisplayAccountState extends State<CenterDisplayAccount>
    with AfterLayoutMixin {
  static final Key _streamKey = new Key('accountstream');

  static final GlobalKey<FormState> _formKey =
      new GlobalKey(debugLabel: 'dataform');

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
  final GlobalKey<CustomizeFieldWidgetState> _wechatFieldKey =
      new GlobalKey(debugLabel: 'wechat');

//  final GlobalKey<CustomizeFieldWidgetState> _cgpFieldKey =
//      new GlobalKey(debugLabel: 'cgp');
  final GlobalKey<CustomizeFieldWidgetState> _cpwFieldKey =
      new GlobalKey(debugLabel: 'cpw');

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
    _wechatFieldKey.currentState.setInput = initTexts[5];
//    if (initTexts[6] != '-1') _cgpFieldKey.currentState.setInput = initTexts[6];
    if (initTexts[7] != '-1') _cpwFieldKey.currentState.setInput = initTexts[7];
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
                      titleLetterSpacing: 4,
                      suffixText: localeStr.centerTextButtonChangePwd,
                      suffixAction: (account) {
                        RouterNavigate.navigateToPage(
                          RoutePage.centerPassword,
                          arg: CenterDisplayAccountPasswordArguments(
                            store: _store,
                          ),
                        );
                      },
                      readOnly: true,
                    ),
                    /* Name Field */
                    new CustomizeFieldWidget(
                      key: _nameFieldKey,
                      hint: localeStr.centerHintNoName,
                      persistHint: false,
                      coloredHint: true,
                      prefixText: localeStr.centerTextTitleName,
                      suffixText: (_storeData.canBindCard)
                          ? localeStr.centerTextButtonBind
                          : null,
                      suffixAction: (_) {
                        RouterNavigate.navigateToPage(RoutePage.bankcard);
                      },
                      readOnly: true,
                    ),
                    /* Birth Date Field */
                    new CustomizeFieldWidget(
                      key: _birthFieldKey,
                      fieldType: FieldType.Date,
                      maxInputLength: 10,
                      hint: localeStr.centerTextTitleDateHint,
                      persistHint: false,
                      prefixText: localeStr.centerTextTitleBirth,
                      suffixText: (_storeData.canBindBirthDate)
                          ? localeStr.centerTextButtonBind
                          : null,
                      suffixAction: (input) {
                        debugPrint('request bind birth date: $input');
                        checkAndPost(context, () {
                          if (input.isValidDate)
                            _store.bindBirth(input);
                          else
                            callToast(localeStr.messageInvalidFormat);
                        });
                      },
                      readOnly: _storeData.canBindBirthDate == false,
                    ),
                    /* Phone Field */
                    new CustomizeFieldWidget(
                      key: _phoneFieldKey,
                      hint: '',
                      persistHint: false,
                      prefixText: localeStr.centerTextTitlePhone,
                      titleLetterSpacing: 4,
                      suffixText: (_storeData.canVerifyPhone)
                          ? localeStr.centerTextButtonSend
                          : null,
                      suffixAction: (_) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => new CenterDialogMobile(
                            store: _store,
                            mobile: _phoneFieldKey.currentState.getInput
                                .split('(')[0],
                          ),
                        );
                      },
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
                      maxInputLength: 50,
                    ),
                    /* WeChat Field */
                    new CustomizeFieldWidget(
                      key: _wechatFieldKey,
                      hint: '',
                      persistHint: false,
                      prefixText: localeStr.centerTextTitleWechat,
                      titleLetterSpacing: 4,
                      suffixText: (_storeData.canBindWechat)
                          ? localeStr.centerTextButtonBind
                          : null,
                      suffixAction: (input) {
                        debugPrint('request bind wechat: $input');
                        checkAndPost(context, () {
                          _store.bindWechat(input);
                        });
                      },
                      readOnly: _storeData.canBindWechat == false,
                      validCondition: (value) => rangeCheck(
                          value: value.length,
                          min: InputLimit.WECHAT_MIN,
                          max: InputLimit.WECHAT_MAX),
                      errorMsg: localeStr.messageInvalidWechat,
                      maxInputLength: InputLimit.WECHAT_MAX,
                    ),
                  ],
                ),
              ),
            ),
//                /* CGP Field */
//                new CustomizeFieldWidget(
//                  key: _cgpFieldKey,
//                  hint: '',
//                  persistHint: false,
//                  prefixText: localeStr.centerTextTitleCgp,
//                  titleLetterSpacing: 0.4,
//                  suffixText: (_storeData.canBindCgp)
//                      ? localeStr.centerTextButtonBind
//                      : null,
//                  suffixAction: (_) {
//                    debugPrint('cgp url: ${_store.cgpUrl}');
//                    if (_store.cgpUrl != null && _store.cgpUrl.isNotEmpty)
//                      RouterNavigate.navigateToPage(
//                        RoutePage.centerWeb,
//                        arg: WebRouteArguments(startUrl: _store.cgpUrl[0]),
//                      );
//                  },
//                  useSameBgColor: true,
//                  readOnly: true,
//                ),
            /* CPW Field */
            new CustomizeFieldWidget(
              key: _cpwFieldKey,
              hint: '',
              persistHint: false,
              prefixText: localeStr.centerTextTitleCpw,
              titleLetterSpacing: 0,
              suffixText: (_storeData.canBindCpw)
                  ? localeStr.centerTextButtonBind
                  : null,
              suffixAction: (_) {
                debugPrint('request bind cpw');
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => new CenterDialogCpw(store: _store),
                );
              },
              useSameBgColor: themeColor.isDarkTheme == false,
              readOnly: true,
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
