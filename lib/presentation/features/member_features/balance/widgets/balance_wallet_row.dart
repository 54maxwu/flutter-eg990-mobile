import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/res.dart';

import '../state/balance_store.dart';
import 'balance_display_provider.dart';

class BalanceWalletRow extends StatefulWidget {
  const BalanceWalletRow({Key key}) : super(key: key);

  @override
  _BalanceWalletRowState createState() => _BalanceWalletRowState();
}

class _BalanceWalletRowState extends State<BalanceWalletRow> {
  BalanceStore _store;
  List<ReactionDisposer> _disposers;

  String _walletCredit;

  void initDisposer() {
    _disposers ??= [
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.balanceUpdated,
        // Run some logic with the content of the observed field
        (String platform) {
          if (platform == '0') {
            setState(() {
              _walletCredit = _store.balanceMap['0'];
            });
          }
        },
      ),
    ];
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _store = null;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _store ??= Provider.of<BalanceDisplayProvider>(context).store;
    if (_disposers == null) initDisposer();
    _walletCredit ??= _store?.balanceMap['0'] ?? '---';
    return Row(
      children: [
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1.0,
                  color: Colors.black12,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Container(
                              height: FontSize.SUBTITLE.value,
                              padding: const EdgeInsets.only(right: 6.0),
                              child: Image.asset(Res.icon_wallet)),
                        ),
                        TextSpan(
                          text: localeStr.walletViewTitleMy,
                          style: TextStyle(
                            color: themeColor.balanceCardTitleColor,
                            fontSize: FontSize.MESSAGE.value,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                  child: Text(
                    _walletCredit,
                    style: TextStyle(
                      fontSize: FontSize.TITLE.value,
                      color: themeColor.balanceCardLinear1Color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
