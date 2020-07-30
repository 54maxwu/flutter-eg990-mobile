import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/export_internal_file.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_titled_container.dart';
import 'package:flutter_ty_mobile/utils/value_util.dart';

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

  List<String> radioLabels = [
    localeStr.withdrawViewOptionVirtual,
    localeStr.withdrawViewOptionCgp,
    localeStr.withdrawViewOptionCpw,
  ];
  List<String> hintTexts = [
    localeStr.withdrawViewOptionHint1,
    localeStr.withdrawViewOptionHint2,
    localeStr.withdrawViewOptionHint3,
  ];

  // TODO observe rollback string
  String _flowLimit = '￥0';
  int _typeSelected = 0;

  void _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      WithdrawForm dataForm = WithdrawForm(
        amount: _amountFieldKey.currentState.getInput,
        password: _passwordFieldKey.currentState.getInput,
        type: _typeSelected.toString(),
      );
      if (dataForm.isValid) {
        print('bankcard form: ${dataForm.toJson()}');
        if (widget.store.waitForWithdrawResult)
          FLToast.showText(
            text: localeStr.messageWait,
            showDuration: ToastDuration.DEFAULT.value,
            position: FLToastPosition.top,
          );
        else
          widget.store.sendRequest(dataForm);
      } else {
        FLToast.showText(
          text: localeStr.messageActionFillForm,
          position: FLToastPosition.top,
          showDuration: ToastDuration.DEFAULT.value,
        );
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
                    maxInputLength: 8,
                    errorMsg: localeStr.messageInvalidDepositAmount,
                    validCondition: (value) => rangeCheck(
                      value: (value.isNotEmpty) ? int.parse(value) : 0,
                      min: 100,
                    ),
                  ),
                  /* Password Input Field */
                  new CustomizeFieldWidget(
                    key: _passwordFieldKey,
                    fieldType: FieldType.Password,
                    persistHint: false,
                    prefixText: localeStr.withdrawViewTitlePwd,
                    titleLetterSpacing: 4,
                    maxInputLength: 20,
                    errorMsg: localeStr.messageInvalidWithdrawPassword,
                    validCondition: (value) =>
                        rangeCheck(value: value.length, min: 4, max: 20),
                  ),
                ],
              ),
            ),
          ),
          CustomizeTitledContainer(
            childAlignment: Alignment.topLeft,
            heightFactor: 3.6,
            prefixText: localeStr.withdrawViewTitleNote,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: radioLabels.length + hintTexts.length,
                  itemBuilder: (context, index) {
                    if (index < radioLabels.length) {
                      /* Radio Options */
                      return Row(
                        children: <Widget>[
                          Radio(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                            value: index,
                            groupValue: _typeSelected,
                            onChanged: (value) {
                              if ((value == 1 && widget.store.cgpUrl.isEmpty) ||
                                  (value == 2 && widget.store.cpwUrl.isEmpty)) {
                                FLToast.showText(
                                  text: (value == 1)
                                      ? localeStr.messageErrorBindCgp
                                      : localeStr.messageErrorBindCpw,
                                  position: FLToastPosition.top,
                                  showDuration: ToastDuration.DEFAULT.value,
                                );
                                return;
                              }
                              setState(() {
                                _typeSelected = value;
                              });
                              print('selected type: $_typeSelected');
                            },
                          ),
                          Text(radioLabels[index]),
                        ],
                      );
                    } else {
                      /* Hint Texts */
                      int hintIndex = index - radioLabels.length;
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                            child: Icon(
                              const IconData(0xf05a, fontFamily: 'FontAwesome'),
                              color: Themes.hintHyperLink,
                              size: FontSize.NORMAL.value,
                            ),
                          ),
                          // Wrapped with expand to prevent text overflow and disappear
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: RichText(
                                softWrap: true,
                                maxLines: (hintIndex == 2) ? 2 : 1,
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: hintTexts[hintIndex],
                                      style: TextStyle(
                                        color: Themes.hintHyperLink,
                                      ),
                                    ),
                                    if (hintIndex == 1)
                                      TextSpan(
                                        text: _flowLimit,
                                        style: TextStyle(
                                          color: Themes.hintHyperLink,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          /* Confirm Button */
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: Global.device.comfortButtonHeight,
                    child: RaisedButton(
                      child: Text(localeStr.btnSubmit),
                      textColor: Themes.defaultTextColorBlack,
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
