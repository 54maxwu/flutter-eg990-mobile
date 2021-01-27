import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_dropdown_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:intl/intl.dart';

import '../../data/form/deposit_form.dart';
import '../../data/model/deposit_info.dart';
import '../../data/model/payment_promo.dart';
import '../../data/model/payment_type_data.dart';

/// Content View for [PaymentEnum.bank]
///@author H.C.CHIANG
///@version 2020/3/26
class PaymentContentLocal extends StatefulWidget {
  final List<PaymentTypeData> dataList;
  final List<PaymentPromoData> promoList;
  final List<DepositInfo> infoList;
  final Map<int, String> bankMap;
  final Function depositFuncCall;

  PaymentContentLocal({
    @required this.dataList,
    @required this.promoList,
    @required this.infoList,
    @required this.bankMap,
    @required this.depositFuncCall,
  });

  @override
  _PaymentContentLocalState createState() => _PaymentContentLocalState();
}

class _PaymentContentLocalState extends State<PaymentContentLocal> {
  final String tag = 'PaymentContentLocal';
  final GlobalKey<FormState> _formKey = new GlobalKey(debugLabel: 'form');

  final GlobalKey<CustomizeFieldWidgetState> _nameFieldKey =
      new GlobalKey(debugLabel: 'name');
  final GlobalKey<CustomizeFieldWidgetState> _accountFieldKey =
      new GlobalKey(debugLabel: 'account');
  final GlobalKey<CustomizeFieldWidgetState> _amountFieldKey =
      new GlobalKey(debugLabel: 'amount');

  final double _fieldInset = 56.0;
  final double _titleWidthFactor = 0.4;
  double _valueTextPadding;

  List<DepositInfo> _targetBanks;
  List<String> _bankNames;
  List<int> _bankIds;

  PaymentTypeLocalData _localData;
  DepositInfo _selectedBankInfo;
  int _bankSelected = -1;
  int _promoSelected = -1;
  int _methodSelected = 1;
  int _amountVnd = 0;

