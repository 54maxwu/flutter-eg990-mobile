import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/application/themes/theme_interface.dart';
import 'package:flutter_eg990_mobile/presentation/router/data/route_info.dart';
import 'package:provider/provider.dart';

import '../main_screen_provider.dart';
import 'screen_navigation_bar_item.dart';

class ScreenNavigationBar extends StatefulWidget {
  @override
  _ScreenNavigationBarState createState() => _ScreenNavigationBarState();
}

class _ScreenNavigationBarState extends State<ScreenNavigationBar> {
  static final List<ScreenNavigationBarItem> _tabs = [
    ScreenNavigationBarItem.home,
    ScreenNavigationBarItem.member,
  ];

  // List<ReactionDisposer> _disposers;
  MainScreenProvider _screenProvider;

  // MainScreenNavBarTypes _barType;
  // bool _hideNavBar = false;
  int _lastIndex = 0;

  @override
  void didUpdateWidget(ScreenNavigationBar oldWidget) {
    // update app bar when language changed
    // if (_disposers != null) {
    //   _disposers.forEach((d) => d());
    //   _disposers.clear();
    //   _disposers = null;
    // }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    _screenProvider = null;
    super.didChangeDependencies();
  }

  // @override
  // void dispose() {
  //   try {
  //     _disposers.forEach((d) => d());
  //     _disposers.clear();
  //     _disposers = null;
  //   } on Exception {}
  //   super.dispose();
  // }
  //
  // void initDisposers() {
  //   _disposers = [
  //     reaction(
  //       (_) => _screenProvider.getPageInfo,
  //       (RouteInfo page) {
  //         if (mounted) {
  //           if (_barType != page.navBarType ||
  //               (_lastIndex != page.bottomNavIndex &&
  //                   isValidIndex(page.bottomNavIndex))) {
  //             _barType = page.navBarType;
  //             setState(() {
  //               _lastIndex = page.bottomNavIndex;
  //               _hideNavBar = page.navBarType == MainScreenNavBarTypes.HIDE;
  //             });
  //           }
  //         }
  //       },
  //     ),
  //   ];
  // }

  bool isValidIndex(int index) => index >= 0 && index < _tabs.length;

  void _navigate(int index) {
    var item = _tabs[index];
    debugPrint('tapped item: ${item.value}');
    // if (item.value.id == RouteEnum.MORE) {
    //   showDialog(
    //     context: context,
    //     barrierDismissible: true,
    //     builder: (context) => new MoreDialog(_store, _eventStore),
    //   );
    // } else if (item.value.route == null) {
    //   callToastInfo(localeStr.workInProgress);
    // } else {
    //   var value = item.value;
    //   if (value.isUserOnly && !hasUser)
    //     AppNavigator.navigateTo(RoutePage.login);
    //   else
    //     AppNavigator.navigateTo(value.route);
    // }
  }

  @override
  Widget build(BuildContext context) {
    _screenProvider ??= Provider.of<MainScreenProvider>(context);
    // if (_disposers == null) initDisposers();
    return Visibility(
      visible: context.select<MainScreenProvider, bool>((value) {
        debugPrint('debug nav bar visibility: ${value.getPageInfo.hideNavBar}');
        return !(value.getPageInfo.hideNavBar);
      }),
      maintainSize: false,
      maintainState: true,
      child: Container(
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
          child: Selector<MainScreenProvider, int>(
            selector: (_, provider) => provider.getPageInfo.bottomNavIndex,
            builder: (_, navIndex, __) {
              debugPrint('debug nav bar index: $navIndex');
              if (isValidIndex(navIndex)) {
                _lastIndex = navIndex;
              }
              return BottomNavigationBar(
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
                      icon: Icon(itemValue.iconData),
                      label: itemValue.title,
                    );
                  }));
            },
          ),
        ),
      ),
    );
  }
}
