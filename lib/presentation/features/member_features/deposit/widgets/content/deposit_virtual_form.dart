import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/domain/sector/deposit/form/deposit_form.dart';
import 'package:flutter_eg990_mobile/domain/sector/deposit/form/deposit_form_data.dart';
import 'package:flutter_eg990_mobile/domain/sector/deposit/types/deposit_method.dart';
import 'package:flutter_eg990_mobile/presentation/common/fields/input_field.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';
import 'package:flutter_eg990_mobile/presentation/common/toast/toast_text.dart';
import 'package:flutter_eg990_mobile/utils/value_util.dart';
import 'package:intl/intl.dart' show NumberFormat;

class DepositVirtualFormWidget extends StatefulWidget {
  final OnDepositRequest onDepositRequest;
  final DepositMethodVirtualData method;

  DepositVirtualFormWidget({
    Key key,
    @required this.onDepositRequest,
    @required this.method,
  }) : super(key: key);

  @override
  DepositVirtualFormWidgetState createState() =>
      DepositVirtualFormWidgetState();
}

class DepositVirtualFormWidgetState extends State<DepositVirtualFormWidget> {
  final GlobalKey<FieldInputWidgetState> _amountFieldKey =
      new GlobalKey(debugLabel: 'amount');

  DepositTargetBank _target = DepositTargetBank.pure();
  DepositInfo _info = DepositInfo.pure();

  DepositMethodVirtualData _selected;

  void setSelectedTarget() {
    _selected = widget.method;
    _target = DepositTargetBank.dirty(
      data: DepositTargetBankData.online(
        bankId: _selected.bankAccountId,
        bankIndex: '${_selected.key}'.strToInt,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setSelectedTarget();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            color: themeColor.defaultBackgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///
                /// Amount Input Field
                ///
                FieldWrapperWidget(
                  padding: const EdgeInsets.only(top: 8.0),
                  fieldPadding: const EdgeInsets.only(top: 2.0),
                  prefixWidget: FieldPrefixWidget.text(
                    prefixText: localeStr.fieldTitleCreditAmount,
                    textStyle: TextStyle(
                      fontSize: FontSize.MESSAGE.value,
                      color: themeColor.defaultTextColor,
                    ),
                  ),
                  inputWidget: FieldInputWidget(
                    key: _amountFieldKey,
                    inputType: FieldInputType.Numbers,
                    maxInputLength: '${_selected.max}'.length,
                    enableSuggestions: false,
                    inputDecoration: InputDecoration(
                      hintText:
                          localeStr.fieldErrorInvalidCreditMin(_selected.min),
                      hintStyle: TextStyle(
                        fontSize: FontSize.MESSAGE.value,
                        color: themeColor.defaultHintColor,
                      ),
                    ),
                    onChanged: (value) => _info = DepositInfo.dirty(
                      data: DepositInfoData.online(
                        amountData: ValueRangeData(
                          value: value?.strToInt ?? -1,
                          min: _selected.min,
                          max: _selected.max,
                        ),
                        gateway: '${_selected.gateway}',
                      ),
                    ),
                    validator: (_) => _info.valid
                        ? null
                        : localeStr.fieldErrorInvalidCreditAmount,
                  ),
                ),

                ///
                /// Amount Limit Hint
                ///
                Padding(
                  padding: const EdgeInsets.fromLTRB(4.0, 6.0, 4.0, 6.0),
                  child: Text(
                    localeStr.depositHintOrderMaxAmount(
                        NumberFormat.simpleCurrency(decimalDigits: 0)
                            .format(_selected.max)),
                    style: TextStyle(color: themeColor.hintHighlight),
                  ),
                ),
                Divider(thickness: 0.2),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
                  child: Text(
                    '建議您存入特殊金額，以便存款快速匹配到帳(例如：105, 503等)',
                    style: TextStyle(
                      fontSize: FontSize.MESSAGE.value,
                      color: themeColor.defaultHintColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton(
              child: Text(
                localeStr.btnSend,
                style: TextStyle(
                  fontSize: FontSize.MESSAGE.value,
                  color: themeColor.secondaryTextColor1,
                ),
              ),
              onPressed: () {
                // clear text field focus
                FocusScope.of(context).unfocus();
                final form = DepositForm(target: _target, info: _info);
                debugPrint('deposit form: $form');
                if (form.validate.isRight()) {
                  debugPrint('deposit form is valid');
                  widget.onDepositRequest(form);
                } else if (form.status.index == 0) {
                  callToast(localeStr.msgFormNotFilled);
                } else {
                  debugPrint(
                      'deposit form error: ${form.validate.getOrElse(() => null)}');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
