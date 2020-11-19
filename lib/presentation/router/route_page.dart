import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_eg990_mobile/mylogger.dart';
import 'package:vnum/vnum.dart';

import '../screens/main_screen_bar_type.dart';
import 'auto_router.gr.dart';
import 'data/route_enum.dart';
import 'data/route_info.dart';

export '../screens/main_screen_bar_type.dart';
export 'data/route_enum.dart';

part 'route_page_ext.dart';

const ROUTE_POSTFIX_SIDE = '-side';

@VnumDefinition
class RoutePage extends Vnum<RouteInfo> {
  /// Case Definition
  static const RoutePage home = const RoutePage.define(RouteInfo(
    id: RouteEnum.HOME,
    route: MainScreenRoutes.homeRoute,
    bottomNavIndex: 0,
    appBarType: MainScreenAppBarTypes.LOGO_AND_MESSAGE_CENTER,
    navBarType: MainScreenNavBarTypes.HOME,
  ));

  static const RoutePage member = const RoutePage.define(RouteInfo(
    id: RouteEnum.MEMBER,
    route: MainScreenRoutes.homeRoute,
    bottomNavIndex: 1,
    appBarType: MainScreenAppBarTypes.TITLE_AND_SETTINGS,
    navBarType: MainScreenNavBarTypes.HOME,
  ));

  /// Used for defining cases
  const RoutePage.define(RouteInfo fromValue) : super.define(fromValue);

  /// Used for loading enum using value
  factory RoutePage(RouteInfo value) => Vnum.fromValue(value, RoutePage);

  /// Iterating cases
  /// All value needs to be constant for this to work
  static List<Vnum> get listAll => Vnum.allCasesFor(RoutePage);

  String get pageName => value.route;

  RouteEnum get pageId => value.id;

  String get pageTitle => value.id.title;

  String get pageRoot => value.root;

  bool get isUserOnly => value.isUserOnly;

  MainScreenAppBarTypes get appBarType => value.appBarType;

  MainScreenNavBarTypes get navBarType => value.navBarType;

  int get navIndex => value.bottomNavIndex;

  bool get hasBottomNav => value.bottomNavIndex != -1;
}
