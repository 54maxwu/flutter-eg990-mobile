import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/presentation/screens/user/user_info_store.dart';

import 'widgets/member_header.dart';
import 'widgets/member_shortcuts.dart';
import 'widgets/member_shortcuts_list.dart';

class MemberRoute extends StatefulWidget {
  @override
  _MemberRouteState createState() => _MemberRouteState();
}

class _MemberRouteState extends State<MemberRoute> {
  UserInfoStore _store;
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    _store ??= sl.get<UserInfoStore>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction(
        // Observe store's observable in page
        (_) => _store.errorMessage,
        // Do something when the value has changed
        (String message) {
          if (message != null && message.isNotEmpty) {
            callToastError(message, delayedMilli: 200);
          }
        },
      ),
    ];
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        debugPrint('pop member route');
        Future.delayed(Duration(milliseconds: 100), () => AppNavigator.back());
        return Future(() => true);
      },
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          color: themeColor.defaultLayeredBackgroundColor,
          child: SingleChildScrollView(
            primary: true,
            physics: BouncingScrollPhysics(),
            child: SizedBox(
              height: Global.device.featureContentHeight,
              child: Column(
                children: <Widget>[
                  MemberHeader(),
                  MemberShortcuts(hasUser: _store.hasUser),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: MemberShortcutsList(hasUser: _store.hasUser),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
