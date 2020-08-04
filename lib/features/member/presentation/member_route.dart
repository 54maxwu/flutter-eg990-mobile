import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/features/exports_for_route_widget.dart';

import 'state/member_credit_store.dart';
import 'widgets/member_display.dart';

/// Main View of [Router.memberRoute]
/// @author H.C.CHIANG
/// @version 2020/5/15
class MemberRoute extends StatefulWidget {
  MemberRoute({Key key}) : super(key: key);

  @override
  _MemberRouteState createState() => _MemberRouteState();
}

class _MemberRouteState extends State<MemberRoute> {
  MemberCreditStore _store;

  @override
  void initState() {
    _store ??= sl.get<MemberCreditStore>();
    _store.getUser();
    super.initState();
    _store.getNewMessageCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Observer(
          // Observe using specific widget
          builder: (_) {
            print('member observe user: ${_store.user}');
            if (_store.user != null)
              return MemberDisplay(_store);
            else
              return LoadingWidget();
          },
        ),
      ),
    );
  }
}
