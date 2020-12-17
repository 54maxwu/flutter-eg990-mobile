import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_eg990_mobile/utils/value_util.dart';

import '../../data/form/withdraw_form.dart';
import '../state/withdraw_store.dart';

class WithdrawDisplayView extends StatefulWidget {
  final WithdrawStore store;

  WithdrawDisplayView({this.store});

  @override
  _WithdrawDisplayViewState createState() => _WithdrawDisplayViewState();
}

class _WithdrawDisplayViewState extends State<WithdrawDisplayView> {
  final String tag = 'WithdrawDisplayView';

  static final GlobalKey<FormState> _formKey =
      new GlobalKey(debugLabel: 'form');

  // Fields
  final GlobalKey<CustomizeFieldWidgetState> _amountFieldKey =
      new GlobalKey(debugLabel: 'amount');
  final GlobalKey<CustomizeFieldWidgetState> _passwordFieldKey =
      new GlobalKey(debugLabel: 'password');

  // TODO observe rollback string
  int amountLimit = 100;
  String _flowLimit = '${creditSymbol}0';
  int _typeSelected = 0;

  void _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      WithdrawForm dataForm = WithdrawForm(
        amount: _amountFieldKey.currentState.getInput,
        password: _passwordFieldKey.currentState.getInput,
        type: _typeSelected.toString(),
        minimum: amountLimit,
      );
      if (dataForm.isValid) {
        debugPrint('bankcard form: ${dataForm.toJson()}');
        if (widget.store.waitForWithdrawResult)
          callToast(localeStr.messageWait);
        else
          widget.store.sendRequest(dataForm);
      } else {
        callToast(localeStr.messageActionFillForm);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
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
                  /* Amount Input Field */
                  new CustomizeFieldWidget(
                    key: _amountFieldKey,
                    fieldType: FieldType.Numbers,
                    persistHint: false,
                    prefixText: localeStr.withdrawViewTitleAmount,
                    titleLetterSpacing: 4,
                    maxInputLength: InputLimit.AMOUNT,
                    errorMsg:
                        localeStr.messageInvalidDepositAmountMin(amountLimit),
                    validCondition: (value) => rangeCheck(
                      value: (value.isNotEmpty) ? int.parse(value) : 0,
                      min: amountLimit,
                    ),
                  ),
                  /* Password Input Field */
                  new CustomizeFieldWidget(
                    key: _passwordFieldKey,
                    fieldType: FieldType.Password,
                    persistHint: false,
                    prefixText: localeStr.withdrawViewTitlePwd,
                    titleLetterSpacing: 4,
                    maxInputLength: InputLimit.PASSWORD_MAX,
                    errorMsg: localeStr.messageInvalidWithdrawPassword,
                    validCondition: (value) => rangeCheck(
                        value: value.length,
                        min: 4,
                        max: InputLimit.PASSWORD_MAX),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: RichText(
              maxLines: 2,
              text: TextSpan(
                children: <InlineSpan>[
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0, bottom: 2.0),
                      child: Icon(
                        const IconData(0xf05a, fontFamily: 'FontAwesome'),
                        color: themeColor.hintHyperLink,
                        size: FontSize.NORMAL.value,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: localeStr.withdrawViewOptionHint2,
                    style: TextStyle(color: themeColor.hintHyperLink),
                  ),
                  TextSpan(
                    text: '$_flowLimit',
                    style: TextStyle(color: themeColor.hintHyperLink),
                  ),
                ],
              ),
            ),
          ),
          RichText(
            maxLines: 2,
            text: TextSpan(
              children: <InlineSpan>[
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4.0, bottom: 2.0),
                    child: Icon(
                      const IconData(0xf05a, fontFamily: 'FontAwesome'),
                      color: themeColor.hintHyperLink,
                      size: FontSize.NORMAL.value,
                    ),
                  ),
                ),
                TextSpan(
                  text: localeStr.withdrawViewOptionHint3,
                  style: TextStyle(color: themeColor.hintHyperLink),
                ),
              ],
            ),
          ),
          /* Confirm Button */
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: Global.device.comfortButtonHeight,
                    child: RaisedButton(
                      child: Text(localeStr.btnSubmit),
                      onPressed: () {
                        try {
                          _validateForm();
                        } catch (e) {
                          MyLogger.error(
                              msg: 'form error: $e', error: e, tag: tag);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
