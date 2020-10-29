import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_dropdown_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/deposit/data/entity/payment_enum_data.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/deposit/data/entity/payment_tutorial.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/form/deposit_form.dart';
import '../../data/model/payment_type_data.dart';

/// Content View for all other types of Payment
///@author H.C.CHIANG
///@version 2020/3/26
class PaymentContentOnline extends StatefulWidget {
  final List<PaymentTypeData> dataList;
  final Function depositFuncCall;

  PaymentContentOnline({
    @required this.dataList,
    @required this.depositFuncCall,
  });

  @override
  _PaymentContentOnlineState createState() => _PaymentContentOnlineState();
}

class _PaymentContentOnlineState extends State<PaymentContentOnline>
    with AfterLayoutMixin {
  final String tag = 'PaymentContentOnline';
  final GlobalKey<FormState> _formKey = new GlobalKey(debugLabel: 'form');
  final GlobalKey<CustomizeFieldWidgetState> _amountFieldKey =
      new GlobalKey(debugLabel: 'amount');
  final GlobalKey<CustomizeDropdownWidgetState> _bankOptionKey =
      new GlobalKey(debugLabel: 'bank');

  final double _fieldInset = 56.0;
//  double _valueTextPadding;

  PaymentTypeOnlineData _onlineData;
  int _bankSelectedIndex = -1;
  int _bankSelectedId = -1;
//  int _amountVnd = 0;
  bool _hasTutorial = false;
  PaymentTutorialItem _tutorialItem;
  PaymentTutorialItem _tutorialItem2;

  void _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      DepositDataForm dataForm = new DepositDataForm(
        bankIndex: _bankSelectedIndex,
        bankId: _bankSelectedId,
        amount: _amountFieldKey.currentState?.getInput ?? '',
        gateway: _onlineData.gateway.toString(),
        remark: '',
        methodId: 3,
      );
      if (dataForm.amount == '') {
        callToast(localeStr.messageActionFillForm);
        return;
      }
//      debugPrint('deposit form: ${dataForm.toJson()}');
      widget.depositFuncCall(dataForm);
    }
  }

  void setContent({dynamic dataKey}) {
    if (dataKey == null) {
      _onlineData = widget.dataList[0];
      _hasTutorial = _onlineData.payment == 8;
      getTutorialItem();
//      debugPrint('set payment data: $_onlineData');
//      debugPrint('has tutorial: $_hasTutorial, button text: $_tutorialBtnText');
    } else {
      PaymentTypeOnlineData data = widget.dataList.singleWhere(
        (data) => data.key == dataKey,
        orElse: () => _onlineData,
      );
      if (_onlineData == data) return;
      if (data == null) {
        debugPrint('online data key not found: $dataKey');
        return;
      }
      setState(() {
        _onlineData = data;
        _hasTutorial = data.payment == 8;
        getTutorialItem();
//        debugPrint('set payment data: $_onlineData');
//        debugPrint(
//            'has tutorial: $_hasTutorial, button text: $_tutorialBtnText');
      });
    }
    _bankSelectedId = _onlineData.bankAccountId;
    _bankSelectedIndex = '${_onlineData.key}'.strToInt;
    _bankOptionKey.currentState?.setSelected = _onlineData.key;
    debugPrint('update online payment data: ${_onlineData.key}');
  }

  void getTutorialItem() {
    if (!_hasTutorial) {
      _tutorialItem = null;
      _tutorialItem2 = null;
    } else {
      switch (_onlineData.payment) {
        case 8:
          _tutorialItem = PaymentTutorial.cgPay.value.tutorials.last;
          _tutorialItem2 = PaymentTutorial.cgPay.value.tutorials.first;
          break;
        default:
          _tutorialItem = null;
          _tutorialItem2 = null;
          break;
      }
    }
  }

  @override
  void initState() {
//    _valueTextPadding = (Global.device.width.roundToDouble() - _fieldInset) *
//            ThemeInterface.prefixTextWidthFactor -
//        ThemeInterface.minusSize;
//    debugPrint(
//        'dropdown keys: ${widget.dataList.map((item) => item.key).toList()}');
//    debugPrint(
//        'dropdown values: ${widget.dataList.map((item) => item.type).toList()}');
    super.initState();
    setContent();
  }

  @override
  void didUpdateWidget(PaymentContentOnline oldWidget) {
    if (oldWidget.dataList != widget.dataList) {
      setContent();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataList == null || widget.dataList.isEmpty) {
      return Center(
        child: WarningDisplay(
          message: Failure.server().message,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: new Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ///
              /// Bank Option
              ///
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: CustomizeDropdownWidget(
                  key: _bankOptionKey,
                  prefixText: localeStr.depositPaymentSpinnerTitleBank,
                  horizontalInset: _fieldInset,
                  optionValues:
                      widget.dataList.map((item) => item.key).toList(),
                  optionStrings:
                      widget.dataList.map((item) => item.type).toList(),
                  clearValueOnMenuChanged: true,
                  changeNotify: (key) {
                    // clear text field focus
                    FocusScope.of(context).unfocus();
                    // set selected data
                    setContent(dataKey: key);
                  },
                ),
              ),

              ///
              /// Account Hint
              ///
//            Padding(
//              padding: const EdgeInsets.only(top: 8.0),
//              child: Text(
//                localeStr.depositHintTextAccount,
//                style: TextStyle(color: themeColor.hintHighlight),
//              ),
//            ),

              ///
              /// Amount Input Field
              ///
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: new CustomizeFieldWidget(
                  key: _amountFieldKey,
                  fieldType: FieldType.Numbers,
                  hint: localeStr.depositPaymentEditTitleAmountHintRange(
                    _onlineData.min ?? 1,
                    _onlineData.max,
                  ),
                  persistHint: false,
                  prefixText: localeStr.depositPaymentEditTitleAmount,
                  horizontalInset: _fieldInset,
                  maxInputLength: _onlineData.max.toString().length,
                  errorMsg: localeStr.messageInvalidDepositAmount,
                  validCondition: (value) =>
                      value.contains('.') == false &&
                      rangeCheck(
                        value: (value.isNotEmpty) ? int.parse(value) : 0,
                        min: _onlineData.min ?? 1,
                        max: _onlineData.max,
                      ),
//                onInputChanged: (value) {
////                  debugPrint('received field value: $value');
//                  int input = value.strToInt;
//                  setState(() {
//                    _amountVnd = (input > 0) ? input * 1000 : 0;
//                  });
//                },
                ),
              ),

              ///
              /// VND Amount Hint
              ///
//            Padding(
//              padding: EdgeInsets.fromLTRB(_valueTextPadding, 24.0, 0.0, 16.0),
//              child: Text(
//                localeStr.depositPaymentEditTitleAmountHintVND(_amountVnd),
//                style: TextStyle(color: themeColor.defaultHintColor),
//              ),
//            ),

              ///
              /// Amount Limit Hint
              ///
              Padding(
                padding: const EdgeInsets.fromLTRB(4.0, 6.0, 4.0, 6.0),
                child: Text(
                  localeStr.depositHintTextAmount(
                      NumberFormat.simpleCurrency(decimalDigits: 0)
                          .format(_onlineData.max)),
                  style: TextStyle(color: themeColor.hintHighlight),
                ),
              ),

              ///
              /// Confirm Button
              ///
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: RaisedButton(
                        child: Text(localeStr.btnConfirm),
                        onPressed: () => _validateForm(),
                      ),
                    ),
                  ],
                ),
              ),

              ///
              /// Tutorial Button
              ///
              if (_hasTutorial && _tutorialItem != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: RaisedButton(
                          color: themeColor.hintHighlightOrangeStrong,
                          child: Text(_tutorialItem.value),
                          onPressed: () => launch(_tutorialItem.link),
                        ),
                      ),
                    ],
                  ),
                ),
              if (_hasTutorial && _tutorialItem2 != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: GestureDetector(
                    onTap: () => launch(_tutorialItem2.link),
                    child: SizedBox(
                      width: 165,
                      height: 225,
                      child: networkImageBuilder(_tutorialItem2.value),
                    ),
                  ),
                ),
              SizedBox(height: 12.0),
            ],
          ),
        ),
      );
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (_onlineData != null)
      _bankOptionKey.currentState?.setSelected = _onlineData.key;
  }
}
