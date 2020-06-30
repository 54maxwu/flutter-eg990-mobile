import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_ty_mobile/features/general/toast_widget_export.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_dropdown_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_input_chip_container.dart';
import 'package:flutter_ty_mobile/features/route_page_export.dart';
import 'package:flutter_ty_mobile/features/subfeatures/transfer/data/form/transfer_form.dart';
import 'package:flutter_ty_mobile/features/subfeatures/transfer/data/models/transfer_platform_model.dart';
import 'package:flutter_ty_mobile/features/subfeatures/transfer/presentation/state/transfer_store.dart';

class TransferDisplay extends StatefulWidget {
  final TransferStore store;

  TransferDisplay({this.store});

  @override
  _TransferDisplayState createState() => _TransferDisplayState();
}

class _TransferDisplayState extends State<TransferDisplay> {
  final String tag = 'TransferDisplay';

  static final GlobalKey<FormState> _formKey =
      new GlobalKey(debugLabel: 'form');

  // Fields
  final GlobalKey<CustomizeFieldWidgetState> _amountFieldKey =
      new GlobalKey(debugLabel: 'amount');
  // Dropdowns
  final GlobalKey<CustomizeDropdownWidgetState> _site1Key =
      new GlobalKey(debugLabel: 'site1');
  final GlobalKey<CustomizeDropdownWidgetState> _site2Key =
      new GlobalKey(debugLabel: 'site2');

  final List<String> chipLabels = [
    '100',
    '500',
    '1000',
    '2000',
    '5000',
    localeStr.transferViewTextOptionAll,
  ];
  final List<String> chipValues = [
    '100',
    '500',
    '1000',
    '2000',
    '5000',
    'all',
  ];
  List<TransferPlatformModel> _site2List = [];

  String _site1Selected;
  String _site2Selected;

  void _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      String amountText = _amountFieldKey.currentState.inputText;
      int amount = amountText.strToInt;
      if (!rangeCheck(
        value: amount,
        min: 1,
        max: widget.store.creditLimit,
      )) {
        FLToast.showError(
          text: localeStr.messageInvalidDepositAmount,
          showDuration: ToastDuration.DEFAULT.value,
        );
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
  Widget build(BuildContext context) {
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
              child: new Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    /* From Site Option */
                    CustomizeDropdownWidget(
                      key: _site1Key,
                      prefixTitle: localeStr.transferViewTitleOut,
                      optionValues:
                          widget.store.platforms.map((e) => e.site).toList(),
                      optionStrings:
                          widget.store.platforms.map((e) => e.name).toList(),
                      postfixInitText: localeStr.transferViewSiteHint,
                      postfixTextStream: widget.store.site1ValueStream,
                      clearValueOnMenuChanged: true,
                      changeNotify: (data) {
                        if (data == null) return;
                        print('display selected: $data');
                        // platform credit can only transfer to member wallet
                        if (data != '0') {
                          _site2List = [widget.store.platforms.first];
                          _site2Selected = '0';
                          _site2Key.currentState.setSelected = '0';
                          widget.store.setSite2Value('');
                          widget.store.getBalance('0');
                          setState(() {});
                        } else if (_site2List.length == 1) {
                          // restore site2 dropdown to normal
                          _site2List = List.from(widget.store.platforms)
                            ..removeAt(0);
                          _site2Selected = null;
                          _site2Key.currentState.setSelected = null;
                          widget.store.setSite2Value('');
                          setState(() {});
                        } else if (data == '0' && _site2List.length == 0) {
                          // when site2 dropdown not initialized
                          _site2List = List.from(widget.store.platforms)
                            ..removeAt(0);
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
                      prefixTitle: localeStr.transferViewTitleIn,
                      optionValues: _site2List.map((e) => e.site).toList(),
                      optionStrings: _site2List.map((e) => e.name).toList(),
                      postfixInitText: localeStr.transferViewSiteHint,
                      postfixTextStream: widget.store.site2ValueStream,
                      clearValueOnMenuChanged: true,
                      changeNotify: (data) {
                        if (data == null) return;
                        print('display selected: $data');
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
                      parentWidth: MediaQuery.of(context).size.width,
                      maxInputLength: 6,
                      minusHeight: 8,
                    ),
                    /* Amount Chip */
                    new CustomizeInputChipContainer(
                      prefixTitle: localeStr.transferViewTitleOption,
                      titleLetterSpacing: 4,
                      labels: chipLabels,
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
              child: RaisedButton(
                child: Text(localeStr.btnConfirm),
                textColor: Themes.defaultTextColorBlack,
                onPressed: () => _validateForm(),
              ),
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Themes.defaultTextColor,
                ),
                children: [
                  TextSpan(
                    text: '${localeStr.balanceHintTextTitle}\n',
                    style: TextStyle(
                      color: Themes.defaultTextColorWhite,
                      fontWeight: FontWeight.bold,
                      height: 3,
                    ),
                  ),
                  TextSpan(
                    text:
                        '${localeStr.balanceHintText1}\n${localeStr.balanceHintText2}\n${localeStr.balanceHintText3}',
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