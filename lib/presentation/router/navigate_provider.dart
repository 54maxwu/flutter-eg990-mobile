import 'package:flutter/widgets.dart';

abstract class NavigateProviderInterface with ChangeNotifier {
  set setRootNavigatorKey(GlobalKey<NavigatorState> key);

  GlobalKey<NavigatorState> get getRootNavigatorKey;
}

class NavigateProvider
    with ChangeNotifier
    implements NavigateProviderInterface {
  GlobalKey<NavigatorState> _navigatorKey;

  NavigateProvider({GlobalKey<NavigatorState> initKey}) {
    setRootNavigatorKey = initKey;
  }

  @override
  GlobalKey<NavigatorState> get getRootNavigatorKey => _navigatorKey;

  @override
  set setRootNavigatorKey(GlobalKey<NavigatorState> key) {
    _navigatorKey = key;
    notifyListeners();
  }
}
