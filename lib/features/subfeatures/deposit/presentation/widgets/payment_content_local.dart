import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_dropdown_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:intl/intl.dart' show NumberFormat;

import '../../data/form/deposit_form.dart';
import '../../data/model/payment_freezed.dart';
import '../../data/model/payment_promo.dart';

/// Content View for [PaymentEnum.bank]
///@author H.C.CHIANG
///@version 2020/3/26
class PaymentContentLocal extends StatefulWidget {
  final List<PaymentFreezed> dataList;
  final List<PaymentPromoData> promoList;
  final Function depositFuncCall;

  PaymentContentLocal({this.dataList, this.promoList, this.depositFuncCall});

  @override
  _PaymentContentLocalState createState() => _PaymentContentLocalState();
}

class _PaymentContentLocalState extends State<PaymentContentLocal> {
  final String tag = 'PaymentContentLocal';
  static final GlobalKey<FormState> _formKey =
      new GlobalKey(debugLabel: 'form');

  final GlobalKey<CustomizeFieldWidgetState> _nameFieldKey =
      new GlobalKey(debugLabel: 'name');
  final GlobalKey<CustomizeFieldWidgetState> _amountFieldKey =
      new GlobalKey(debugLabel: 'amount');

  PaymentDataLocal _localData;
  int _promoSelected = -1;
  int _bankSelectedIndex = -1;
  int _bankSelectedId = -1;
  int _methodSelected;

  void _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
//      print('The user wants to login with $_username and $_password');
      DepositDataForm dataForm = DepositDataForm(
        bankIndex: _bankSelectedIndex,
        methodId: _methodSelected,
        name: _nameFieldKey.currentState.getInput,
        bankId: _bankSelectedId,
        amount: _amountFieldKey.currentState.getInput,
        promoId: _promoSelected,
      );
      if (dataForm.isValid == false) {
        FLToast.showText(
          text: localeStr.messageActionFillForm,
          position: FLToastPosition.top,
          showDuration: ToastDuration.DEFAULT.value,
        );
        return;
      }
//      print('deposit form: ${dataForm.toJson()}');
      widget.depositFuncCall(dataForm);
    }
  }

  @override
  void initState() {
    _localData = widget.dataList[0];
    _methodSelected ??= 1;
    _bankSelectedId = _localData.bankAccountId;
    _bankSelectedIndex = _localData.bankIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataList == null || widget.dataList.isEmpty) {
      return Center(
        child: WarningDisplay(
          message: Failure.jsonFormat().message,
        ),
      );
    } else {
      List<String> methods = [
        localeStr.depositPaymentMethodLocal1,
        localeStr.depositPaymentMethodLocal2,
      ];
      List<PaymentPromoData> promos = [
        PaymentPromoData(
          promoId: -1,
          promoDesc: localeStr.depositPaymentNoPromo,
        ),
      ];
      promos.addAll(widget.promoList);
      return InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: () {
          // to dismiss the keyboard when the user tabs out of the TextField
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            new Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  /* Promo Option */
                  CustomizeDropdownWidget(
                    prefixText: localeStr.depositPaymentSpinnerTitlePromo,
                    titleLetterSpacing: 4,
                    optionValues: promos.map((item) => item.promoId).toList(),
                    optionStrings:
                        promos.map((item) => item.promoDesc).toList(),
                    changeNotify: (data) {
                      // clear text field focus
                      FocusScope.of(context).requestFocus(new FocusNode());
                      // set selected data
                      if (data is PaymentPromoData)
                        _promoSelected = data.promoId;
                    },
                  ),
                  /* Bank Option */
                  CustomizeDropdownWidget(
                    prefixText: localeStr.depositPaymentSpinnerTitleBank,
                    titleLetterSpacing: 4,
                    optionValues: widget.dataList
                        .map((item) => item.bankAccountId)
                        .toList(),
                    optionStrings:
                        widget.dataList.map((item) => item.type).toList(),
                    changeNotify: (data) {
                      // clear text field focus
                      FocusScope.of(context).requestFocus(new FocusNode());
                      // set selected data
                      if (data is PaymentDataLocal) {
                        if (_localData == data) return;
                        print('change bank: $data');
                        _bankSelectedId = data.bankAccountId;
                        _bankSelectedIndex = data.bankIndex;
                        setState(() {
                          _localData = data;
                        });
                      }
                    },
                  ),
                  /* Account Hint */
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 6.0),
                    child: Text(
                      localeStr.depositHintTextAccount,
                      style: TextStyle(color: Themes.hintHighlight),
                    ),
                  ),
                  /* Method Option */
                  CustomizeDropdownWidget(
                    prefixText: localeStr.depositPaymentSpinnerTitleMethod,
                    titleLetterSpacing: 4,
                    optionStrings: methods,
                    optionValues: [1, 2],
                    changeNotify: (data) {
                      // clear text field focus
                      FocusScope.of(context).requestFocus(new FocusNode());
                      // set selected data
                      _methodSelected = data;
                    },
                  ),
                  /* Name Input Field */
                  new CustomizeFieldWidget(
                    key: _nameFieldKey,
                    fieldType: FieldType.ChineseOnly,
                    hint: localeStr.depositPaymentEditTitleNameHint,
                    persistHint: false,
                    prefixText: localeStr.depositPaymentEditTitleName,
                    errorMsg: localeStr.messageInvalidDepositName,
                    validCondition: (value) =>
                        rangeCheck(value: value.length, min: 2, max: 12),
                    titleLetterSpacing: 0.5,
                    maxInputLength: 12,
                    debug: true,
                  ),
                  /* Amount Input Field */
                  new CustomizeFieldWidget(
                    key: _amountFieldKey,
                    fieldType: FieldType.Numbers,
                    hint: localeStr.depositPaymentEditTitleAmountHintRange(
                      _localData.min?.strToInt ?? 1,
                      _localData.max.strToInt,
                    ),
                    persistHint: false,
                    prefixText: localeStr.depositPaymentEditTitleAmount,
                    errorMsg: localeStr.messageInvalidDepositAmount,
                    validCondition: (value) =>
                        value.contains('.') == false &&
                        rangeCheck(
                          value: (value.isNotEmpty) ? int.parse(value) : 0,
                          min: _localData.min?.strToInt ?? 1,
                          max: _localData.max.strToInt,
                        ),
                    titleLetterSpacing: 4,
                    maxInputLength: _localData.max.length,
                  ),
                  /* Amount Limit Hint */
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 6.0),
                    child: Text(
                      localeStr.depositHintTextAmount(
                          NumberFormat.simpleCurrency(decimalDigits: 0)
                              .format(_localData.max.strToInt)),
                      style: TextStyle(color: Themes.hintHighlight),
                    ),
                  ),
                ],
              ),
            ),
            /* Confirm Button */
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: Global.device.comfortButtonHeight,
                    child: RaisedButton(
                      child: Text(localeStr.btnConfirm),
                      textColor: Themes.defaultTextColorBlack,
                      onPressed: () {
                        try {
                          // clear text field focus
                          FocusScope.of(context).requestFocus(new FocusNode());
                          // validate and send request
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
          ],
        ),
      );
    }
  }
}
