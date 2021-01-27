import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/domain/core/failures.dart';
import 'package:flutter_eg990_mobile/domain/sector/bankcard/bankcard_form_data.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';
import 'package:flutter_eg990_mobile/presentation/common/fields/field_input_widget.dart';
import 'package:flutter_eg990_mobile/presentation/common/other/warning_display.dart';
import 'package:flutter_eg990_mobile/presentation/common/toast/toast_text.dart';
import 'package:flutter_eg990_mobile/presentation/router/navigate.dart';

import '../state/bankcard_store.dart';
import 'bankcard_display_provider.dart';

typedef OnForwardBankcardAddress = void Function(BankcardNewAddress);

class NewBankcardPageTwo extends StatefulWidget {
  final OnForwardBankcardAddress onTapForward;
  final Function onTapBackward;

  NewBankcardPageTwo({
    @required this.onTapForward,
    @required this.onTapBackward,
  });

  @override
  _NewBankcardPageTwoState createState() => _NewBankcardPageTwoState();
}

class _NewBankcardPageTwoState extends State<NewBankcardPageTwo>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FieldInputWidgetState> _branchFieldKey =
      new GlobalKey(debugLabel: 'branch');
  final GlobalKey<FieldInputWidgetState> _provinceFieldKey =
      new GlobalKey(debugLabel: 'province');
  final GlobalKey<FieldInputWidgetState> _areaFieldKey =
      new GlobalKey(debugLabel: 'area');

  BankcardStore _store;
  BankcardAddressData _data;

  bool _lockedBtn = false;

  Widget _divider;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _data = new BankcardAddressData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
            /// Branch Field
            ///
            Container(
              color: themeColor.defaultBackgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    tileColor: themeColor.defaultBackgroundColor,
                    title: Text(
                      '${localeStr.fieldTitleBankBranch} *',
                      style: TextStyle(
                        fontSize: FontSize.MESSAGE.value,
                        color: themeColor.defaultTextColor,
                        height: 2.0,
                      ),
                    ),
                    subtitle: FieldInputWidget(
                      key: _branchFieldKey,
                      maxInputLength: InputLimit.NAME_MAX,
                      enableSuggestions: false,
                      inputDecoration: InputDecoration(
                        hintText: localeStr.fieldHintBankBranch,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      inputStyle: TextStyle(
                        fontSize: FontSize.SUBTITLE.value,
                        color: themeColor.fieldInputTextColor,
                      ),
                      onChanged: (value) =>
                          _data = _data.copyWith(branch: value.trim()),
                      validator: (_) => _data.branch.isNotEmpty
                          ? null
                          : localeStr.fieldErrorInvalidFormat,
                    ),
                  ),
                  _divider,
                ],
              ),
            ),

            ///
            /// Province Field
            ///
            Container(
              color: themeColor.defaultBackgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    tileColor: themeColor.defaultBackgroundColor,
                    title: Text(
                      '${localeStr.fieldTitleBankProvince} *',
                      style: TextStyle(
                        fontSize: FontSize.MESSAGE.value,
                        color: themeColor.defaultTextColor,
                        height: 2.0,
                      ),
                    ),
                    subtitle: FieldInputWidget(
                      key: _provinceFieldKey,
                      maxInputLength: InputLimit.NAME_MAX,
                      enableSuggestions: false,
                      inputDecoration: InputDecoration(
                        hintText: localeStr.fieldHintBankProvince,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      inputStyle: TextStyle(
                        fontSize: FontSize.SUBTITLE.value,
                        color: themeColor.fieldInputTextColor,
                      ),
                      onChanged: (value) =>
                          _data = _data.copyWith(province: value.trim()),
                      validator: (_) => _data.province.isNotEmpty
                          ? null
                          : localeStr.fieldErrorInvalidFormat,
                    ),
                  ),
                  _divider,
                ],
              ),
            ),

            ///
            /// Area Field
            ///
            Container(
              color: themeColor.defaultBackgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    tileColor: themeColor.defaultBackgroundColor,
                    title: Text(
                      localeStr.fieldTitleBankArea,
                      style: TextStyle(
                        fontSize: FontSize.MESSAGE.value,
                        color: themeColor.defaultTextColor,
                        height: 2.0,
                      ),
                    ),
                    subtitle: FieldInputWidget(
                      key: _areaFieldKey,
                      maxInputLength: InputLimit.NAME_MAX,
                      enableSuggestions: false,
                      inputDecoration: InputDecoration(
                        hintText: localeStr.fieldHintBankArea,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      inputStyle: TextStyle(
                        fontSize: FontSize.SUBTITLE.value,
                        color: themeColor.fieldInputTextColor,
                      ),
                      onChanged: (value) =>
                          _data = _data.copyWith(area: value.trim()),
                      validator: null,
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
                  /// Bank Address Hint
                  ///
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: RichText(
                      maxLines: 3,
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: localeStr.newBankcardCardAddressHint,
                        style: TextStyle(
                          fontSize: FontSize.NORMAL.value,
                          color: themeColor.defaultHintColor,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      ///
                      /// Backward Button
                      ///
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: RaisedButton(
                            onPressed: widget.onTapBackward,
                            child: Text(
                              localeStr.btnPreStep,
                              style: TextStyle(
                                fontSize: FontSize.SUBTITLE.value,
                                color: themeColor.buttonTextPrimaryColor,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),

                      ///
                      /// Forward Button
                      ///
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
                              final cardAddress =
                                  BankcardNewAddress.dirty(data: _data);
                              debugPrint(
                                  'new bankcard address data: $cardAddress');
                              debugPrint(
                                  'new bankcard address data error: ${cardAddress.error}');
                              // release button lock after 1 second
                              Future.delayed(
                                Duration(seconds: 1),
                                () => _lockedBtn = false,
                              );
                              if (cardAddress.valid) {
                                widget.onTapForward(cardAddress);
                              } else {
                                callToast(localeStr.msgFormNotFilled);
                              }
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
