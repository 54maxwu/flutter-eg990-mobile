import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/domain/core/failures.dart';
import 'package:flutter_eg990_mobile/domain/sector/bankcard/bankcard_form_data.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';
import 'package:flutter_eg990_mobile/presentation/common/fields/field_dropdown_widget.dart';
import 'package:flutter_eg990_mobile/presentation/common/fields/field_input_widget.dart';
import 'package:flutter_eg990_mobile/presentation/common/other/warning_display.dart';
import 'package:flutter_eg990_mobile/presentation/common/toast/toast_text.dart';
import 'package:flutter_eg990_mobile/presentation/router/navigate.dart';
import 'package:mobx/mobx.dart' show ReactionDisposer, reaction;

import '../state/bankcard_store.dart';
import 'bankcard_display_provider.dart';

typedef OnForwardBankcard = void Function(BankcardNewData);

class NewBankcardPageOne extends StatefulWidget {
  final OnForwardBankcard onTapForward;
  final Function onCancel;

  NewBankcardPageOne({
    @required this.onTapForward,
    @required this.onCancel,
  });

  @override
  _NewBankcardPageOneState createState() => _NewBankcardPageOneState();
}

class _NewBankcardPageOneState extends State<NewBankcardPageOne>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FieldInputWidgetState> _holderFieldKey =
      new GlobalKey(debugLabel: 'holder');
  final GlobalKey<FieldDropdownWidgetState> _bankOptionKey =
      new GlobalKey(debugLabel: 'bank');
  final GlobalKey<FieldInputWidgetState> _accountFieldKey =
      new GlobalKey(debugLabel: 'cardno');

  List<ReactionDisposer> _disposers;
  BankcardStore _store;
  BankcardData _data;
  Map<String, String> _banksMap;

  bool _lockedBtn = false;

  Widget _divider;

  void _initDisposers() {
    _disposers ??= [
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.banksMap,
        // Run some logic with the content of the observed field
        (map) {
          debugPrint('reaction on banks map');
          if (mounted && _banksMap != map) {
            setState(() {
              debugPrint('set banks map: ${map.length}');
              _banksMap = map;
            });
          }
        },
      ),
    ];
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _data = new BankcardData();
    super.initState();
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _store ??= Provider.of<BankcardDisplayProvider>(context).store;
    super.build(context);
    if (_store == null) {
      return WarningDisplay(
          message:
              Failure.internal(FailureCode(type: FailureType.INHERIT)).message,
          widthFactor: 1,
          highlight: false);
    }
    _divider ??= Divider(
      height: 1,
      indent: 16,
      endIndent: 16,
      color: themeColor.defaultHintSubColor.withOpacity(0.5),
    );
    // listen to store data change
    if (_disposers == null) {
      _initDisposers();
    }
    // get banks map
    if (_store.banksMap == null) {
      _store.getBanks();
    } else {
      _banksMap ??= _store.banksMap;
    }
    return Container(
      // color: themeColor.defaultBackgroundColor,
      alignment: Alignment.topCenter,
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            ///
            /// Cardholder Field
            ///
            ListTile(
              tileColor: themeColor.defaultBackgroundColor,
              title: Text(
                localeStr.fieldTitleCardHolder,
                style: TextStyle(
                  fontSize: FontSize.MESSAGE.value,
                  color: themeColor.defaultTextColor,
                  height: 2.0,
                ),
              ),
              subtitle: FieldInputWidget(
                key: _holderFieldKey,
                maxInputLength: InputLimit.NAME_MAX,
                enableSuggestions: false,
                inputDecoration: InputDecoration(
                  hintText: localeStr.fieldHintCardholder,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
                inputStyle: TextStyle(
                  fontSize: FontSize.SUBTITLE.value,
                  color: themeColor.fieldInputTextColor,
                ),
                onChanged: (value) => _data = _data.copyWith(cardholder: value),
                validator: (_) => _data.isCardholderValid
                    ? null
                    : localeStr.fieldErrorInvalidCardholder,
              ),
            ),

            ///
            /// Cardholder Hint
            ///
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: RichText(
                maxLines: 3,
                textAlign: TextAlign.left,
                text: TextSpan(
                  text: localeStr.newBankcardCardholderHint,
                  style: TextStyle(
                    fontSize: FontSize.NORMAL.value,
                    color: themeColor.defaultHintColor,
                  ),
                ),
              ),
            ),

            ///
            /// Bank Option
            ///
            Container(
              color: themeColor.defaultBackgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(
                      localeStr.fieldTitleBank,
                      style: TextStyle(
                        fontSize: FontSize.SUBTITLE.value,
                        color: themeColor.defaultTextColor,
                        height: 2.0,
                      ),
                    ),
                    subtitle: (_banksMap == null)
                        ? Row(children: [
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: SizedBox.fromSize(
                                  size: Size(16, 16),
                                  child: CircularProgressIndicator(),
                                )),
                          ])
                        : FieldDropdownWidget(
                            key: _bankOptionKey,
                            optionValues: (_banksMap != null)
                                ? _banksMap.keys.toList()
                                : [],
                            optionStrings: (_banksMap != null)
                                ? _banksMap.values.toList()
                                : [],
                            clearValueOnOptionChanged: true,
                            changeNotify: (key) {
                              // clear text field focus
                              FocusScope.of(context).unfocus();
                              // Update target bank data
                              _data = _data.copyWith(bankId: key);
                            },
                          ),
                  ),
                  _divider,
                ],
              ),
            ),

            ///
            /// Bank Account Field
            ///
            Container(
              color: themeColor.defaultBackgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(
                      localeStr.fieldTitleBankAccount,
                      style: TextStyle(
                        fontSize: FontSize.SUBTITLE.value,
                        color: themeColor.defaultTextColor,
                        height: 2.0,
                      ),
                    ),
                    subtitle: FieldInputWidget(
                      key: _accountFieldKey,
                      inputType: FieldInputType.Numbers,
                      maxInputLength: InputLimit.CARD_MAX,
                      enableSuggestions: false,
                      inputDecoration: InputDecoration(
                        hintText: localeStr.fieldHintBankAccount,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      inputStyle: TextStyle(
                        fontSize: FontSize.SUBTITLE.value,
                        color: themeColor.fieldInputTextColor,
                      ),
                      onChanged: (value) =>
                          _data = _data.copyWith(cardNumber: value),
                      validator: (_) => _data.isCardNumberValid
                          ? null
                          : localeStr.fieldErrorCardNumber(
                              InputLimit.CARD_MIN,
                              InputLimit.CARD_MAX,
                            ),
                    ),
                  ),
                  _divider,
                ],
              ),
            ),
            Container(
              color: themeColor.defaultBackgroundColor,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  ///
                  /// Bank Account Hint
                  ///
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: RichText(
                      maxLines: 3,
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: localeStr.newBankcardCardNumberHint,
                        style: TextStyle(
                          fontSize: FontSize.NORMAL.value,
                          color: themeColor.defaultHintColor,
                        ),
                      ),
                    ),
                  ),

                  ///
                  /// Forward Button
                  ///
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: RaisedButton(
                            onPressed: () {
                              // check button lock
                              if (_lockedBtn) {
                                callToast(localeStr.errorActionTooFrequent);
                                return;
                              }
                              _lockedBtn = true;
                              // verify field input
                              final cardInfo =
                                  BankcardNewData.dirty(data: _data);
                              debugPrint('new bankcard data: $cardInfo');
                              debugPrint(
                                  'new bankcard data error: ${cardInfo.error}');
                              if (cardInfo.valid) {
                                widget.onTapForward(cardInfo);
                              } else {
                                callToast(localeStr.msgFormNotFilled);
                              }
                              // release button lock after 1 second
                              Future.delayed(
                                Duration(seconds: 1),
                                () => _lockedBtn = false,
                              );
                            },
                            child: Text(
                              localeStr.btnNextStep,
                              style: TextStyle(
                                fontSize: FontSize.SUBTITLE.value,
                                color: themeColor.buttonTextPrimaryColor,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            ///
            /// Service Text
            ///
            Container(
              padding: const EdgeInsets.only(top: 24, bottom: 30),
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                    text: localeStr.pageBtnContactCsPrefix,
                    style: TextStyle(
                      fontSize: FontSize.MESSAGE.value,
                      color: themeColor.defaultHintColor,
                    ),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: FlatButton(
                      visualDensity: VisualDensity.compact,
                      child: Text(
                        localeStr.pageBtnContactCs,
                        style: TextStyle(
                          fontSize: FontSize.MESSAGE.value,
                          color: themeColor.hintHyperLink,
                        ),
                      ),
                      onPressed: () =>
                          AppNavigator.navigateTo(RoutePage.service),
                    ),
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
