import 'package:flutter/widgets.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/res.dart';

import 'balance_platform_grid.dart';
import 'balance_wallet_row.dart';

class BalanceDisplay extends StatefulWidget {
  @override
  _BalanceDisplayState createState() => _BalanceDisplayState();
}

class _BalanceDisplayState extends State<BalanceDisplay> {
  final GlobalKey platformKey = new GlobalKey(debugLabel: 'platformgrid');

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: Global.device.width,
      ),
      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
      child: ListView(
        primary: true,
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  localeStr.walletViewTitleBalance,
                  style: TextStyle(
                    color: themeColor.balanceCardTitleColor,
                    fontSize: FontSize.SUBTITLE.value,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: FontSize.TITLE.value,
                  padding: const EdgeInsets.only(left: 10.0, top: 2.0),
                  child: Image.asset(Res.icon_colored_refresh),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      localeStr.walletViewButtonOneClick,
                      style: TextStyle(
                        color: themeColor.balanceRefreshColor,
                        fontSize: FontSize.MESSAGE.value,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          BalanceWalletRow(),
          BalancePlatformGrid(key: platformKey),
        ],
      ),
    );
  }
}