  void _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
//      debugPrint('The user wants to login with $_username and $_password');
      try {
        DepositDataForm dataForm = DepositDataForm(
          name: _nameFieldKey.currentState.getInput,
          amount: _amountFieldKey.currentState.getInput,
          bankIndex: _localData.bankIndex,
          bankId: _localData.bankAccountId,
          methodId: _methodSelected,
          gateway: "1",
          promoId: _promoSelected,
          localBank: _bankSelected,
          localBankCard: _accountFieldKey.currentState.getInput,
        );
        if (dataForm.isValid == false) {
          callToast(localeStr.messageActionFillForm);
          return;
        }
//        debugPrint('deposit form: ${dataForm.toJson()}');
        if (widget.depositFuncCall != null) widget.depositFuncCall(dataForm);
      } catch (e) {
        debugPrint('validate deposit form has exception: $e');
        callToastError(localeStr.depositMessageFailed);
      }
    }
  }

  void _updateSelected() {
    if (widget.infoList != null && widget.infoList.isNotEmpty) {
      _selectedBankInfo ??= widget.infoList.first;
    } else {
      _selectedBankInfo = DepositInfo(hasBankInfo: false);
    }
    // debugPrint('available local payments: ${widget.dataList}');
    if (_selectedBankInfo != null && _selectedBankInfo.hasBankInfo) {
      _localData = widget.dataList.firstWhere(
        (element) => element.bankAccountId == _selectedBankInfo.bankAccountId,
        orElse: () => null,
      );
    } else {
      _localData = widget.dataList.first;
    }
    debugPrint('selected bank info: $_selectedBankInfo');
    debugPrint('selected local payment: $_localData');
  }

  void _generateBankDataList() {
    debugPrint('bank map: ${widget.bankMap}');
    if (widget.bankMap != null && widget.bankMap.isNotEmpty) {
      _bankNames = widget.bankMap.values.toList()..sort();
      // debugPrint('bank names sorted: $_bankNames\n');
      _bankIds = _bankNames
          .map((value) =>
              widget.bankMap.entries
                  .firstWhere((element) => element.value == value,
                      orElse: () => null)
                  ?.key ??
              -1)
          .toList()
            ..removeWhere((element) => element == -1);
      // debugPrint('bank ids sorted: $_bankIds\n');
      _bankSelected = _bankIds.first;
    }
  }

  @override
  void initState() {
    _valueTextPadding = (Global.device.width.roundToDouble() - _fieldInset) *
            _titleWidthFactor -
        ThemeInterface.minusSize;
    _generateBankDataList();
    _updateSelected();
    super.initState();
    if (widget.infoList != null && widget.infoList.isNotEmpty) {
      _targetBanks = widget.infoList;
    } else {
      _targetBanks = widget.dataList.map((e) {
        final PaymentTypeLocalData data = e as PaymentTypeLocalData;
        return DepositInfo(
          bankAccountId: data.bankAccountId,
          bankAccountName: data.type,
          bankAccountNo: data.bankAccountNo,
          bankCode: data.bankIndex.toString(),
          hasBankInfo: false,
        );
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataList == null ||
        widget.dataList.isEmpty ||
        _selectedBankInfo == null ||
        _localData == null) {
      return Center(
        child: WarningDisplay(
          message: Failure.server().message,
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
      if (widget.promoList != null) promos.addAll(widget.promoList);
      return new Form(
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
                prefixText: localeStr.depositPaymentSpinnerTitleBank,
                prefixTextMaxLines: 2,
                titleWidthFactor: _titleWidthFactor,
                horizontalInset: _fieldInset,
                optionValues: _targetBanks,
                optionStrings:
                    _targetBanks.map((e) => e.bankAccountName).toList(),
                changeNotify: (data) {
                  // clear text field focus
                  FocusScope.of(context).unfocus();
                  debugPrint('selected target: $data');
                  setState(() {
                    _selectedBankInfo = data;
                  });
                  _updateSelected();
                },
              ),
            ),

            ///
            /// Deposit Info Area
            ///
            if (!_selectedBankInfo.hasBankInfo)
              Padding(
                padding: EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 4.0),
                child: Text(
                  localeStr.depositHintTextAccount,
                  style: TextStyle(color: themeColor.defaultHintSubColor),
                ),
              ),
            if (_selectedBankInfo.hasBankInfo)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: DottedBorder(
                  color: themeColor.hintHighlight.withAlpha(108),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            style: TextStyle(
                              color: themeColor.hintHighlight,
                              fontSize: FontSize.NORMAL.value,
                              fontWeight: FontWeight.w500,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${localeStr.bankcardViewTitleBank}: ',
                                style: TextStyle(
                                  color: themeColor.defaultHintColor,
                                  fontSize: FontSize.NORMAL.value,
                                ),
                              ),
                              TextSpan(
                                  text:
                                      '${_selectedBankInfo.bankAccountName}\n'),
                              TextSpan(
                                text:
                                    '${localeStr.bankcardViewTitleCardNumber}: ',
                                style: TextStyle(
                                  color: themeColor.defaultHintColor,
                                  fontSize: FontSize.NORMAL.value,
                                ),
                              ),
                              TextSpan(
                                  text: '${_selectedBankInfo.bankAccountNo}\n'),
                              TextSpan(
                                text: '${localeStr.bankcardViewTitleOwner}: ',
                                style: TextStyle(
                                  color: themeColor.defaultHintColor,
                                  fontSize: FontSize.NORMAL.value,
                                ),
                              ),
                              TextSpan(
                                text: '${_selectedBankInfo.accountName}',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ///
            /// Promo Option
            ///
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: CustomizeDropdownWidget(
                prefixText: localeStr.depositPaymentSpinnerTitlePromo,
                prefixTextMaxLines: 2,
                titleWidthFactor: _titleWidthFactor,
                horizontalInset: _fieldInset,
                optionValues: promos.map((item) => item.promoId).toList(),
                optionStrings: promos.map((item) => item.promoDesc).toList(),
                changeNotify: (data) {
                  // clear text field focus
                  FocusScope.of(context).unfocus();
                  // set selected data
                  if (data is PaymentPromoData) _promoSelected = data.promoId;
                },
              ),
            ),

            ///
            /// Method Option
            ///
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomizeDropdownWidget(
                prefixText: localeStr.depositPaymentSpinnerTitleMethod,
                prefixTextMaxLines: 2,
                titleWidthFactor: _titleWidthFactor,
                horizontalInset: _fieldInset,
                optionStrings: methods,
                optionValues: [1, 2],
                changeNotify: (data) {
                  // clear text field focus
                  FocusScope.of(context).unfocus();
                  // set selected data
                  _methodSelected = data;
                },
              ),
            ),

            ///
            /// Bank Option
            ///
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomizeDropdownWidget(
                prefixText: localeStr.depositPaymentSpinnerTitleAccountBank,
                prefixTextMaxLines: 2,
                titleWidthFactor: _titleWidthFactor,
                horizontalInset: _fieldInset,
                optionValues: _bankIds,
                optionStrings: _bankNames,
                changeNotify: (data) {
                  // clear text field focus
                  FocusScope.of(context).unfocus();
                  debugPrint(
                      'selected bank: $data, label: ${widget.bankMap[data]}');
                  _bankSelected = data;
                },
              ),
            ),

            ///
            /// Name Input Field
            ///
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: new CustomizeFieldWidget(
                key: _nameFieldKey,
                hint: localeStr.depositPaymentEditTitleNameHint,
                persistHint: false,
                prefixText: localeStr.depositPaymentEditTitleName,
                prefixTextMaxLines: 2,
                titleWidthFactor: _titleWidthFactor,
                horizontalInset: _fieldInset,
                maxInputLength: InputLimit.NAME_MAX,
                errorMsg: localeStr.messageInvalidDepositName,
                validCondition: (value) => rangeCheck(
                  value: value.length,
                  min: InputLimit.NAME_MIN,
                  max: InputLimit.NAME_MAX,
                ),
              ),
            ),

            ///
            /// Account Input Field
            ///
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: new CustomizeFieldWidget(
                key: _accountFieldKey,
                hint: localeStr.depositPaymentEditTitleAccountHint,
                persistHint: false,
                prefixText: localeStr.depositPaymentEditTitleAccount,
                prefixTextMaxLines: 2,
                titleWidthFactor: _titleWidthFactor,
                horizontalInset: _fieldInset,
                maxInputLength: InputLimit.CARD_MAX,
                errorMsg: localeStr.messageInvalidCardNumber(
                  InputLimit.CARD_MIN,
                  InputLimit.CARD_MAX,
                ),
                validCondition: (value) => rangeCheck(
                  value: value.length,
                  min: InputLimit.CARD_MIN,
                  max: InputLimit.CARD_MAX,
                ),
              ),
            ),

            ///
            /// Amount Input Field
            ///
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: new CustomizeFieldWidget(
                key: _amountFieldKey,
                fieldType: FieldType.Numbers,
                hint: localeStr.depositPaymentEditTitleAmountHintRange(
                  _localData.min?.strToInt ?? 1,
                  _localData.max.strToInt,
                ),
                persistHint: false,
                prefixText: localeStr.depositPaymentEditTitleAmount,
                prefixTextMaxLines: 2,
                titleWidthFactor: _titleWidthFactor,
                horizontalInset: _fieldInset,
                maxInputLength: _localData.max.length,
                errorMsg: localeStr.messageInvalidDepositAmount,
                validCondition: (value) =>
                    value.contains('.') == false &&
                    rangeCheck(
                      value: (value.isNotEmpty) ? int.parse(value) : 0,
                      min: _localData.min?.strToInt ?? 1,
                      max: _localData.max.strToInt,
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
            Padding(
              padding: EdgeInsets.fromLTRB(_valueTextPadding, 8.0, 0.0, 16.0),
              child: Text(
                localeStr.depositPaymentEditTitleAmountHintVND(_amountVnd),
                style: TextStyle(color: themeColor.defaultHintSubColor),
              ),
            ),

            ///
            /// Note Input Field
            ///
            // Padding(
            //   padding: const EdgeInsets.only(top: 8.0),
            //   child: new CustomizeFieldWidget(
            //     key: _noteFieldKey,
            //     hint: localeStr.depositPaymentEditTitleNote,
            //     persistHint: false,
            //     prefixText: localeStr.depositPaymentEditTitleNote,
            //     titleWidthFactor: _titleWidthFactor,
            //     horizontalInset: _fieldInset,
            //     maxInputLength: InputLimit.NOTE_MAX,
            //     errorMsg: localeStr.messageInvalidFormat,
            //     validCondition: (value) =>
            //         rangeCheck(value: value.length, min: 0, max: 20),
            //   ),
            // ),

            ///
            /// Amount Limit Hint
            ///
            Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 6.0, 4.0, 6.0),
              child: Text(
                localeStr.depositHintTextAmount(
                    NumberFormat.simpleCurrency(decimalDigits: 0)
                        .format(_localData.max.strToInt)),
                style: TextStyle(color: themeColor.hintHighlight),
              ),
            ),

            ///
            /// Confirm Button
            ///
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 16.0),
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
          ],
        ),
      );
    }
  }
}
