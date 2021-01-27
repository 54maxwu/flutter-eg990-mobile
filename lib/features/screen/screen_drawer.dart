import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/event/presentation/state/event_store.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import 'feature_screen_inherited_widget.dart';
import 'feature_screen_store.dart';
import 'screen_drawer_item.dart';

///
///@author H.C.CHIANG
///@version 2020/6/2
///
class ScreenDrawer extends StatelessWidget {
  static final List<ScreenDrawerItem> _menuItems = [
    ScreenDrawerItem.promo,
    ScreenDrawerItem.service,
    ScreenDrawerItem.download,
    ScreenDrawerItem.vip,
    // ScreenDrawerItem.agent,
  ];

  static final List<ScreenDrawerItem> _userMenuItems = [
    ScreenDrawerItem.member,
    ScreenDrawerItem.deposit,
    ScreenDrawerItem.promo,
    ScreenDrawerItem.message,
    ScreenDrawerItem.notice,
    ScreenDrawerItem.store,
    ScreenDrawerItem.service,
    ScreenDrawerItem.download,
    ScreenDrawerItem.vip,
    // ScreenDrawerItem.agent,
    ScreenDrawerItem.logout,
  ];

  bool _itemTapped(ScreenDrawerItem item,
      {FeatureScreenStore store, EventStore eventStore, BuildContext context}) {
    debugPrint('tap drawer item ${item.value.id}');
    switch (item.value.id) {
      case RouteEnum.LOGOUT:
        getAppGlobalStreams.logout();
        return true;
      case RouteEnum.TEST:
        AppNavigator.switchScreen(Screens.Test);
        return true;
      case RouteEnum.WEBSITE:
        launch(Global.CURRENT_BASE);
        return true;
      case RouteEnum.SIGN:
        if (eventStore == null) return false;
        if (store.hasUser == false) {
          callToastError(localeStr.messageErrorNotLogin);
        } else {
          eventStore?.setForceShowEvent = true;
        }
        return true;
      default:
        var route = item.value.route;
        if (route == null) {
          callToastInfo(localeStr.workInProgress);
        } else if (route.value.routeArg is WebRouteArguments) {
          // open web page
          AppNavigator.replaceWith(route, arg: route.value.routeArg);
          return true;
        } else if (route.pageName != AppNavigator.current) {
          AppNavigator.navigateTo(route);
          return true;
        }
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewState = FeatureScreenInheritedWidget.of(context);
    double drawerWidth = Global.device.width / 6 * 5;
    if (drawerWidth < 300) drawerWidth = 300;

    double gridItemWidth = drawerWidth / 2;
    double gridRatio =
        (Global.lang == 'zh') ? gridItemWidth / 48 : gridItemWidth / 56;

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
              decoration:
                  BoxDecoration(color: themeColor.sideMenuSecondaryColor),
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
                        Text(localeStr.messageWelcomeHint,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: themeColor.sideMenuHeaderTextColor)),
                        SizedBox(height: 12.0),
                        RaisedButton(
                          visualDensity: VisualDensity(horizontal: 3.0),
                          child: Text(localeStr.pageTitleLogin2),
                          onPressed: () {
                            if (viewState.scaffoldKey.currentState.isDrawerOpen)
                              Navigator.of(context).pop();
                            AppNavigator.navigateTo(
                              RoutePage.login,
                              arg: LoginRouteArguments(
                                  returnHomeAfterLogin: true),
                            );
                          },
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
                        if (_itemTapped(item, context: context)) {
                          // close the drawer
                          if (viewState.scaffoldKey.currentState.isDrawerOpen) {
                            Navigator.of(context).pop();
                          }
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
                    'version: ${Global.device.appVersionSide}',
                    style: TextStyle(
                      fontSize: FontSize.SMALL.value,
                      color: themeColor.defaultHintSubColor,
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
    bool shrink = itemValue.imageName != null ||
        (itemValue.iconData != null && itemValue.iconData.codePoint == 0xf219);
    return Padding(
      padding: (shrink)
          ? const EdgeInsets.fromLTRB(9.0, 0.0, 8.0, 16.0)
          : const EdgeInsets.fromLTRB(12.0, 0.0, 8.0, 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          (itemValue.imageName != null)
              ? SizedBox(
                  width: 36.0,
                  height: 36.0,
                  child: (itemValue.imageName.startsWith('assets/'))
                      ? Image.asset(itemValue.imageName)
                      : networkImageBuilder(itemValue.imageName,
                          imgColor: themeColor.sideMenuIconColor),
                )
              : Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: themeColor.sideMenuIconColor)),
                  child: Transform.scale(
                    scale: (shrink) ? 0.7 : 0.75,
                    child: Container(
                      margin: (shrink)
                          ? const EdgeInsets.only(right: 4.0)
                          : EdgeInsets.zero,
                      child: Icon(
                        itemValue.iconData,
                        color: themeColor.sideMenuIconColor,
                        size: 28.0,
                      ),
                    ),
                  ),
                ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: AutoSizeText.rich(
                  TextSpan(
                    text: (itemValue.id == RouteEnum.MEMBER)
                        ? localeStr.pageTitleCenter
                        : itemValue.title ?? itemValue.route?.pageTitle ?? '?',
                    style: TextStyle(
                      fontSize: (Global.lang == 'zh')
                          ? FontSize.SUBTITLE.value
                          : FontSize.NORMAL.value,
                      color: themeColor.sideMenuIconTextColor,
                    ),
                  ),
                  maxLines: 2,
                  minFontSize: 10.0,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                )),
          ),
        ],
      ),
    );
  }
}
