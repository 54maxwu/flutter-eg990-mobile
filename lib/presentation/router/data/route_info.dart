import 'package:freezed_annotation/freezed_annotation.dart';

import '../../screens/main_screen_bar_type.dart';
import '../auto_router.gr.dart';
import 'route_enum.dart';

part 'route_info.freezed.dart';

@freezed
abstract class RouteInfo with _$RouteInfo {
  const factory RouteInfo({
    @required RouteEnum id,
    @required String route,
    Object routeArg,
    @Default(MainScreenRoutes.homeRoute) String root,

    /// if true, check the user login status before navigate
    @Default(false) bool isUserOnly,

    /// if true, shows the widget on the right side (logout, register...etc)
    @Default(MainScreenAppBarTypes.BACK_AND_TITLE)
        MainScreenAppBarTypes appBarType,

    /// if true, shows the widget on the right side (logout, register...etc)
    @Default(MainScreenNavBarTypes.HIDE) MainScreenNavBarTypes navBarType,

    /// 1. sets the bottom navigator index to highlight icon
    /// 2. effect the navigation action
    /// 3. if value > -1, shows the side menu action bar
    @Default(-1) int bottomNavIndex,

    /// for promo and banner to find nav destination
    String webPageName,

    /// override page title
    @Default('') String title,
  }) = _RouteInfo;
}

extension RouteInfoExtension on RouteInfo {
  bool get hideNavBar => navBarType == MainScreenNavBarTypes.HIDE;

  String get pageTitle {
    if (title.isNotEmpty) return title;
    switch (appBarType) {
      case MainScreenAppBarTypes.LOGO_AND_MESSAGE_CENTER:
        return '';
      case MainScreenAppBarTypes.TITLE_AND_SETTINGS:
      case MainScreenAppBarTypes.BACK_AND_TITLE:
        return id.title.replaceAll('???', '');
      case MainScreenAppBarTypes.BACK_TITLE_SEARCH:
        return id.title;
      default:
        return '';
    }
  }
}
