import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart' show Observer;
import 'package:flutter_ty_mobile/features/export_internal_file.dart';
import 'package:flutter_ty_mobile/features/general/widgets/dialog_widget.dart';

import '../state/wallet_store.dart';

class WalletDialog extends StatefulWidget {
  final WalletStore store;

  WalletDialog({this.store});

  @override
  _WalletDialogState createState() => _WalletDialogState();
}

class _WalletDialogState extends State<WalletDialog> {
  static final GlobalKey<DialogWidgetState> _dialogKey =
      new GlobalKey(debugLabel: 'dialog');

  bool isSuccess;

  @override
  void dispose() {
    widget.store.closeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      key: _dialogKey,
      maxHeight: 186.0,
      widthShrink: 64.0,
      transparentBg: true,
      onClose: () {
        widget.store.showingDialog = false;
        widget.store.closeStream();
      },
      children: <Widget>[
        Observer(
          builder: (_) {
            if (widget.store.transferSuccess == null) {
              /// Waiting Dialog
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 18.0),
                    child: Text(
                      localeStr.walletViewHintOneClickWait,
                      style: TextStyle(
                        fontSize: FontSize.TITLE.value,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      '${widget.store.transferProgress}',
                      style: TextStyle(
                        fontSize: FontSize.SUBTITLE.value,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            } else if (widget.store.transferSuccess) {
              /// Success Dialog
              Future.delayed(Duration(seconds: 3), () {
                // close dialog automatically
                try {
                  if (widget.store.showingDialog) {
                    widget.store.showingDialog = false;
                    widget.store.closeStream();
                    Navigator.of(context).pop();
                  }
                } catch (e) {}
              });
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 18.0),
                    child: Text(
                      localeStr.messageTaskSuccess(
                          localeStr.walletViewButtonOneClick),
                      style: TextStyle(
                        fontSize: FontSize.TITLE.value,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Icon(
                          Icons.check,
                          size: 64,
                          color: Themes.defaultAccentColor,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              /// Failed Dialog
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                    child: Text(
                      localeStr.messagePartFailed,
                      style: TextStyle(
                        fontSize: FontSize.TITLE.value,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Icon(
                          Icons.error,
                          size: 64,
                          color: Themes.defaultErrorColor,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text(
                            '${widget.store.transferErrorList}',
                            style: TextStyle(fontSize: FontSize.SUBTITLE.value),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
