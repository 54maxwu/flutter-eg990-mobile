import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/toast_notification_widget.dart';
import 'package:flutter_eg990_mobile/features/themes/theme_interface.dart';
import 'package:flutter_eg990_mobile/firebase_interface.dart';

class TestAreaRoute extends StatefulWidget {
  @override
  _TestAreaRouteState createState() => _TestAreaRouteState();
}

class _TestAreaRouteState extends State<TestAreaRoute> with AfterLayoutMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // FlatButton(
          //   onPressed: () {
          //     launch('tel://0926908818');
          //   },
          //   child: Text(
          //     '0926908818',
          //     style: TextStyle(
          //       color: themeColor.hintHyperLink,
          //       decoration: TextDecoration.underline,
          //     ),
          //   ),
          // ),
          FlatButton(
            onPressed: () {
              FirebaseInterface.log.setUserId('guest');
              callToast('TestUserId');
            },
            child: Text(
              'Test User Id',
              style: TextStyle(
                color: themeColor.hintHyperLink,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              FirebaseInterface.log
                  .setUserProperty(name: 'user_type', value: 'dev');
              callToast('TestUserProperty');
            },
            child: Text(
              'Test User Property',
              style: TextStyle(
                color: themeColor.hintHyperLink,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              FirebaseInterface.log.logEvent(name: 'TestEventLog');
              callToast('TestEventLog');
            },
            child: Text(
              'Test Event',
              style: TextStyle(
                color: themeColor.hintHyperLink,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              FirebaseInterface.log.logEvent(
                name: FirebaseLog.TEST.name,
                parameters: {
                  FirebaseLogParam.DEVICE.name: 'android',
                },
              );
              callToast('TestEventParam');
            },
            child: Text(
              'Test Event Param',
              style: TextStyle(
                color: themeColor.hintHyperLink,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              FirebaseInterface.log.logAppOpen();
              callToast('TestAppOpenEvent');
            },
            child: Text(
              'Test App Open Event',
              style: TextStyle(
                color: themeColor.hintHyperLink,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              FirebaseInterface.log.logLogin(loginMethod: 'TestLoginEvent');
              callToast('TestLoginEvent');
            },
            child: Text(
              'Test Login Event',
              style: TextStyle(
                color: themeColor.hintHyperLink,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              FirebaseInterface.log.setCurrentScreen(
                  screenName: '/test',
                  screenClassOverride: 'TestScreenClassOverride');
              callToast('TestScreenEvent');
            },
            child: Text(
              'Test Screen Event',
              style: TextStyle(
                color: themeColor.hintHyperLink,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              callToastNotification(subtitle: 'Test Message');
            },
            child: Text(
              'Test Notification Widget',
              style: TextStyle(
                color: themeColor.hintHyperLink,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              FirebaseInterface.log.resetAnalyticsData();
              callToast('RESET');
            },
            child: Text(
              'RESET',
              style: TextStyle(
                color: themeColor.hintDarkRed,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    debugPrint('after first layout');
  }
}
