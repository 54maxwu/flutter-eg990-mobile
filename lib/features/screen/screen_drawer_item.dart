import 'package:flutter/material.dart' show IconData, Icons;
import 'package:flutter_eg990_mobile/features/router/route_list_item.dart';
import 'package:flutter_eg990_mobile/features/router/route_page.dart';
import 'package:vnum/vnum.dart';

export 'package:flutter_eg990_mobile/features/router/route_list_item.dart';

@VnumDefinition
class ScreenDrawerItem extends Vnum<RouteListItem> {
  static ScreenDrawerItem home = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.HOME,
    iconData: const IconData(0xf015, fontFamily: 'FontAwesome'),
//    iconData: const IconData(0xe95e, fontFamily: 'IconMoon'),
    route: RoutePage.home,
  ));
  static ScreenDrawerItem promo = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.PROMO,
    imageName: 'images/aside/43.png',
    iconData: const IconData(0xf06b, fontFamily: 'FontAwesome'),
//    iconData: const IconData(0xe965, fontFamily: 'IconMoon'),
    route: RoutePage.promo,
  ));
  static ScreenDrawerItem service = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.SERVICE,
    imageName: 'images/aside/59.png',
    iconData: const IconData(0xf27a, fontFamily: 'FontAwesome'),
//    iconData: const IconData(0xe967, fontFamily: 'IconMoon'),
    route: RoutePage.service,
  ));
  static ScreenDrawerItem tutorial = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.TUTORIAL,
    iconData: const IconData(0xf059, fontFamily: 'FontAwesome'),
//    iconData: const IconData(0xe962, fontFamily: 'IconMoon'),
    route: RoutePage.sideTutorial,
  ));
  static ScreenDrawerItem agentAbout = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.AGENT_ABOUT,
    imageName: 'images/aside/65.png',
    route: RoutePage.agentAbout,
  ));

  /// USER
  static ScreenDrawerItem member = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.MEMBER,
    imageName: 'images/aside/39.png',
    iconData: const IconData(0xf2bd, fontFamily: 'FontAwesome'),
//    iconData: const IconData(0xe961, fontFamily: 'IconMoon'),
    route: RoutePage.member,
    isUserOnly: true,
  ));
  static ScreenDrawerItem deposit = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.DEPOSIT,
    imageName: 'images/aside/41.png',
    iconData: const IconData(0xf09d, fontFamily: 'FontAwesome'),
//    iconData: const IconData(0xe95d, fontFamily: 'IconMoon'),
    route: RoutePage.deposit,
    isUserOnly: true,
  ));
  static ScreenDrawerItem message = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.MESSAGE,
    imageName: 'images/aside/45.png',
    iconData: const IconData(0xf0e0, fontFamily: 'FontAwesome'),
//    iconData: const IconData(0xe968, fontFamily: 'IconMoon'),
    route: RoutePage.message,
    isUserOnly: true,
  ));

  static ScreenDrawerItem task = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.TASK,
    imageName: 'images/aside/53.png',
    isUserOnly: true,
  ));
  static ScreenDrawerItem collect = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.COLLECT,
    imageName: 'images/aside/55.png',
    isUserOnly: true,
  ));
  static ScreenDrawerItem notice = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.NOTICE,
    imageName: 'images/aside/47.png',
    iconData: const IconData(0xf028, fontFamily: 'FontAwesome'),
//    iconData: const IconData(0xe967, fontFamily: 'IconMoon'),
    route: RoutePage.sideNoticeBoard,
    isUserOnly: true,
  ));
  static ScreenDrawerItem download = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.DOWNLOAD,
    imageName: 'images/aside/61.png',
//    iconData: const IconData(0xf0ed, fontFamily: 'FontAwesome'),
    route: RoutePage.downloadArea,
    isUserOnly: true,
  ));
  static ScreenDrawerItem wallet = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.WALLET,
    iconData: const IconData(0xf155, fontFamily: 'FontAwesome'),
//    iconData: const IconData(0xe964, fontFamily: 'IconMoon'),
    route: RoutePage.sideWallet,
    isUserOnly: true,
  ));
  static ScreenDrawerItem vip = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.VIP,
    imageName: 'images/aside/63.png',
    iconData: const IconData(0xf219, fontFamily: 'FontAwesome'),
//    iconData: const IconData(0xe96d, fontFamily: 'IconMoon'),
    route: RoutePage.sideVipLevel,
  ));
  static ScreenDrawerItem store = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.STORE,
    imageName: 'images/aside/49.png',
    iconData: const IconData(0xf290, fontFamily: 'FontAwesome'),
    isUserOnly: true,
    route: RoutePage.pointStore,
  ));
  static ScreenDrawerItem roller = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.ROLLER,
    imageName: 'images/aside/51.png',
    route: RoutePage.roller,
    isUserOnly: true,
  ));
  static ScreenDrawerItem sign = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.SIGN,
    imageName: 'images/aside/57.png',
    iconData: const IconData(0xf274, fontFamily: 'FontAwesome'),
    isUserOnly: true,
  ));

  /// Redirect
  static ScreenDrawerItem website = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.WEBSITE,
//    iconData: const IconData(0xe905, fontFamily: 'IconMoon'),
  ));
  static ScreenDrawerItem logout = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.LOGOUT,
    iconData: const IconData(0xf08b, fontFamily: 'FontAwesome'),
//    iconData: const IconData(0xe95f, fontFamily: 'IconMoon'),
    isUserOnly: true,
  ));

  /// TEST
  static ScreenDrawerItem testUI = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.TEST_UI,
    iconData: Icons.warning,
    route: RoutePage.testArea,
  ));
  static ScreenDrawerItem test = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.TEST,
    iconData: Icons.warning,
  ));

  /// for web game screen drawer
  static ScreenDrawerItem backHome = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.BACK_HOME,
    iconData: Icons.home,
    route: RoutePage.home,
  ));
  static ScreenDrawerItem rotate = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.ROTATE,
    iconData: Icons.rotate_90_degrees_ccw,
  ));
  static ScreenDrawerItem rotateLock = ScreenDrawerItem.define(RouteListItem(
    id: RouteEnum.ROTATE_LOCK,
    iconData: Icons.crop_rotate,
  ));

  /// Used for defining cases
  const ScreenDrawerItem.define(RouteListItem fromValue)
      : super.define(fromValue);
}
