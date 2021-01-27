import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/domain/core/failures.dart';
import 'package:flutter_eg990_mobile/domain/sector/bankcard/bankcard_form_data.dart';
import 'package:flutter_eg990_mobile/infrastructure/hive/hive_actions.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';
import 'package:flutter_eg990_mobile/presentation/common/fields/field_input_widget.dart';
import 'package:flutter_eg990_mobile/presentation/common/other/countdown_text_widget.dart';
import 'package:flutter_eg990_mobile/presentation/common/other/warning_display.dart';
import 'package:flutter_eg990_mobile/presentation/common/toast/toast_info_widget.dart';
import 'package:flutter_eg990_mobile/presentation/common/toast/toast_text.dart';
import 'package:flutter_eg990_mobile/presentation/router/navigate.dart';
import 'package:flutter_eg990_mobile/utils/datetime_format.dart';

import '../state/bankcard_store.dart';
import 'bankcard_display_provider.dart';

typedef OnForwardBankcardMobile = void Function(BankcardNewMobile);

class NewBankcardPageThree extends StatefulWidget {
  final OnForwardBankcardMobile onConfirm;
  final Function onTapBackward;

  NewBankcardPageThree({
    @required this.onConfirm,
    @required this.onTapBackward,
  });

  @override
  _NewBankcardPageThreeState createState() => _NewBankcardPageThreeState();
}

