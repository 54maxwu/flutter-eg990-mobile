part of 'feature_screen_view.dart';

///
///@author H.C.CHIANG
///@version 2020/6/2
///
class ScreenDrawer extends StatelessWidget {
  const ScreenDrawer();

  static final List<ScreenDrawerItem> _menuItems = [
    ScreenDrawerItem.promo,
    ScreenDrawerItem.service,
    ScreenDrawerItem.download,
    ScreenDrawerItem.vip,
    ScreenDrawerItem.agentAbout,
    ScreenDrawerItem.testUI,
    ScreenDrawerItem.test,
  ];

  static final List<ScreenDrawerItem> _userMenuItems = [
    ScreenDrawerItem.member,
    ScreenDrawerItem.deposit,
    ScreenDrawerItem.promo,
    ScreenDrawerItem.message,
    ScreenDrawerItem.notice,
    ScreenDrawerItem.store,
    ScreenDrawerItem.roller,
    ScreenDrawerItem.task,
    ScreenDrawerItem.collect,
    ScreenDrawerItem.sign,
    ScreenDrawerItem.service,
    ScreenDrawerItem.download,
    ScreenDrawerItem.vip,
    ScreenDrawerItem.agentAbout,
    ScreenDrawerItem.logout,
    ScreenDrawerItem.testUI,
    ScreenDrawerItem.test,
  ];

  bool _itemTapped(ScreenDrawerItem item, {FeatureScreenStore store}) {
    if (item == ScreenDrawerItem.logout) {
      getAppGlobalStreams.logout();
      return true;
    }
    if (item == ScreenDrawerItem.test) {
      ScreenNavigate.switchScreen(screen: ScreenEnum.Test);
      return true;
    }
//    if (item == ScreenDrawerItem.sign) {
//      store.setForceShowEvent = true;
//      return true;
//    }
    var route = item.value.route;
    if (route == null) {
      callToastInfo(localeStr.workInProgress);
    } else if (route == RoutePage.tutorial || route == RoutePage.agentAbout) {
      // open web page
      RouterNavigate.replacePage(route, arg: route.value.routeArg);
      return true;
    } else if (route.page != RouterNavigate.current) {
      RouterNavigate.navigateToPage(route);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final viewState = FeatureScreenInheritedWidget.of(context);
    double drawerWidth = Global.device.width / 6 * 5;
    if (drawerWidth < 300) drawerWidth = 300;

    double gridItemWidth = drawerWidth / 2;
    double gridRatio = gridItemWidth / 48;

    return Container(
      width: drawerWidth,
      height: Global.device.height,
      child: Drawer(
        elevation: 8.0,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /* Drawer Header */
            DrawerHeader(
              decoration: BoxDecoration(color: Themes.sideMenuSecondaryColor),
              margin: const EdgeInsets.only(bottom: 4.0),
              child: (viewState.store.hasUser)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Image.asset(
                            'assets/images/vip/user_vip_${viewState.store.user.vip}.png',
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                            localeStr.messageWelcomeUser(
                                viewState.store.user.account),
                            style: TextStyle(color: Colors.white)),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(localeStr.messageWelcome,
                            style: TextStyle(
                              color: Themes.sideMenuHeaderTextColor,
                            )),
                        SizedBox(height: 8),
                        ButtonTheme(
                          child: RaisedButton(
                            color: Themes.sideMenuButtonColor,
                            textColor: Themes.sideMenuButtonTextColor,
                            child: Text(localeStr.pageTitleLogin2),
                            onPressed: () {
                              if (viewState.scaffoldKey.currentState
                                  .isDrawerOpen) Navigator.of(context).pop();
                              RouterNavigate.navigateToPage(
                                RoutePage.login,
                                arg: LoginRouteArguments(
                                    returnHomeAfterLogin: true),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
            Expanded(
              child: Container(
                constraints: BoxConstraints(
                  // _kDrawerHeaderHeight = 161
                  maxHeight: Global.device.height - 161.0 - 36.0,
                ),
                padding: const EdgeInsets.only(top: 12.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: gridRatio,
                  ),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: (getAppGlobalStreams.hasUser)
                      ? _userMenuItems.length
                      : _menuItems.length,
                  itemBuilder: (_, index) {
                    ScreenDrawerItem item = (getAppGlobalStreams.hasUser)
                        ? _userMenuItems[index]
                        : _menuItems[index];
                    return GestureDetector(
                      onTap: () {
                        if ((item == ScreenDrawerItem.sign)
                            ? _itemTapped(item, store: viewState.store)
                            : _itemTapped(item)) {
                          // close the drawer
                          if (viewState.scaffoldKey.currentState.isDrawerOpen)
                            Navigator.of(context).pop();
                        }
                      },
                      child: _buildListItem(item.value),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
              child: Row(
                children: [
                  Text(
                    'version: ${Global.device.appVersion}',
                    style: TextStyle(
                      fontSize: FontSize.SMALL.value,
                      color: Themes.defaultHintSubColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(RouteListItem itemValue) {
    bool shrink =
        itemValue.iconData != null && itemValue.iconData.codePoint == 0xf219;
    return Padding(
      padding: (shrink)
          ? const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 16.0)
          : const EdgeInsets.fromLTRB(10.0, 0.0, 8.0, 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Transform.scale(
            scale: 1.05,
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Themes.sideMenuIconColor)),
              child: Transform.scale(
                scale: (shrink) ? 0.7 : 0.75,
                child: Container(
                  margin: (shrink)
                      ? const EdgeInsets.only(right: 4.0)
                      : EdgeInsets.zero,
                  child: (itemValue.imageName != null)
                      ? SizedBox(
                          width: 24.0,
                          height: 24.0,
                          child: networkImageBuilder(
                            itemValue.imageName,
                            imgColor: Themes.sideMenuIconColor,
                          ),
                        )
                      : Icon(
                          itemValue.iconData,
                          color: Themes.sideMenuIconColor,
                        ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              itemValue.title ?? itemValue.route?.pageTitle ?? '?',
              style: TextStyle(
                fontSize: FontSize.SUBTITLE.value,
                color: Themes.sideMenuIconTextColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
