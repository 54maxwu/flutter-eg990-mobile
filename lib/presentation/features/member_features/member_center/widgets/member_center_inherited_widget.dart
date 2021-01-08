import 'package:flutter/material.dart';

import '../state/member_center_store.dart';

///@author H.C.CHIANG
///@version 2020/5/4
class MemberCenterInheritedWidget extends InheritedWidget {
  final MemberCenterStore store;

  const MemberCenterInheritedWidget({
    Key key,
    @required this.store,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  static MemberCenterInheritedWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MemberCenterInheritedWidget>();
  }

  @override
  bool updateShouldNotify(MemberCenterInheritedWidget old) =>
      key != old.key || store != old.store;
}
