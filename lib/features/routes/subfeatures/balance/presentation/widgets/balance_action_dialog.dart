import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/internal/local_strings.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/dialog_widget.dart';
import 'package:flutter_eg990_mobile/features/themes/theme_interface.dart';

typedef BalanceDialogCall = Future<bool> Function();

class BalanceActionDialog extends StatefulWidget {
  final bool isTransferIn;
  final String targetPlatform;
  final BalanceDialogCall onConfirm;

  BalanceActionDialog({
    @required this.targetPlatform,
    @required this.isTransferIn,
    this.onConfirm,
  })  : assert(isTransferIn != null),
        assert(targetPlatform != null && targetPlatform.isNotEmpty);

  @override
  _BalanceActionDialogState createState() => _BalanceActionDialogState();
}

class _BalanceActionDialogState extends State<BalanceActionDialog> {
  bool _waiting = false;

  @override
  Widget build(BuildContext context) {
    String actionText = (widget.isTransferIn)
        ? localeStr.balanceTransferInText
        : localeStr.balanceTransferOutText;
    return DialogWidget(
      heightFactor: 0.25,
      minHeight: 144,
      maxHeight: 168,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      localeStr.balanceTransferAlertTitle,
                      style: TextStyle(
                        fontSize: FontSize.MESSAGE.value,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      localeStr.balanceTransferAlertMsg(
                        actionText.toLowerCase(),
                        widget.targetPlatform.toUpperCase(),
                      ),
                    ),
                  ),
                ],
              ),
              if (_waiting)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 18.0,
                        height: 18.0,
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    child: Text(localeStr.btnCancel),
                    color: themeColor.pagerButtonColor,
                    onPressed: () {
                      if (_waiting) return;
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(width: 12),
                  RaisedButton(
                    child: Text(actionText),
                    onPressed: () async {
                      if (_waiting) return;
                      if (widget.onConfirm != null) {
                        setState(() {
                          _waiting = true;
                        });
                        // wait for the action complete and close the dialog
                        await widget
                            .onConfirm()
                            .whenComplete(() => Navigator.of(context).pop());
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
