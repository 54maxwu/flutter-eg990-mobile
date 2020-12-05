import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';

import '../main_screen_provider.dart';
import 'screen_navigation_bar_item.dart';

class ScreenNavigationBar extends StatefulWidget {
  @override
  _ScreenNavigationBarState createState() => _ScreenNavigationBarState();
}

class _ScreenNavigationBarState extends State<ScreenNavigationBar> {
  static final List<ScreenNavigationBarItem> _tabs =
      ScreenNavigationBarItem.mapAll;

  List<ReactionDisposer> _disposers;
  MainScreenProvider _screenProvider;

  MainScreenNavBarTypes _barType;
  bool _hideNavBar = false;
  int _lastIndex = 0;

  bool isValidIndex(int index) => index >= 0 && index < _tabs.length;

  void _navigate(int index) {
    var item = _tabs[index];
    debugPrint('tapped item: ${item.value}');
    if (item.value.route == null) {
      callToastInfo(localeStr.workInProgress);
    } else {
      var value = item.value;
      if (value.isUserOnly && !_screenProvider.userInfoStore.hasUser) {
        AppNavigator.navigateTo(RoutePage.login);
      } else {
        AppNavigator.navigateTo(value.route);
      }
    }
  }

  void initDisposers() {
    _disposers ??= [
      reaction(
        (_) => _screenProvider.getPageInfo,
        (RouteInfo page) {
          if (mounted) {
            // debugPrint('reaction on nav bar page info: $page');
            if (_barType != page.navBarType ||
                _lastIndex != page.bottomNavIndex) {
              _barType = page.navBarType;
              setState(() {
                _hideNavBar = page.navBarType == MainScreenNavBarTypes.HIDE;
                if (isValidIndex(page.bottomNavIndex)) {
                  _lastIndex = page.bottomNavIndex;
                }
              });
              debugPrint('nav bar index: $_lastIndex, type: ${_barType.index}');
            }
          }
        },
      ),
    ];
  }

  @override
  void didChangeDependencies() {
    _screenProvider = null;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    try {
      _disposers.forEach((d) => d());
      _disposers.clear();
      _disposers = null;
    } on Exception {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenProvider ??= Provider.of<MainScreenProvider>(context);
    if (_disposers == null) initDisposers();
    return Visibility(
      visible: !_hideNavBar,
      maintainSize: false,
      maintainState: true,
      child: Container(
        height: Global.APP_NAV_HEIGHT,
        decoration: BoxDecoration(
          boxShadow: ThemeInterface.layerShadowLight,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
          child: BottomNavigationBar(
            currentIndex: _lastIndex,
            onTap: (index) => _navigate(index),
            type: BottomNavigationBarType.fixed,
            backgroundColor: themeColor.defaultAppbarColor,
            unselectedItemColor: themeColor.navigationColor,
            fixedColor: themeColor.navigationColorFocus,
            unselectedFontSize: FontSize.NORMAL.value,
            selectedFontSize: FontSize.NORMAL.value,
            items: List.generate(_tabs.length, (index) {
              var itemValue = _tabs[index].value;
              return BottomNavigationBarItem(
                icon: Image.asset(itemValue.imageName, scale: 1.5),
                activeIcon: Image.asset(itemValue.imageSubName, scale: 1.5),
                label: itemValue.title,
              );
            }),
          ),
        ),
      ),
    );
  }
}
