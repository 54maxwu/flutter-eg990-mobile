import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/utils/value_util.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';

import '../data/balance_grid_action.dart';

class BalanceGridItem extends StatefulWidget {
  final String platform;
  final bool addDivider;
  final BalanceGridCall onTapAction;

  const BalanceGridItem({
    Key key,
    @required this.platform,
    @required this.addDivider,
    @required this.onTapAction,
  }) : super(key: key);

  @override
  BalanceGridItemState createState() => BalanceGridItemState();
}

class BalanceGridItemState extends State<BalanceGridItem> {
  String _credit = '---';
  bool isMaintaining = false;
  bool canTransferOut = true;
  bool canTransferIn = true;
  bool canRefresh = true;

  set setCredit(String credit) {
    if (_credit == credit) return;
    debugPrint('${widget.platform} balance credit: $credit');
    _credit = credit;
    isMaintaining = ValueUtil.strToInt(credit) < 0 ||
        credit == 'maintenance' ||
        credit == 'InMaintenance';
    if (isMaintaining || _credit == '---') {
      canTransferIn = false;
      canTransferOut = false;
    } else {
      var dCredit = _credit.strToDouble;
      canTransferOut = dCredit > 0.0;
      if (credit == 'x' || dCredit < 0) canTransferIn = false;
    }
    setState(() {});
    debugPrint('${widget.platform} credit updated: $_credit');
  }

  @override
  Widget build(BuildContext context) {
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
            child: (widget.platform.isNotEmpty)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.platform,
                        style: TextStyle(
                          fontSize: FontSize.MESSAGE.value,
                          color: themeColor.balanceCardTitleColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Text(
                          (isMaintaining) ? localeStr.hintMaintenance : _credit,
                          style: TextStyle(
                            fontSize: FontSize.SUBTITLE.value,
                            color: themeColor.balanceCardTextColor,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ),
        ),
        if (widget.addDivider)
          SizedBox(
            height: 30.0,
            child: VerticalDivider(thickness: 0.2, width: 0.0),
          ),
      ],
    );
  }
}
