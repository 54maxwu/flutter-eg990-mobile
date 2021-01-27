import 'package:flutter_eg990_mobile/presentation/router/data/route_enum.dart';
import 'package:flutter_eg990_mobile/presentation/router/route_page.dart';
import 'package:flutter_eg990_mobile/res.dart';
import 'package:vnum/vnum.dart';

import 'member_shortcut_data.dart';

export 'member_shortcut_data.dart' show MemberShortcutDataExtension;

@VnumDefinition
class MemberShortcutItem extends Vnum<MemberShortcutData> {
  ///
  /// MemberShortcutType.NORMAL
  ///
  static const MemberShortcutItem wallet =
      const MemberShortcutItem.define(MemberShortcutData(
    id: RouteEnum.WALLET,
    assetPath: Res.f_icon_wallet,
    sType: MemberShortcutType.NORMAL,
  ));
  static const MemberShortcutItem bet_record =
      const MemberShortcutItem.define(MemberShortcutData(
    id: RouteEnum.BET_RECORD,
    route: RoutePage.bet_record,
    assetPath: Res.f_icon_bets,
    sType: MemberShortcutType.NORMAL,
  ));
  static const MemberShortcutItem deals =
      const MemberShortcutItem.define(MemberShortcutData(
    id: RouteEnum.TRANSFER_RECORD,
    assetPath: Res.f_icon_transfer_record,
    sType: MemberShortcutType.NORMAL,
  ));
  static const MemberShortcutItem accountCenter =
      const MemberShortcutItem.define(MemberShortcutData(
    id: RouteEnum.MEMBER_CENTER,
    route: RoutePage.member_center,
    assetPath: Res.f_icon_account,
    sType: MemberShortcutType.NORMAL,
  ));

  ///
  /// MemberShortcutType.COMPLEX
  ///
  static const MemberShortcutItem vip_about =
      const MemberShortcutItem.define(MemberShortcutData(
    id: RouteEnum.VIP_ABOUT,
    assetPath: Res.f_icon_vip_about,
    sType: MemberShortcutType.COMPLEX,
    hintText: 'VIP PRIVILEGE',
  ));
  static const MemberShortcutItem store =
      const MemberShortcutItem.define(MemberShortcutData(
    id: RouteEnum.STORE,
    assetPath: Res.f_icon_store,
    sType: MemberShortcutType.COMPLEX,
    hintText: 'YABO MALL',
  ));

  ///
  /// MemberShortcutType.LIST
  ///
  static const MemberShortcutItem exchange_record =
      const MemberShortcutItem.define(MemberShortcutData(
    id: RouteEnum.EXCHANGE_RECORD,
    assetPath: Res.icon_record,
    sType: MemberShortcutType.LIST,
    section: 0,
  ));
  static const MemberShortcutItem help_center =
      const MemberShortcutItem.define(MemberShortcutData(
    id: RouteEnum.HELP,
    assetPath: Res.icon_help,
    sType: MemberShortcutType.LIST,
    section: 1,
  ));
  static const MemberShortcutItem invite =
      const MemberShortcutItem.define(MemberShortcutData(
    id: RouteEnum.INVITE,
    assetPath: Res.icon_invite,
    sType: MemberShortcutType.LIST,
    section: 2,
  ));
  static const MemberShortcutItem join_us =
      const MemberShortcutItem.define(MemberShortcutData(
    id: RouteEnum.JOIN_US,
    assetPath: Res.icon_join,
    sType: MemberShortcutType.LIST,
    section: 2,
  ));
  static const MemberShortcutItem about_us =
      const MemberShortcutItem.define(MemberShortcutData(
    id: RouteEnum.ABOUT_US,
    route: RoutePage.about_us,
    assetPath: Res.icon_about,
    sType: MemberShortcutType.LIST,
    section: 2,
  ));
  static const MemberShortcutItem to_website =
      const MemberShortcutItem.define(MemberShortcutData(
    id: RouteEnum.WEBSITE,
    assetPath: Res.icon_app,
    sType: MemberShortcutType.LIST,
    section: 3,
  ));
  static const MemberShortcutItem logout =
      const MemberShortcutItem.define(MemberShortcutData(
    id: RouteEnum.LOGOUT,
    assetPath: Res.icon_exit,
    sType: MemberShortcutType.LIST,
    section: 3,
  ));

  /// Used for defining cases
  const MemberShortcutItem.define(MemberShortcutData fromValue)
      : super.define(fromValue);

  /// Iterating cases
  static List<MemberShortcutItem> mapByTypeIndex(int typeIndex) =>
      Vnum.allCasesFor(MemberShortcutItem)
          .where((e) => e.value.sType.index == typeIndex)
          .map((e) => e as MemberShortcutItem)
          .toList();
}
