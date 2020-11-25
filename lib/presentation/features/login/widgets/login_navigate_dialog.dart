import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_eg990_mobile/presentation/common/window/dialog_widget.dart';
import 'package:flutter_eg990_mobile/presentation/export_internal_file.dart';
import 'package:flutter_eg990_mobile/presentation/router/app_navigator.dart';

class LoginNavigateDialog extends StatelessWidget {
  final String username;
  final bool returnHomePage;

  LoginNavigateDialog({
    @required this.username,
    this.returnHomePage = true,
  });

  final double dialogSize = Global.device.width * 0.5;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 1500), () {
      Navigator.of(context).pop();
      AppNavigator.callCheckUser();
    }).whenComplete(() => AppNavigator.returnToHome());
    return WillPopScope(
      onWillPop: () async {
        return Future.value(true);
      },
      child: DialogWidget(
        constraints: BoxConstraints.tightFor(
          width: dialogSize,
          height: dialogSize,
        ),
        canClose: false,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                    width: 48.0,
                    height: 48.0,
                    margin: const EdgeInsets.all(30.0),
                    child: CircularProgressIndicator()),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  localeStr.messageWelcomeUser(username),
                  style: TextStyle(fontSize: FontSize.SUBTITLE.value),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
