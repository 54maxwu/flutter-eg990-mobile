import 'package:flutter_eg990_mobile/features/router/route_list_item.dart';
import 'package:flutter_eg990_mobile/features/router/route_page.dart';
import 'package:flutter_eg990_mobile/features/themes/icon_code.dart';
import 'package:flutter_eg990_mobile/res.dart';
import 'package:flutter_eg990_mobile/utils/regex_util.dart';
import 'package:vnum/vnum.dart';

export 'package:flutter_eg990_mobile/features/router/route_list_item.dart';

@VnumDefinition
class MoreGridItem extends Vnum<RouteListItem> {
  /// Case Definition
  static MoreGridItem notice = MoreGridItem.define(RouteListItem(
    iconData: IconCode.drawerNotice,
    route: RoutePage.sideNoticeBoard,
  ));
  static MoreGridItem download = MoreGridItem.define(RouteListItem(
    iconData: IconCode.drawerDownload,
    route: RoutePage.sideDownload,
  ));
  static MoreGridItem tutorial = MoreGridItem.define(RouteListItem(
    iconData: IconCode.drawerTutorial,
    route: RoutePage.moreTutorial,
  ));
  static MoreGridItem vip = MoreGridItem.define(RouteListItem(
    iconData: IconCode.gridVip,
    imageName: 'images/moreShow_vip.png',
    route: RoutePage.sideVipLevel,
  ));
  static MoreGridItem service = MoreGridItem.define(RouteListItem(
    iconData: IconCode.drawerService,
    route: RoutePage.service,
  ));
  static MoreGridItem routeChange = MoreGridItem.define(RouteListItem(
    routeId: RouteEnum.ROUTE_CHANGE,
    iconData: IconCode.moreRouteChange,
  ));
  static MoreGridItem store = MoreGridItem.define(RouteListItem(
    iconData: IconCode.drawerStore,
    route: RoutePage.sideStore,
    userOnly: true,
  ));
  static MoreGridItem roller = MoreGridItem.define(RouteListItem(
    iconData: IconCode.drawerRoller,
    imageName: 'images/moreShow_lucky.png',
    route: RoutePage.sideRoller,
  ));
  static MoreGridItem task = MoreGridItem.define(RouteListItem(
    routeId: RouteEnum.TASK,
    imageName: 'images/moreShow_mission.png',
    userOnly: true,
  ));
  static MoreGridItem sign = MoreGridItem.define(RouteListItem(
    routeId: RouteEnum.SIGN,
    imageName: 'images/flico_sign.png?1',
    userOnly: true,
  ));
  static MoreGridItem agentAbout = MoreGridItem.define(RouteListItem(
    imageName: 'images/footer/ftico_agent.png',
    route: RoutePage.moreAgentAbout,
  ));
  static MoreGridItem collect = MoreGridItem.define(RouteListItem(
    routeId: RouteEnum.COLLECT,
    imageName: Res.flico_word,
    userOnly: true,
  ));

  /// Used for defining cases
  const MoreGridItem.define(RouteListItem fromValue) : super.define(fromValue);

  /// Used for loading enum using value
  factory MoreGridItem(RouteListItem value) =>
      Vnum.fromValue(value, MoreGridItem);

  bool isLongText(int limit) =>
      (value.title ?? value.route.pageTitle ?? '?').countLength > limit;
}
