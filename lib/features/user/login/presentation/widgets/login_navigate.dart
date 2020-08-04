import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/features/export_internal_file.dart';
import 'package:flutter_ty_mobile/features/router/app_navigate.dart';
import 'package:flutter_ty_mobile/features/router/route_user_streams.dart';
import 'package:flutter_ty_mobile/features/user/data/entity/login_status.dart';
import 'package:flutter_ty_mobile/features/user/data/entity/user_entity.dart';

class LoginNavigate extends StatelessWidget {
  final bool returnHomePage;
  final bool closeDialog;
  final UserEntity user;

  LoginNavigate({
    this.returnHomePage = true,
    this.closeDialog = false,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      // show login hint
      var dismiss = callToastLoading(
          message: localeStr.messageWelcomeUser(
              user?.account ?? getRouteUserStreams.userName));

      // update user stream
      if (user != null) {
        getRouteUserStreams
            .updateUser(LoginStatus(loggedIn: true, currentUser: user));
        getRouteUserStreams.setCheck(true);
      }

      // navigate to home or member route
      Future.delayed(Duration(milliseconds: 1000)).whenComplete(() {
        try {
          dismiss();
          if (ScreenNavigate.screenIndex == 2) {
            ScreenNavigate.switchScreen();
          } else if (returnHomePage) {
            if (closeDialog) {
              Future.delayed(Duration(milliseconds: 100), () {
                Navigator.of(context).pop();
              }).whenComplete(() => RouterNavigate.navigateClean(force: true));
            } else {
              RouterNavigate.navigateClean(force: true);
            }
          } else {
            RouterNavigate.navigateToPage(RoutePage.member);
          }
        } catch (e) {
          MyLogger.warn(
            msg: 'Login Display has exception!!',
            error: e,
            tag: 'LoginDisplay',
          );
        }
      });
    });
    return SizedBox.shrink();
  }
}
