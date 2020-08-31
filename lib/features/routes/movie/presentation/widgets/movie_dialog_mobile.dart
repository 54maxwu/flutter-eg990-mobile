import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/dialog_widget.dart';

import '../state/movie_store.dart';

class MovieDialogMobile extends StatefulWidget {
  final MovieStore store;
  final String mobile;

  MovieDialogMobile({
    @required this.store,
    @required this.mobile,
  });

  @override
  _MovieDialogMobileState createState() => _MovieDialogMobileState();
}

class _MovieDialogMobileState extends State<MovieDialogMobile>
    with AfterLayoutMixin {
  static final GlobalKey<DialogWidgetState> _dialogKey =
      new GlobalKey(debugLabel: 'dialog');
  static final GlobalKey<FormState> _formKey =
      new GlobalKey(debugLabel: 'form');

  final GlobalKey<CustomizeFieldWidgetState> _phoneFieldKey =
      new GlobalKey(debugLabel: 'phone');
  final GlobalKey<CustomizeFieldWidgetState> _verifyFieldKey =
      new GlobalKey(debugLabel: 'verify');

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      key: _dialogKey,
      heightFactor: 0.4,
      minHeight: (Global.device.width > 360) ? 305 : 330,
      maxHeight: (Global.device.width > 360) ? 350 : 375,
      debug: true,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Text(
                  localeStr.userVerifyButtonText(''),
                  style: TextStyle(color: Themes.defaultAccentColor),
                ),
              ),
              new Form(
                key: _formKey,
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    new CustomizeFieldWidget(
                      key: _phoneFieldKey,
                      fieldType: FieldType.Numbers,
                      hint: '',
                      persistHint: false,
                      prefixText: localeStr.centerTextTitlePhone,
                      titleLetterSpacing: 3,
                      suffixText: localeStr.userVerifyButtonText('\n'),
                      suffixLetterWidth: 3.6,
                      suffixAction: (input) async {
                        String msg = await widget.store.requestVerifyPhone(
                            _phoneFieldKey.currentState.getInput);
                        if (msg.isNotEmpty) callToastInfo(msg);
                      },
                      readOnly: true,
                    ),
                    new CustomizeFieldWidget(
                      key: _verifyFieldKey,
                      fieldType: FieldType.NoChinese,
                      hint: '',
                      persistHint: false,
                      prefixText: localeStr.userVerifyFieldTitle,
                      titleLetterSpacing: 3,
                      maxInputLength: 12,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Icon(
                        Icons.info,
                        color: Themes.hintHighlight,
                        size: 16.0,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        localeStr.userVerifyFieldInfo,
                        style: TextStyle(
                          color: Themes.hintHighlight,
                        ),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              ),
              /* Login Buttons */
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: RaisedButton(
                  child: Text(localeStr.btnConfirm),
                  onPressed: () {
                    // clear text field focus
                    FocusScope.of(context).unfocus();
                    _validateForm();
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _validateForm() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
//      print('The user wants to login with $_username and $_password');
      String verifyCode = _verifyFieldKey?.currentState?.getInput ?? '';
      if (verifyCode.isNotEmpty) {
        final success =
            await widget.store.postPhoneVerifyCode(widget.mobile, verifyCode);
        // close dialog and show message if verify success
        if (success) {
          Future.delayed(Duration(milliseconds: 300), () {
            Navigator.of(context).pop();
          }).whenComplete(() => callToastInfo(
                localeStr.messageVerifySuccess,
                icon: Icons.check_circle_outline,
              ));
        }
      } else {
        callToast(localeStr.messageInvalidVerify);
      }
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _phoneFieldKey.currentState?.setInput = widget.mobile;
  }
}
