import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_dropdown_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_input_chip_container.dart';

import '../../data/form/transfer_form.dart';
import '../../data/models/transfer_platform_model.dart';
import '../state/transfer_store.dart';

class TransferDisplay extends StatefulWidget {
  final TransferStore store;

  TransferDisplay({this.store});

  @override
  _TransferDisplayState createState() => _TransferDisplayState();
}

class _TransferDisplayState extends State<TransferDisplay> {
  final String tag = 'TransferDisplay';

  final GlobalKey<FormState> _formKey = new GlobalKey(debugLabel: 'form');

  // Fields
  final GlobalKey<CustomizeFieldWidgetState> _amountFieldKey =
      new GlobalKey(debugLabel: 'amount');

  // Dropdowns
  final GlobalKey<CustomizeDropdownWidgetState> _site1Key =
      new GlobalKey(debugLabel: 'site1');
  final GlobalKey<CustomizeDropdownWidgetState> _site2Key =
      new GlobalKey(debugLabel: 'site2');

  final List<String> chipValues = [
    '100',
    '500',
    '1000',
    '2000',
    '5000',
    'all',
  ];
  List<String> _chipLabels;
  List<TransferPlatformModel> _site2List = [];
  List<String> _site1Labels;
  List<String> _site2Labels;

  String _site1Selected;
  String _site2Selected;

  void _updateChipLabels() {
    _chipLabels = [
      '100',
      '500',
      '1000',
      '2000',
      '5000',
      localeStr.transferViewTextOptionAll,
    ];
  }

  List<String> _updateDropdownLabels(List<TransferPlatformModel> list) {
    return list
        .map((e) =>
            e.name == 'center wallet' ? localeStr.walletViewTitle : e.name)
        .toList();
  }

  void _validateForm() {
    if (widget.store.isPlatformValid == false) {
      callToast(localeStr.transferPlatformError);
      return;
    }
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      String amountText = _amountFieldKey.currentState.getInput;
      int amount = amountText.strToInt;
      debugPrint('amount range: 1~${widget.store.creditLimit}, input: $amount');
      if (!rangeCheck(
        value: amount,
        min: 1,
        max: widget.store.creditLimit,
      )) {
        callToastError(localeStr.messageInvalidDepositAmount);
        return;
      }
      TransferForm dataForm = TransferForm(
        from: _site1Selected,
        to: _site2Selected,
        amount: amountText,
      );
      widget.store.sendRequest(dataForm);
    }
  }

  @override
  void didUpdateWidget(covariant TransferDisplay oldWidget) {
    _site1Labels = null;
    _site2Labels = null;
    _updateChipLabels();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (_chipLabels == null) _updateChipLabels();
    if (_site1Labels == null) {
      _site1Labels = _updateDropdownLabels(widget.store.platforms);
    }
    if (_site2Labels == null && _site2List != null) {
      _site2Labels = _updateDropdownLabels(_site2List);
    }
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        constraints: BoxConstraints(
          maxWidth: Global.device.width - 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
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
                  shrinkWrap: true,
                  children: <Widget>[
                    /* From Site Option */
                    CustomizeDropdownWidget(
                      key: _site1Key,
                      prefixText: localeStr.transferViewTitleOut,
                      titleWidthFactor: 0.3,
                      optionValues:
                          widget.store.platforms.map((e) => e.site).toList(),
                      optionStrings: _site1Labels,
                      suffixInitText: localeStr.transferViewSiteHint,
                      suffixTextStream: widget.store.site1ValueStream,
                      clearValueOnMenuChanged: true,
                      changeNotify: (data) {
                        if (data == null) return;
                        debugPrint('display selected: $data');
                        // platform credit can only transfer to member wallet
                        if (data != '0') {
                          _site2List = [widget.store.platforms.first];
                          _site2Labels = _updateDropdownLabels(_site2List);
                          _site2Selected = '0';
                          _site2Key.currentState.setSelected = '0';
                          widget.store.setSite2Value('');
                          widget.store.getBalance('0');
                          setState(() {});
                        } else if (_site2List.length == 1) {
                          // restore site2 dropdown to normal
                          _site2List = List.from(widget.store.platforms)
                            ..removeAt(0);
                          _site2Labels = _updateDropdownLabels(_site2List);
                          _site2Selected = null;
                          _site2Key.currentState.setSelected = null;
                          widget.store.setSite2Value('');
                          setState(() {});
                        } else if (data == '0' && _site2List.length == 0) {
                          // when site2 dropdown not initialized
                          _site2List = List.from(widget.store.platforms)
                            ..removeAt(0);
                          _site2Labels = _updateDropdownLabels(_site2List);
                          setState(() {});
                        }
                        // set site1 selected
                        _site1Selected = data;
//                        widget.store.setSite1Value('$data');
                        widget.store.setSite1Value('');
                        widget.store.getBalance(data, isLimit: true);
                      },
                    ),
                    /* To Site Option */
                    CustomizeDropdownWidget(
                      key: _site2Key,
                      prefixText: localeStr.transferViewTitleIn,
                      titleWidthFactor: 0.3,
                      optionValues: _site2List.map((e) => e.site).toList(),
                      optionStrings: _site2Labels,
                      suffixInitText: localeStr.transferViewSiteHint,
                      suffixTextStream: widget.store.site2ValueStream,
                      clearValueOnMenuChanged: true,
                      changeNotify: (data) {
                        if (data == null) return;
                        debugPrint('display selected: $data');
                        // set site2 selected
                        _site2Selected = data;
                        widget.store.setSite2Value('');
                        widget.store.getBalance(data);
                      },
                    ),
                    /* Amount Input Field */
                    new CustomizeFieldWidget(
                      key: _amountFieldKey,
                      fieldType: FieldType.Numbers,
                      persistHint: false,
                      prefixText: localeStr.transferViewTitleAmount,
                      titleWidthFactor: 0.3,
                      maxInputLength: InputLimit.AMOUNT,
                    ),
                    /* Amount Chip */
                    new CustomizeInputChipContainer(
                      prefixTitle: localeStr.transferViewTitleOption,
                      prefixTextMaxLines: (Global.localeCode == 'zh') ? 1 : 2,
                      titleWidthFactor: 0.3,
                      titleLetterSpacing: 0,
                      labels: _chipLabels,
                      values: chipValues,
                      heightFactor: 1.75,
                      chipTapCall: (value) {
                        if (value == 'all')
                          _amountFieldKey.currentState.setInput =
                              '${widget.store.creditLimit}';
                        else
                          _amountFieldKey.currentState.setInput = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
            /* Confirm Button */
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
              child: SizedBox(
                height: Global.device.comfortButtonHeight,
                child: RaisedButton(
                  child: Text(localeStr.btnConfirm),
                  onPressed: () => _validateForm(),
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: themeColor.defaultTextColor,
                ),
                children: [
                  TextSpan(
                    text: '${localeStr.balanceHintTextTitle}\n',
                    style: TextStyle(
                      color: themeColor.defaultSubtitleColor,
                      fontWeight: FontWeight.bold,
                      height: 3,
                    ),
                  ),
                  TextSpan(
                    text: '${localeStr.balanceHintText1}'
                        '\n${localeStr.balanceHintText2}'
                        '\n${localeStr.balanceHintText3}'
                        '\n${localeStr.transferHintRefresh}',
                    style: TextStyle(
                      height: 1.75,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
