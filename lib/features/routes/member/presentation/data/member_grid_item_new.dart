import 'package:flutter_eg990_mobile/features/router/route_page.dart';
import 'package:flutter_eg990_mobile/features/themes/hex_color.dart';
import 'package:flutter_eg990_mobile/features/themes/icon_code.dart';
import 'package:vnum/vnum.dart';

import 'member_grid_item_data.dart';

export 'member_grid_item_data.dart' show MemberGridItemDataExtension;

@VnumDefinition
class MemberGridItemNew extends Vnum<MemberGridItemData> {
  static MemberGridItemNew deposit =
      MemberGridItemNew.define(MemberGridItemData(
    id: RouteEnum.DEPOSIT,
    iconData: IconCode.gridDeposit,
    // imageName: 'images/user/macico_dsp.png',
    route: RoutePage.deposit,
    createLinearGradient: () => getLinearGradient(
      [
        HexColor.fromHex('#ffb468'),
        HexColor.fromHex('#f36500'),
      ],
      null,
    ),
  ));
  static MemberGridItemNew transfer =
      MemberGridItemNew.define(MemberGridItemData(
    id: RouteEnum.TRANSFER,
    iconData: IconCode.gridTransfer,
    // imageName: 'images/user/macico_tsf.png',
    route: RoutePage.transfer,
    createLinearGradient: () => getLinearGradient(
      [
        HexColor.fromHex('#6ede52'),
        HexColor.fromHex('#32a063'),
      ],
      null,
    ),
  ));
  static MemberGridItemNew bankcard =
      MemberGridItemNew.define(MemberGridItemData(
    id: RouteEnum.BANKCARD,
    iconData: IconCode.gridBankcard,
    // imageName: 'images/user/macico_bkcard.png',
    route: RoutePage.bankcard,
    createLinearGradient: () => getLinearGradient(
      [
        HexColor.fromHex('#7bdefb'),
        HexColor.fromHex('#0082ce'),
      ],
      null,
    ),
  ));
  static MemberGridItemNew withdraw =
      MemberGridItemNew.define(MemberGridItemData(
    id: RouteEnum.WITHDRAW,
    iconData: IconCode.gridWithdraw,
    // imageName: 'images/user/macico_wdl.png',
    route: RoutePage.withdraw,
    createLinearGradient: () => getLinearGradient(
      [
        HexColor.fromHex('#7294f5'),
        HexColor.fromHex('#3054bb'),
      ],
      null,
    ),
  ));
  static MemberGridItemNew balance =
      MemberGridItemNew.define(MemberGridItemData(
    id: RouteEnum.BALANCE,
    iconData: IconCode.gridBalance,
    // imageName: 'images/user/macico_plaf.png',
    route: RoutePage.balance,
    createLinearGradient: () => getLinearGradient(
      [
        HexColor.fromHex('#ff88f0'),
        HexColor.fromHex('#ad2087'),
      ],
      null,
    ),
  ));
  static MemberGridItemNew wallet = MemberGridItemNew.define(MemberGridItemData(
    id: RouteEnum.WALLET,
    iconData: IconCode.gridWallet,
    // imageName: 'images/user/macico_tsfwa.png',
    route: RoutePage.wallet,
    createLinearGradient: () => getLinearGradient(
      [
        HexColor.fromHex('#3df3c0'),
        HexColor.fromHex('#119c8f'),
      ],
      null,
    ),
  ));
  static MemberGridItemNew stationMessages =
      MemberGridItemNew.define(MemberGridItemData(
    id: RouteEnum.MESSAGE,
    iconData: IconCode.gridMessage,
    // imageName: 'images/user/macico_msg.png',
    route: RoutePage.message,
    createLinearGradient: () => getLinearGradient(
      [
        HexColor.fromHex('#d265ff'),
        HexColor.fromHex('#7c2fad'),
      ],
      null,
    ),
  ));
  static MemberGridItemNew accountCenter =
      MemberGridItemNew.define(MemberGridItemData(
    id: RouteEnum.CENTER,
    iconData: IconCode.gridCenter,
    // imageName: 'images/user/macico_cent.png',
    route: RoutePage.center,
    createLinearGradient: () => getLinearGradient(
      [
        HexColor.fromHex('#e65757'),
        HexColor.fromHex('#ce0909'),
      ],
      null,
    ),
  ));
  static MemberGridItemNew transferRecord =
      MemberGridItemNew.define(MemberGridItemData(
    id: RouteEnum.TRANSFER_RECORD,
    iconData: IconCode.gridTransactions,
    // imageName: 'images/user/macico_tsfre.png',
    route: RoutePage.transaction,
    createLinearGradient: () => getLinearGradient(
      [
        HexColor.fromHex('#f1dd98'),
        HexColor.fromHex('#9c7407'),
      ],
      null,
    ),
  ));
  static MemberGridItemNew betRecord =
      MemberGridItemNew.define(MemberGridItemData(
    id: RouteEnum.BETS,
    iconData: IconCode.gridBets,
    // imageName: 'images/user/macico_bthis.png',
    route: RoutePage.betRecord,
    createLinearGradient: () => getLinearGradient(
      [
        HexColor.fromHex('#33c8ff'),
        HexColor.fromHex('#185cc3'),
      ],
      null,
    ),
  ));
  static MemberGridItemNew dealRecord =
      MemberGridItemNew.define(MemberGridItemData(
    id: RouteEnum.DEALS,
    iconData: IconCode.gridDeals,
    // imageName: 'images/user/macico_trans.png',
    route: RoutePage.deals,
    createLinearGradient: () => getLinearGradient(
      [
        HexColor.fromHex('#c8de59'),
        HexColor.fromHex('#7c9c1f'),
      ],
      null,
    ),
  ));
  static MemberGridItemNew rollbacks =
      MemberGridItemNew.define(MemberGridItemData(
    id: RouteEnum.ROLLBACK,
    iconData: IconCode.gridRollback,
    // imageName: 'images/user/macico_rolb.png',
    route: RoutePage.rollback,
    createLinearGradient: () => getLinearGradient(
      [
        HexColor.fromHex('#ed6b72'),
        HexColor.fromHex('#b72541'),
      ],
      null,
    ),
  ));

