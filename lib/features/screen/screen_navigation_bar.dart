part of 'feature_screen_view.dart';

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
    ScreenNavigationBarItem.promo,
    ScreenNavigationBarItem.service,
    ScreenNavigationBarItem.member,
    ScreenNavigationBarItem.more,
  ];

  static final List<ScreenNavigationBarItem> _userTabs = [
    ScreenNavigationBarItem.home,
    ScreenNavigationBarItem.agent,
    ScreenNavigationBarItem.promo,
    ScreenNavigationBarItem.service,
    ScreenNavigationBarItem.member,
    ScreenNavigationBarItem.more,
  ];

  FeatureScreenStore _store;
  int _navIndex = 0;
  bool _isUserTabs = false;
  bool _showingEventDialog = false;
  Widget _barWidget;

  void _itemTapped(int index, bool hasUser) {
//            RouterNavigate.testNavigate(_tabRoute[index]);
//              RouterNavigate.switchScreen(web: true);
    var item = (_isUserTabs) ? _userTabs[index] : _tabs[index];
    print('tapped item: ${item.value}');
    if (item == ScreenNavigationBarItem.more) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => new MoreDialog(_store),
      );
    } else if (item.value.route == null) {
      callToastInfo(localeStr.workInProgress);
    } else {
      var value = item.value;
      if (value.isUserOnly && !hasUser)
        RouterNavigate.navigateToPage(RoutePage.login);
      else if (item == ScreenNavigationBarItem.service)
        RouterNavigate.navigateToPage(
          value.route,
          arg: WebRouteArguments(startUrl: value.webUrl),
        );
      else
        RouterNavigate.navigateToPage(value.route);
    }
  }

  void _checkShowEvent() {
//    _store.debugEvent();
    if (_store.forceShowEvent && _store.hasEvent == false) {
      Future.delayed(Duration(milliseconds: 200), () {
        callToastInfo(localeStr.messageNoEvent);
      });
      // set to false so it will not pop on other pages
      _store.setForceShowEvent = false;
      return;
    }
    if (_store.showEventOnHome && !_showingEventDialog) {
      _showingEventDialog = true;
      Future.delayed(Duration(milliseconds: 1200), () {
        // will not show
        if (_store.hasUser == false ||
            (_store.navIndex != 0 && _store.forceShowEvent == false)) {
          stopEventAutoShow();
          return;
        } else {
          // set to false so it will not pop on other pages
          _store.setForceShowEvent = false;
        }
        _showEventDialog();
      });
    }
  }

  void _showEventDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => (_store.hasSignedEvent == false)
          ? new EventDialog(
              event: _store.event.eventData,
              signCount: _store.event.signData.times,
              onSign: () => _store.signEvent(),
              onSignError: () => _store.getEventError(),
              onDialogClose: () => stopEventAutoShow(),
            )
          : new EventDialogSigned(
              event: _store.event.eventData,
              signCount: _store.event.signData.times,
              onDialogClose: () => stopEventAutoShow(),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewState = FeatureScreenInheritedWidget.of(context);
    _store ??= viewState.store;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Themes.defaultAccentColor),
        ),
      ),
      child: StreamBuilder<bool>(
          stream: viewState.store.loginStateStream,
          initialData: false,
          builder: (context, snapshot) {
            if (_isUserTabs != snapshot.data) {
              _barWidget = _buildWidget(snapshot.data);
            }
            _barWidget ??= _buildWidget(snapshot.data);
            _isUserTabs = snapshot.data;
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
      if (_store.showEventOnHome) _checkShowEvent();
      return BottomNavigationBar(
        onTap: (index) {
          print('store state user: ${_store.userStatus}');
          _itemTapped(index, _store.hasUser);
        },
        currentIndex: _navIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: FontSize.NORMAL.value,
        unselectedFontSize: FontSize.NORMAL.value,
        unselectedItemColor: Themes.defaultTextColor,
        fixedColor: Themes.defaultAccentColor,
        backgroundColor: Themes.defaultAppbarColor,
        items: (hasUser)
            ? List.generate(_userTabs.length, (index) {
                var itemValue = _userTabs[index].value;
                return _createBarItem(itemValue, index == 4, _store);
              })
            : List.generate(_tabs.length, (index) {
                var itemValue = _tabs[index].value;
                return _createBarItem(itemValue, index == 4, _store);
              }),
      );
    });
  }

  BottomNavigationBarItem _createBarItem(
      RouteListItem itemValue, bool addBadge, FeatureScreenStore store) {
    return BottomNavigationBarItem(
      icon: (addBadge)
          ? Badge(
              showBadge: store.hasNewMessage,
              badgeColor: Themes.hintHighlightRed,
              badgeContent: Container(
                margin: const EdgeInsets.all(1.0),
                child: Icon(
                  const IconData(0xf129, fontFamily: 'FontAwesome'),
                  color: Colors.white,
                  size: 8.0,
                ),
              ),
              padding: EdgeInsets.zero,
              position: BadgePosition.topRight(top: -5, right: -6),
              child: Icon(itemValue.iconData),
            )
          : Icon(itemValue.iconData),
      title: Padding(
        padding: EdgeInsets.only(top: 2.0),
        child:
            Text(itemValue.replaceTitle ?? itemValue.route?.pageTitle ?? '?'),
      ),
    );
  }

  void stopEventAutoShow() {
    if (_store == null) return;
    _showingEventDialog = false;
    // set to false so it will not pop again when return to home page
    _store.setShowEvent = false;
  }
}
