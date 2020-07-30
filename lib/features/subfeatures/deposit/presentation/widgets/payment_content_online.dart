import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_dropdown_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:intl/intl.dart' show NumberFormat;

import '../../data/form/deposit_form.dart';
import '../../data/model/payment_freezed.dart';
import 'payment_tutorial.dart';

/// Content View for all other types of Payment
///@author H.C.CHIANG
///@version 2020/3/26
class PaymentContentOnline extends StatefulWidget {
  final List<PaymentFreezed> dataList;
  final Function depositFuncCall;
  final List tutorial;

  PaymentContentOnline({
    this.dataList,
    this.depositFuncCall,
    this.tutorial,
  });

  @override
  _PaymentContentOnlineState createState() => _PaymentContentOnlineState();
}

class _PaymentContentOnlineState extends State<PaymentContentOnline> {
  final String tag = 'PaymentContentOnline';
  static final GlobalKey<FormState> _formKey =
      new GlobalKey(debugLabel: 'form');
  final GlobalKey<CustomizeFieldWidgetState> _amountFieldKey =
      new GlobalKey(debugLabel: 'amount');
  final GlobalKey<CustomizeDropdownWidgetState> _bankOptionKey =
      new GlobalKey(debugLabel: 'bank');
  final GlobalKey<CustomizeDropdownWidgetState> _amountOptionKey =
      new GlobalKey(debugLabel: 'aoption');

  PaymentDataOther _otherData;
  int _bankSelectedIndex = -1;
  int _bankSelectedId = -1;
//  int _methodSelected; // Currently all 3
  String _depositAmount = '';
  bool _useAmountOption = false;

  void _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      if (_otherData.hasAmountOption == false)
        _depositAmount = _amountFieldKey?.currentState?.getInput ?? '0';
//      print('The user wants to login with $_username and $_password');
      DepositDataForm dataForm = new DepositDataForm(
        bankIndex: _bankSelectedIndex,
        methodId: 3,
        bankId: _bankSelectedId,
        amount: _depositAmount,
      );
      if (_depositAmount.isEmpty) {
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

  void setContent() {
    _otherData = widget.dataList[0];
//    _methodSelected = _otherData.amountType;
    _bankSelectedId = _otherData.bankAccountId;
    _bankSelectedIndex = _otherData.sb[0];
    _useAmountOption = _otherData.hasAmountOption;
    _depositAmount =
        (_useAmountOption) ? _otherData.amountOption[0].toString() : '0';
    print('update online payment data: $_otherData');
//    print('update online payment data: ${_otherData.type}');
  }

  @override
  void initState() {
    setContent();
    super.initState();
  }

  @override
  void didUpdateWidget(PaymentContentOnline oldWidget) {
    if (oldWidget.dataList != widget.dataList) {
//      print('old dataList: ${oldWidget.dataList}');
//      print('new dataList: ${widget.dataList}');
      if (_useAmountOption) _amountOptionKey.currentState.setSelected = null;
      setContent();
      _bankOptionKey.currentState.setSelected = _bankSelectedId;
    }
    super.didUpdateWidget(oldWidget);
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
      return InkWell(
        // to dismiss the keyboard when the user tabs out of the TextField
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: () {
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
                children: <Widget>[
                  /* Bank Option */
                  CustomizeDropdownWidget(
                    key: _bankOptionKey,
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
                      if (data is PaymentDataOther) {
                        if (_otherData == data) return;
                        print('change method: $data');
//                        _methodSelected = _otherData.amountType;
                        _bankSelectedId = _otherData.bankAccountId;
                        _bankSelectedIndex = _otherData.sb[0];
                        setState(() {
                          _otherData = data;
                        });
                      }
                    },
                  ),
                  /* Amount Input Field */
                  (_useAmountOption)
                      ? CustomizeDropdownWidget(
                          key: _amountOptionKey,
                          prefixText: localeStr.depositPaymentEditTitleAmount,
                          titleLetterSpacing: 4,
                          optionValues: _otherData.amountOption,
                          changeNotify: (data) {
                            // clear text field focus
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            // set selected data
                            print('change amount: $data');
                            if (_depositAmount != data.toString())
                              setState(() {
                                _depositAmount = data.toString();
                              });
                          },
                        )
                      : new CustomizeFieldWidget(
                          key: _amountFieldKey,
                          fieldType: FieldType.Numbers,
                          hint:
                              localeStr.depositPaymentEditTitleAmountHintRange(
                            _otherData.min ?? 1,
                            _otherData.max,
                          ),
                          persistHint: false,
                          prefixText: localeStr.depositPaymentEditTitleAmount,
                          errorMsg: localeStr.messageInvalidDepositAmount,
                          validCondition: (value) =>
                              value.contains('.') == false &&
                              rangeCheck(
                                value:
                                    (value.isNotEmpty) ? int.parse(value) : 0,
                                min: _otherData.min ?? 1,
                                max: _otherData.max,
                              ),
                          titleLetterSpacing: 4,
                          maxInputLength: _otherData.max.toString().length,
                        ),
                  /* Amount Limit Hint */
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 10.0),
                        child: Text(
                          localeStr.depositHintTextAmount(
                              NumberFormat.simpleCurrency(decimalDigits: 0)
                                  .format(_otherData.max)),
                          style: TextStyle(color: Themes.hintHighlight),
                        ),
                      ),
                    ],
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
            SizedBox(height: 12.0),
            /* Tutorial Button */
            (widget.tutorial != null)
                ? Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: Global.device.comfortButtonHeight,
                          child: RaisedButton(
                            child: Text(
                                localeStr.depositPaymentButtonTitleTutorial),
                            color: Themes.buttonSubColor,
                            textColor: Themes.defaultTextColorBlack,
                            onPressed: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => new PaymentTutorial(
                                  tutorialData: widget.tutorial,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink(),
          ],
        ),
      );
    }
  }
}
