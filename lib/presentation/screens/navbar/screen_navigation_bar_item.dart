import 'package:flutter_eg990_mobile/application/themes/icon_code.dart';
import 'package:flutter_eg990_mobile/presentation/router/route_page.dart';
import 'package:flutter_eg990_mobile/presentation/router/data/route_list_item.dart';
import 'package:flutter_eg990_mobile/res.dart';
import 'package:vnum/vnum.dart';

export 'package:flutter_eg990_mobile/presentation/router/data/route_list_item.dart';

@VnumDefinition
class ScreenNavigationBarItem extends Vnum<RouteListItem> {
  static const ScreenNavigationBarItem home =
      const ScreenNavigationBarItem.define(RouteListItem(
    iconData: IconCode.navHome,
    imageName: Res.icon_home,
    imageSubName: Res.icon_home_u,
    route: RoutePage.home,
  ));
  static const ScreenNavigationBarItem promo =
      const ScreenNavigationBarItem.define(RouteListItem(
    iconData: IconCode.navPromo,
    imageName: Res.icon_bonus,
    imageSubName: Res.icon_bonus_u,
    route: RoutePage.promo,
  ));
  static const ScreenNavigationBarItem service =
      const ScreenNavigationBarItem.define(RouteListItem(
    iconData: IconCode.navService,
    imageName: Res.icon_service,
    imageSubName: Res.icon_service_u,
    route: RoutePage.service,
  ));
  static const ScreenNavigationBarItem sponsor =
      const ScreenNavigationBarItem.define(RouteListItem(
    iconData: IconCode.navSponsor,
    imageName: Res.icon_sponsor,
    imageSubName: Res.icon_sponsor_u,
    route: RoutePage.sponsor,
  ));
  static const ScreenNavigationBarItem member =
      const ScreenNavigationBarItem.define(RouteListItem(
    iconData: IconCode.navMember,
    imageName: Res.icon_user,
    imageSubName: Res.icon_user_u,
    route: RoutePage.member,
  ));

  /// Used for defining cases
  const ScreenNavigationBarItem.define(RouteListItem fromValue)
      : super.define(fromValue);

  /// Iterating cases
  /// All value needs to be constant for this to work
  static List<Vnum> get listAll => Vnum.allCasesFor(ScreenNavigationBarItem);

  static List<ScreenNavigationBarItem> get mapAll =>
      listAll.map((v) => v as ScreenNavigationBarItem).toList();
}
