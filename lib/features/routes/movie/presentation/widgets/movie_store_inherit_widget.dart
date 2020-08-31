import 'package:flutter/material.dart';

import '../state/movie_store.dart';

///@author H.C.CHIANG
///@version 2020/7/14
class MovieStoreInheritedWidget extends InheritedWidget {
  final MovieStore store;
  final Size size;

  const MovieStoreInheritedWidget({
    Key key,
    @required this.store,
    @required this.size,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  static MovieStoreInheritedWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MovieStoreInheritedWidget>();
  }

  @override
  bool updateShouldNotify(MovieStoreInheritedWidget old) =>
      key != old.key || store != old.store || size != old.size;
}
