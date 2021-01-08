import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_eg990_mobile/injection_container.dart';
import 'package:flutter_eg990_mobile/presentation/common/window/dialog_widget.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';
import 'package:flutter_eg990_mobile/presentation/router/navigate.dart';
import 'package:flutter_eg990_mobile/presentation/screens/user/user_info_store.dart';

class LoginNavigateDialog extends StatelessWidget {
  final String username;

  LoginNavigateDialog({@required this.username});

  @override
  Widget build(BuildContext context) {
    double dialogSize = Global.device.width * 0.3;
    if (dialogSize < 160) dialogSize = 160;

    // return to home after 1s
    sl.get<UserInfoStore>().setRecheck = true;
    Future.delayed(Duration(milliseconds: 1000), () {
      Navigator.of(context).pop();
    }).whenComplete(() {
      if (!AppNavigator.loginToHomePage) {
        AppNavigator.back(usePreviousAsRoot: true);
      } else {
        AppNavigator.returnToHome();
      }
    });

    return WillPopScope(
      onWillPop: () async => Future.value(true),
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
                  localeStr.msgWelcomeUser(username),
                  style: TextStyle(fontSize: FontSize.MESSAGE.value),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
