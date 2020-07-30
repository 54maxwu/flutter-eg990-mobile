import 'package:flutter/widgets.dart' show IconData;
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/features/router/route_list_item.dart';
import 'package:flutter_ty_mobile/features/router/route_page.dart';
import 'package:flutter_ty_mobile/res.dart';

export 'package:flutter_ty_mobile/features/router/route_list_item.dart';

import 'package:vnum/vnum.dart';

@VnumDefinition
class MoreGridItem extends Vnum<RouteListItem> {
  /// Case Definition
  static MoreGridItem notice = MoreGridItem.define(RouteListItem(
    iconData: const IconData(0xf028, fontFamily: 'FontAwesome'),
    route: RoutePage.noticeBoard,
  ));
  static MoreGridItem download = MoreGridItem.define(RouteListItem(
    iconData: const IconData(0xf0ed, fontFamily: 'FontAwesome'),
    route: RoutePage.downloadArea,
  ));
  static MoreGridItem tutorial = MoreGridItem.define(RouteListItem(
    replaceTitle: localeStr.pageTitleTutorial,
    iconData: const IconData(0xf059, fontFamily: 'FontAwesome'),
    route: RoutePage.moreWeb,
    webUrl: '${Global.CURRENT_SERVICE}newbie',
  ));
  static MoreGridItem service = MoreGridItem.define(RouteListItem(
    iconData: const IconData(0xf025, fontFamily: 'FontAwesome'),
    route: RoutePage.service,
    webUrl: Global.TY_SERVICE_URL,
  ));
  static MoreGridItem routeChange = MoreGridItem.define(RouteListItem(
    replaceTitle: localeStr.pageTitleRouter,
    iconData: const IconData(0xf1eb, fontFamily: 'FontAwesome'),
  ));
  static MoreGridItem store = MoreGridItem.define(RouteListItem(
    replaceTitle: localeStr.pageTitleStore,
    iconData: const IconData(0xf290, fontFamily: 'FontAwesome'),
    isUserOnly: true,
    route: RoutePage.pointStore,
  ));
  static MoreGridItem roller = MoreGridItem.define(RouteListItem(
    replaceTitle: localeStr.pageTitleRoller,
    imageName: 'images/moreShow_lucky.png',
    route: RoutePage.roller,
  ));
  static MoreGridItem task = MoreGridItem.define(RouteListItem(
    replaceTitle: localeStr.pageTitleTask,
    imageName: 'images/moreShow_mission.png',
    isUserOnly: true,
  ));
  static MoreGridItem sign = MoreGridItem.define(RouteListItem(
    replaceTitle: localeStr.pageTitleSign,
    imageName: 'images/flico_sign.png?1',
    isUserOnly: true,
  ));
  static MoreGridItem agentAbout = MoreGridItem.define(RouteListItem(
    replaceTitle: localeStr.pageTitleMemberAgentAbout,
    imageName: 'images/footer/ftico_agent.png',
    route: RoutePage.moreWeb,
    webUrl: '${Global.CURRENT_SERVICE}agentPage',
  ));
  static MoreGridItem collect = MoreGridItem.define(RouteListItem(
    replaceTitle: localeStr.pageTitleCollect,
    imageName: Res.flico_word,
    isUserOnly: true,
  ));

  /// Used for defining cases
  const MoreGridItem.define(RouteListItem fromValue) : super.define(fromValue);

  /// Used for loading enum using value
  factory MoreGridItem(RouteListItem value) =>
      Vnum.fromValue(value, MoreGridItem);

  /// Iterating cases
  Iterable get listAll => Vnum.allCasesFor(MoreGridItem);
}