class _NewBankcardPageThreeState extends State<NewBankcardPageThree>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FieldInputWidgetState> _phoneFieldKey =
      new GlobalKey(debugLabel: 'phone');
  final GlobalKey<FieldInputWidgetState> _codeFieldKey =
      new GlobalKey(debugLabel: 'code');

  final String lastVerifyKey = 'lastVerifyRequest';
  final GlobalKey<CountdownTextWidgetState> _timerKey =
      new GlobalKey(debugLabel: 'timer');

  BankcardStore _store;
  BankcardMobileData _data;

  Future<void> checkVerifyFuture;
  Duration _remainCountDown;
  bool _lockedBtn = false;
  bool _countDown = false;

  Widget _divider;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _data = new BankcardMobileData();
    super.initState();
    checkVerifyFuture = Future.wait([_getLastVerifyRequestTimer()]);
  }

  @override
  void didUpdateWidget(NewBankcardPageThree oldWidget) {
    checkVerifyFuture = null;
    super.didUpdateWidget(oldWidget);
    checkVerifyFuture = Future.wait([_getLastVerifyRequestTimer()]);
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
            /// Mobile Field
            ///
            Container(
              color: themeColor.defaultBackgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    tileColor: themeColor.defaultBackgroundColor,
                    title: Text(
                      localeStr.fieldTitlePhone,
                      style: TextStyle(
                        fontSize: FontSize.MESSAGE.value,
                        color: themeColor.defaultTextColor,
                        height: 2.0,
                      ),
                    ),
                    subtitle: FieldInputWidget(
                      key: _phoneFieldKey,
                      inputType: FieldInputType.Numbers,
                      maxInputLength: InputLimit.PHONE_MAX,
                      enableSuggestions: false,
                      inputDecoration: InputDecoration(
                        hintText: (InputLimit.PHONE_MAX == InputLimit.PHONE_MIN)
                            ? localeStr.fieldHintPhoneArg(InputLimit.PHONE_MAX)
                            : localeStr.fieldHintPhoneArg2(
                                InputLimit.PHONE_MIN,
                                InputLimit.PHONE_MAX,
                              ),
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      inputStyle: TextStyle(
                        fontSize: FontSize.SUBTITLE.value,
                        color: themeColor.fieldInputTextColor,
                      ),
                      onChanged: (value) =>
                          _data = _data.copyWith(mobile: value),
                      validator: (_) => _data.isNumberValid
                          ? null
                          : localeStr
                              .fieldErrorInvalidPhone(InputLimit.PHONE_MAX),
                    ),
                  ),
                  _divider,
                ],
              ),
            ),

            ///
            /// Verify Field
            ///
            Container(
              color: themeColor.defaultBackgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    tileColor: themeColor.defaultBackgroundColor,
                    title: Text(
                      localeStr.fieldTitleVerifyCode,
                      style: TextStyle(
                        fontSize: FontSize.MESSAGE.value,
                        color: themeColor.defaultTextColor,
                        height: 2.0,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Expanded(
                          child: FieldInputWidget(
                            key: _codeFieldKey,
                            maxInputLength: InputLimit.VERIFY,
                            enableSuggestions: false,
                            inputDecoration: InputDecoration(
                              hintText: localeStr.fieldHintVerifyCode,
                              contentPadding: EdgeInsets.symmetric(vertical: 8),
                            ),
                            inputStyle: TextStyle(
                              fontSize: FontSize.SUBTITLE.value,
                              color: themeColor.fieldInputTextColor,
                            ),
                            onChanged: (value) =>
                                _data = _data.copyWith(verifyCode: value),
                            validator: (_) => _data.hasVerifyCode
                                ? null
                                : localeStr.fieldErrorInvalidVerify,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: FutureBuilder(
                            future: checkVerifyFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (_countDown) {
                                  return RaisedButton(
                                    child: CountdownTextWidget(
                                      _timerKey,
                                      duration: _remainCountDown ??
                                          Duration(seconds: 180),
                                      callback: () {
                                        setState(() => _countDown = false);
                                      },
                                    ),
                                    onPressed: null,
                                  );
                                } else {
                                  return RaisedButton(
                                    child: Text(
                                      localeStr.fieldActionGetVerifyCode,
                                      style: TextStyle(
                                        fontSize: FontSize.SUBTITLE.value,
                                        color:
                                            themeColor.buttonTextPrimaryColor,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_store.lockVerify) {
                                        callToastInfo(localeStr.msgPleaseWait);
                                        return;
                                      }

                                      // clear text field focus
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                      // send verify request
                                      _store
                                          .getVerifyCode(
                                              BankcardNewMobile.dirty(
                                                  data: _data))
                                          .then((success) {
                                        // start count down if success
                                        if (success && mounted) {
                                          callToast(
                                              localeStr.msgMobileVerifySent);
                                          _remainCountDown = null;
                                          _saveLastVerifyRequestTime();
                                          setState(() {
                                            _countDown = true;
                                          });
                                        } else {
                                          callToast(
                                              localeStr.fieldErrorInvalidPhone(
                                                  InputLimit.PHONE_MAX));
                                        }
                                      });
                                    },
                                  );
                                }
                              } else {
                                return RaisedButton(
                                  onPressed: null,
                                  child: Text(
                                    localeStr.fieldActionGetVerifyCode,
                                    style: TextStyle(
                                      fontSize: FontSize.SUBTITLE.value,
                                      color: themeColor.buttonTextPrimaryColor,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  _divider,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Text(
                          localeStr.fieldHintVerifyCodeFetch,
                          style: TextStyle(
                            color: themeColor.defaultHintColor,
                            height: 2.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              color: themeColor.defaultBackgroundColor,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  ///
                  /// Mobile Hint
                  ///
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: RichText(
                      maxLines: 3,
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: localeStr.newBankcardCardMobileHint,
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
                              final cardMobile =
                                  BankcardNewMobile.dirty(data: _data);
                              debugPrint(
                                  'new bankcard mobile data: $cardMobile');
                              debugPrint(
                                  'new bankcard mobile data error: ${cardMobile.error}');
                              if (cardMobile.valid) {
                                widget.onConfirm(cardMobile);
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

  Future<void> _getLastVerifyRequestTimer() async {
    try {
      Box box = await Future.value(getHiveBox(Global.CACHED_TIME_DATA));
      if (box.containsKey(lastVerifyKey)) {
        final DateTime lastTime = '${box.get(lastVerifyKey)}'.toDatetime();
        if (lastTime.isAfterSeconds(180)) {
          _countDown = false;
          debugPrint('no remaining count down');
        } else {
//          debugPrint('now: ${DateTime.now()} last: $lastTime');
          int passed = DateTime.now().difference(lastTime).inSeconds;
          debugPrint('count down passed: $passed');
          if (passed > 180) return;
          _remainCountDown = Duration(seconds: 180 - passed);
          debugPrint('remain count down: $_remainCountDown');
          _countDown = true;
        }
      }
    } catch (e) {
      debugPrint('read last verify datetime has error!! $e');
      MyLogger.debug(msg: 'read last verify datetime has error!! $e');
    }
  }

  void _saveLastVerifyRequestTime() async {
    try {
      Box box = await Future.value(getHiveBox(Global.CACHED_TIME_DATA));
      box.put(lastVerifyKey, DateTime.now().toString());
      debugPrint('write last verify datetime success');
    } catch (e) {
      debugPrint('write last verify datetime has error!! $e');
      MyLogger.debug(msg: 'write last verify datetime has error!! $e');
    }
  }
}
