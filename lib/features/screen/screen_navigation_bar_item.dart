import 'package:flutter/material.dart' show IconData, Icons;
import 'package:flutter_eg990_mobile/core/internal/global.dart';
import 'package:flutter_eg990_mobile/core/internal/local_strings.dart';
import 'package:flutter_eg990_mobile/features/router/route_list_item.dart';
import 'package:flutter_eg990_mobile/features/router/route_page.dart';
import 'package:vnum/vnum.dart';

export 'package:flutter_eg990_mobile/features/router/route_list_item.dart';

@VnumDefinition
class ScreenNavigationBarItem extends Vnum<RouteListItem> {
  static ScreenNavigationBarItem home =
      ScreenNavigationBarItem.define(RouteListItem(
    replaceTitle: localeStr.pageTitleHome,
    iconData: const IconData(0xf015, fontFamily: 'FontAwesome'),
    route: RoutePage.home,
  ));
  static ScreenNavigationBarItem deposit =
      ScreenNavigationBarItem.define(RouteListItem(
    iconData: const IconData(0xf09d, fontFamily: 'FontAwesome'),
    route: RoutePage.deposit,
    isUserOnly: true,
  ));
  static ScreenNavigationBarItem agent =
      ScreenNavigationBarItem.define(RouteListItem(
    iconData: const IconData(0xf2b5, fontFamily: 'FontAwesome'),
    route: RoutePage.agentFeature,
    isUserOnly: true,
  ));
  static ScreenNavigationBarItem promo =
      ScreenNavigationBarItem.define(RouteListItem(
    iconData: const IconData(0xf06b, fontFamily: 'FontAwesome'),
    route: RoutePage.promo,
  ));
  static ScreenNavigationBarItem service =
      ScreenNavigationBarItem.define(RouteListItem(
    iconData: const IconData(0xf27a, fontFamily: 'FontAwesome'),
    route: RoutePage.service,
    webUrl: Global.TY_SERVICE_URL,
  ));
  static ScreenNavigationBarItem member =
      ScreenNavigationBarItem.define(RouteListItem(
    iconData: const IconData(0xf2bd, fontFamily: 'FontAwesome'),
    route: RoutePage.member,
    isUserOnly: true,
  ));
  static ScreenNavigationBarItem more =
      ScreenNavigationBarItem.define(RouteListItem(
    replaceTitle: localeStr.pageTitleMore,
    iconData: Icons.more_horiz,
  ));

  /// Used for defining cases
  const ScreenNavigationBarItem.define(RouteListItem fromValue)
      : super.define(fromValue);
}