  /// Optional
  // static MemberGridItem agent = MemberGridItem.define(MemberGridItemData(
  //   id: RouteEnum.AGENT,
  //   iconData: IconCode.gridAgent,
  //   imageName: 'images/user/macico_agent.png',
  //   route: RoutePage.agent,
  // ));
  static MemberGridItemNew vip = MemberGridItemNew.define(MemberGridItemData(
    id: RouteEnum.VIP,
    iconData: IconCode.gridVip,
    route: RoutePage.vipLevel,
    createLinearGradient: () => getLinearGradient(
      [
        HexColor.fromHex('#e68f63'),
        HexColor.fromHex('#a75433'),
      ],
      null,
    ),
  ));
  static MemberGridItemNew notice = MemberGridItemNew.define(MemberGridItemData(
    id: RouteEnum.NOTICE,
    iconData: IconCode.gridNotice,
    route: RoutePage.noticeBoard,
    createLinearGradient: () => getLinearGradient(
      [
        HexColor.fromHex('#e68f63'),
        HexColor.fromHex('#a75433'),
      ],
      null,
    ),
  ));

  /// No Route
  static MemberGridItemNew logout = MemberGridItemNew.define(MemberGridItemData(
    id: RouteEnum.LOGOUT,
    iconData: IconCode.gridLogout,
    // imageName: 'images/user/macico_logout.png',
    createLinearGradient: () => getLinearGradient(
      [
        HexColor.fromHex('#cccccc'),
        HexColor.fromHex('#929292'),
      ],
      null,
    ),
  ));
  // static MemberGridItemNew password =
  //     MemberGridItemNew.define(MemberGridItemData(
  //   id: RouteEnum.PASSWORD,
  //   iconData: IconCode.gridPassword,
  // ));
  // static MemberGridItemNew register =
  //     MemberGridItemNew.define(MemberGridItemData(
  //   id: RouteEnum.REGISTER,
  //   iconData: IconCode.gridRegister,
  // ));

  /// Used for defining cases
  const MemberGridItemNew.define(MemberGridItemData fromValue)
      : super.define(fromValue);
}
