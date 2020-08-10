import 'package:flutter/material.dart' show IconData, Icons;
import 'package:flutter_eg990_mobile/core/internal/global.dart';
import 'package:flutter_eg990_mobile/core/internal/local_strings.dart';
import 'package:flutter_eg990_mobile/features/router/route_list_item.dart';
import 'package:flutter_eg990_mobile/features/router/route_page.dart';
import 'package:vnum/vnum.dart';

export 'package:flutter_eg990_mobile/features/router/route_list_item.dart';

@VnumDefinition
class ScreenDrawerItem extends Vnum<RouteListItem> {
  static ScreenDrawerItem home = ScreenDrawerItem.define(RouteListItem(
    replaceTitle: localeStr.pageTitleHome,
    iconData: const IconData(0xf015, fontFamily: 'FontAwesome'),
    route: RoutePage.home,
  ));
  static ScreenDrawerItem download = ScreenDrawerItem.define(RouteListItem(
    iconData: const IconData(0xf0ed, fontFamily: 'FontAwesome'),
    route: RoutePage.downloadArea,
    isUserOnly: true,
  ));
  static ScreenDrawerItem tutorial = ScreenDrawerItem.define(RouteListItem(
    replaceTitle: localeStr.pageTitleTutorial,
    iconData: const IconData(0xf059, fontFamily: 'FontAwesome'),
    route: RoutePage.tutorial,
    webUrl: '${Global.CURRENT_SERVICE}newbie',
  ));
  static ScreenDrawerItem notice = ScreenDrawerItem.define(RouteListItem(
    iconData: const IconData(0xf028, fontFamily: 'FontAwesome'),
    route: RoutePage.noticeBoard,
  ));
  static ScreenDrawerItem wallet = ScreenDrawerItem.define(RouteListItem(
    iconData: const IconData(0xf155, fontFamily: 'FontAwesome'),
    route: RoutePage.sideWallet,
    isUserOnly: true,
  ));
  static ScreenDrawerItem vip = ScreenDrawerItem.define(RouteListItem(
    replaceTitle: localeStr.centerViewTitleVip,
    iconData: const IconData(0xf219, fontFamily: 'FontAwesome'),
    route: RoutePage.vipLevel,
  ));
  static ScreenDrawerItem sign = ScreenDrawerItem.define(RouteListItem(
    replaceTitle: localeStr.pageTitleSign,
    iconData: const IconData(0xf274, fontFamily: 'FontAwesome'),
    isUserOnly: true,
  ));
  static ScreenDrawerItem store = ScreenDrawerItem.define(RouteListItem(
    replaceTitle: localeStr.pageTitleStore,
    iconData: const IconData(0xf290, fontFamily: 'FontAwesome'),
    isUserOnly: true,
    route: RoutePage.pointStore,
  ));
  static ScreenDrawerItem logout = ScreenDrawerItem.define(RouteListItem(
    replaceTitle: localeStr.memberGridTitleLogout,
    iconData: const IconData(0xf08b, fontFamily: 'FontAwesome'),
    isUserOnly: true,
  ));
  static ScreenDrawerItem testUI = ScreenDrawerItem.define(RouteListItem(
    replaceTitle: 'Test UI',
    iconData: Icons.warning,
    route: RoutePage.testArea,
  ));
  static ScreenDrawerItem test = ScreenDrawerItem.define(RouteListItem(
    replaceTitle: 'Test',
    iconData: Icons.warning,
  ));

  /// for web game screen drawer
  static ScreenDrawerItem backHome = ScreenDrawerItem.define(RouteListItem(
    replaceTitle: localeStr.sideBtnBackHome,
    iconData: Icons.home,
    route: RoutePage.home,
  ));
  static ScreenDrawerItem rotate = ScreenDrawerItem.define(RouteListItem(
    replaceTitle: localeStr.sideBtnRotate,
    iconData: Icons.rotate_90_degrees_ccw,
  ));
  static ScreenDrawerItem rotateLock = ScreenDrawerItem.define(RouteListItem(
    replaceTitle: localeStr.sideBtnLockRotate,
    iconData: Icons.crop_rotate,
  ));

  /// Used for defining cases
  const ScreenDrawerItem.define(RouteListItem fromValue)
      : super.define(fromValue);
}
