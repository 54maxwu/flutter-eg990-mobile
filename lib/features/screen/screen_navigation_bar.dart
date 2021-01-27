import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/event/presentation/state/event_store.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/features/general/ext/badge/badge.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/cached_network_image.dart';

import 'feature_screen_inherited_widget.dart';
import 'feature_screen_store.dart';
import 'screen_navigation_bar_item.dart';

///
///@author H.C.CHIANG
///@version 2020/6/2
///
class ScreenNavigationBar extends StatefulWidget {
  const ScreenNavigationBar();

  @override
  _ScreenNavigationBarState createState() => _ScreenNavigationBarState();
}

class _ScreenNavigationBarState extends State<ScreenNavigationBar> {
  static final List<ScreenNavigationBarItem> _tabs = [
    ScreenNavigationBarItem.home,
    ScreenNavigationBarItem.deposit,
    ScreenNavigationBarItem.service,
    ScreenNavigationBarItem.member,
  ];

  FeatureScreenStore _store;
  EventStore _eventStore;
  Widget _barWidget;
  String _locale;
  int _navIndex = 0;

  void _itemTapped(int index, bool hasUser) {
    var item = _tabs[index];
    debugPrint('tapped item: ${item.value}');
    if (item.value.route == null) {
      callToastInfo(localeStr.workInProgress);
    } else {
      var value = item.value;
      if (value.isUserOnly && !hasUser)
        AppNavigator.navigateTo(RoutePage.login);
      else
        AppNavigator.navigateTo(value.route);
    }
  }

  @override
  void initState() {
    _locale = Global.localeCode;
    super.initState();
  }

  @override
  void didUpdateWidget(ScreenNavigationBar oldWidget) {
    _store = null;
    _eventStore = null;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (_store == null || _eventStore == null) {
      final viewState = FeatureScreenInheritedWidget.of(context);
      _store ??= viewState?.store;
      _eventStore ??= viewState?.eventStore;
    }
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: themeColor.defaultAccentColor),
        ),
      ),
      child: StreamBuilder<bool>(
          stream: _store.loginStateStream,
          initialData: false,
          builder: (context, snapshot) {
            if (_barWidget != null && _locale != Global.localeCode) {
              _barWidget = _buildWidget(snapshot.data);
              _locale = Global.localeCode;
            }
            _barWidget ??= _buildWidget(snapshot.data);
            return _barWidget;
          }),
    );
  }

  Widget _buildWidget(bool hasUser) {
    return Observer(builder: (_) {
      // observe nav index to change icon icon color (setState does not work).
      final index = _store.navIndex;
      if (index >= 0) _navIndex = index;
      // monitor observable value to show event dialog
      // if (_eventStore.showEventOnHome) _checkShowEvent();
      // if (_navIndex == 10) {  // Agent route navigate bar
      //   List<String> labels = _agentTabs.map((e) => e.value.title).toList();
      //   return BottomNavigationBar(
      //     onTap: (index) {
      //       debugPrint('store state user: ${_store.userStatus}');
      //       if (index == 1) return;
      //       if (index == 0) AppNavigator.navigateClean();
      //     },
      //     currentIndex: 1,
      //     type: BottomNavigationBarType.fixed,
      //     selectedFontSize: FontSize.NORMAL.value,
      //     unselectedFontSize: FontSize.NORMAL.value,
      //     unselectedItemColor: themeColor.navigationColor,
      //     fixedColor: themeColor.navigationColorFocus,
      //     backgroundColor: themeColor.defaultAppbarColor,
      //     items: List.generate(_agentTabs.length, (index) {
      //       var itemValue = _agentTabs[index].value;
      //       return _createBarItem(
      //           itemValue: itemValue,
      //           title: labels[index],
      //           store: _store,
      //           highlight: index == 1);
      //     }),
      //   );
      // } else {
      List<String> labels = _tabs.map((e) => e.value.title).toList();
      return BottomNavigationBar(
        currentIndex: _navIndex,
        onTap: (index) {
          debugPrint('store state user: ${_store.userStatus}');
          _itemTapped(index, _store.hasUser);
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: themeColor.defaultAppbarColor,
        unselectedFontSize: FontSize.NORMAL.value,
        selectedFontSize: FontSize.NORMAL.value,
        unselectedItemColor: themeColor.navigationColor,
        fixedColor: themeColor.navigationColorFocus,
        items: List.generate(_tabs.length, (index) {
          var itemValue = _tabs[index].value;
          return _createBarItem(
              itemValue: itemValue,
              title: labels[index],
              store: _store,
              highlight: index == _navIndex);
        }),
      );
      // }
    });
  }

  BottomNavigationBarItem _createBarItem({
    RouteListItem itemValue,
    String title,
    bool addBadge = false,
    FeatureScreenStore store,
    bool highlight = false,
  }) {
    // debugPrint(
    //     'navigate item $itemValue title: ${title ?? itemValue.title ?? itemValue.route?.pageTitle ?? '?'}');
    Widget icon = (itemValue.imageName != null)
        ? ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: SizedBox(
              width: 30.0,
              height: 30.0,
              child: networkImageBuilder(itemValue.imageName),
            ),
          )
        : Icon(itemValue.iconData, size: 30);
    return BottomNavigationBarItem(
      icon: (addBadge)
          ? Badge(
              showBadge: getAppGlobalStreams.hasNewMessage,
              badgeColor: themeColor.hintHighlightRed,
              badgeContent: Container(
                margin: const EdgeInsets.all(1.0),
                child: Icon(
                  const IconData(0xf129, fontFamily: 'FontAwesome'),
                  color: Colors.white,
                  size: 8.0,
                ),
              ),
              padding: EdgeInsets.zero,
              position: BadgePosition.topEnd(top: -5, end: -6),
              child: icon,
            )
          : icon,
      title: Padding(
          padding: const EdgeInsets.fromLTRB(3.0, 2.0, 3.0, 0.0),
          child: AutoSizeText(
            title ?? itemValue.title ?? itemValue.route?.pageTitle ?? '?',
            style: TextStyle(
              color: (highlight)
                  ? themeColor.navigationColorFocus
                  : themeColor.defaultTextColor,
              fontSize: (Global.localeCode != 'zh')
                  ? FontSize.SMALL.value
                  : FontSize.NORMAL.value,
            ),
            minFontSize: (Global.localeCode != 'zh')
                ? FontSize.SMALL.value - 4.0
                : FontSize.NORMAL.value - 4.0,
            maxFontSize: (Global.localeCode != 'zh')
                ? FontSize.SMALL.value
                : FontSize.NORMAL.value,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
    );
  }
}
