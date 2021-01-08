import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';
import 'package:flutter_eg990_mobile/presentation/common/window/dialog_widget.dart';

class BalanceActionDialogOld extends StatelessWidget {
  final bool isTransferIn;
  final String targetPlatform;
  final Function onConfirm;

  BalanceActionDialogOld({
    @required this.targetPlatform,
    @required this.isTransferIn,
    this.onConfirm,
  })  : assert(isTransferIn != null),
        assert(targetPlatform != null && targetPlatform.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    String actionText =
        (isTransferIn) ? localeStr.btnTransferIn : localeStr.btnTransferOut;
    return DialogWidget(
      heightFactor: 0.175,
      minHeight: 120,
      maxHeight: 180,
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
                      localeStr.dialogTitleConfirmInfo,
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
                      localeStr.dialogTextTransferActionTo(
                        actionText.toLowerCase(),
                        targetPlatform.toUpperCase(),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    child: Text(localeStr.btnCancel),
                    color: themeColor.pagerButtonColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(width: 12),
                  RaisedButton(
                    child: Text(actionText),
                    onPressed: () {
                      if (onConfirm != null) {
                        onConfirm();
                        Navigator.of(context).pop();
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
