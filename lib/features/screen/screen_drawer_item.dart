import 'package:flutter/material.dart' show Icons;
import 'package:flutter_eg990_mobile/features/router/route_list_item.dart';
import 'package:flutter_eg990_mobile/features/router/route_page.dart';
import 'package:flutter_eg990_mobile/features/themes/icon_code.dart';
import 'package:flutter_eg990_mobile/res.dart';
import 'package:vnum/vnum.dart';

export 'package:flutter_eg990_mobile/features/router/route_list_item.dart';

@VnumDefinition
class ScreenDrawerItem extends Vnum<RouteListItem> {
  static ScreenDrawerItem home = ScreenDrawerItem.define(RouteListItem(
    iconData: IconCode.navHome,
    route: RoutePage.home,
  ));
  static ScreenDrawerItem promo = ScreenDrawerItem.define(RouteListItem(
    imageName: 'images/aside/43.png',
    iconData: IconCode.navPromo,
    route: RoutePage.promo,
  ));
  static ScreenDrawerItem service = ScreenDrawerItem.define(RouteListItem(
    imageName: 'images/aside/59.png',
    iconData: IconCode.drawerService,
    route: RoutePage.service,
  ));
  static ScreenDrawerItem notice = ScreenDrawerItem.define(RouteListItem(
    iconData: IconCode.drawerNotice,
    route: RoutePage.sideNoticeBoard,
  ));
  static ScreenDrawerItem download = ScreenDrawerItem.define(RouteListItem(
    iconData: IconCode.drawerDownload,
    imageName: 'images/aside/61.png',
    route: RoutePage.sideDownload,
    userOnly: true,
  ));
  static ScreenDrawerItem tutorial = ScreenDrawerItem.define(RouteListItem(
    iconData: IconCode.drawerTutorial,
    route: RoutePage.sideTutorial,
  ));
  static ScreenDrawerItem line = ScreenDrawerItem.define(RouteListItem(
    routeId: RouteEnum.LINE_QR,
    imageName: Res.iconLine,
  ));
  static ScreenDrawerItem webHome = ScreenDrawerItem.define(RouteListItem(
    routeId: RouteEnum.WEBSITE,
    iconData: IconCode.tabWebsite,
  ));

  /// Agent
  static ScreenDrawerItem agent = ScreenDrawerItem.define(RouteListItem(
    // imageName: 'images/aside/85.png',
    iconData: IconCode.gridAgent,
    route: RoutePage.agent,
  ));
  static ScreenDrawerItem agentAbout = ScreenDrawerItem.define(RouteListItem(
    imageName: 'images/aside/65.png',
    route: RoutePage.moreAgentAbout,
  ));

  /// USER
  static ScreenDrawerItem member = ScreenDrawerItem.define(RouteListItem(
    // imageName: 'images/aside/39.png',
    iconData: IconCode.navMember,
    route: RoutePage.member,
  ));
  static ScreenDrawerItem message = ScreenDrawerItem.define(RouteListItem(
    iconData: IconCode.gridMessage,
    route: RoutePage.message,
  ));
  static ScreenDrawerItem deposit = ScreenDrawerItem.define(RouteListItem(
    // imageName: 'images/aside/41.png',
    iconData: IconCode.navDeposit,
    route: RoutePage.deposit,
  ));
  static ScreenDrawerItem wallet = ScreenDrawerItem.define(RouteListItem(
    iconData: IconCode.gridWallet,
    route: RoutePage.sideWallet,
  ));
  static ScreenDrawerItem store = ScreenDrawerItem.define(RouteListItem(
    iconData: IconCode.drawerStore,
    route: RoutePage.sideStore,
  ));
  // static ScreenDrawerItem roller = ScreenDrawerItem.define(RouteListItem(
  //   iconData: IconCode.drawerRoller,
  //   route: RoutePage.sideRoller,
  // ));
  static ScreenDrawerItem vip = ScreenDrawerItem.define(RouteListItem(
    imageName: 'images/aside/63.png',
    iconData: IconCode.gridVip,
    route: RoutePage.sideVipLevel,
  ));
  // static ScreenDrawerItem sign = ScreenDrawerItem.define(RouteListItem(
  //   routeId: RouteEnum.SIGN,
  //   iconData: IconCode.drawerEvent,
  //   userOnly: true,
  // ));
  // static ScreenDrawerItem task = ScreenDrawerItem.define(RouteListItem(
  //   routeId: RouteEnum.TASK,
  //   imageName: 'images/aside/53.png',
  //   userOnly: true,
  // ));
  // static ScreenDrawerItem collect = ScreenDrawerItem.define(RouteListItem(
  //   routeId: RouteEnum.COLLECT,
  //   imageName: 'images/aside/55.png',
  //   userOnly: true,
  // ));

  /// Redirect
  static ScreenDrawerItem website = ScreenDrawerItem.define(RouteListItem(
    routeId: RouteEnum.WEBSITE,
    iconData: IconCode.tabWebsite,
  ));
  static ScreenDrawerItem logout = ScreenDrawerItem.define(RouteListItem(
    routeId: RouteEnum.LOGOUT,
    iconData: IconCode.gridLogout,
    userOnly: true,
  ));

  /// TEST
  static ScreenDrawerItem testUI = ScreenDrawerItem.define(RouteListItem(
    iconData: IconCode.drawerTest,
    route: RoutePage.testArea,
  ));
  static ScreenDrawerItem test = ScreenDrawerItem.define(RouteListItem(
    routeId: RouteEnum.TEST,
    iconData: IconCode.drawerTest,
  ));

  /// for web game screen drawer
  static ScreenDrawerItem backHome = ScreenDrawerItem.define(RouteListItem(
    routeId: RouteEnum.BACK_HOME,
    iconData: Icons.home,
    route: RoutePage.home,
  ));
  static ScreenDrawerItem rotate = ScreenDrawerItem.define(RouteListItem(
    routeId: RouteEnum.ROTATE,
    iconData: Icons.rotate_90_degrees_ccw,
  ));
  static ScreenDrawerItem rotateLock = ScreenDrawerItem.define(RouteListItem(
    routeId: RouteEnum.ROTATE_LOCK,
    iconData: Icons.crop_rotate,
  ));

  /// Used for defining cases
  const ScreenDrawerItem.define(RouteListItem fromValue)
      : super.define(fromValue);
}
