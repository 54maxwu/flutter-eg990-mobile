import 'package:flutter_eg990_mobile/application/themes/icon_code.dart';
import 'package:flutter_eg990_mobile/presentation/router/data/route_enum.dart';
import 'package:flutter_eg990_mobile/presentation/router/route_page.dart';
import 'package:vnum/vnum.dart';

import 'shortcut_data.dart';

export 'shortcut_data.dart' show ShortcutDataExtension;

@VnumDefinition
class ShortcutItem extends Vnum<ShortcutData> {
  static ShortcutItem deposit = ShortcutItem.define(ShortcutData(
    id: RouteEnum.DEPOSIT,
    iconData: IconCode.gridDeposit,
    // route: RoutePage.home,
  ));
  static ShortcutItem transfer = ShortcutItem.define(ShortcutData(
    id: RouteEnum.TRANSFER,
    iconData: IconCode.gridTransfer,
    // route: RoutePage.home,
  ));
  static ShortcutItem withdraw = ShortcutItem.define(ShortcutData(
    id: RouteEnum.WITHDRAW,
    iconData: IconCode.gridWithdraw,
    // route: RoutePage.home,
  ));
  static ShortcutItem vip = ShortcutItem.define(ShortcutData(
    id: RouteEnum.VIP,
    iconData: IconCode.gridVip,
    // route: RoutePage.home,
  ));

  /// Used for defining cases
  const ShortcutItem.define(ShortcutData fromValue) : super.define(fromValue);
}
