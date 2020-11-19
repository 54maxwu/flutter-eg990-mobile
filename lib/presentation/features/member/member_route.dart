import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_eg990_mobile/presentation/common/other/warning_display.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/presentation/features/user/presentation/state/user_info_store.dart';

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
    print('didChangeDependencies');
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
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: WarningDisplay(
              message: 'has user: ${_store.hasUser}',
              widthFactor: 1.0,
              isFailureMsg: false),
        ),
      ),
    );
  }
}
