import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/domain/sector/bankcard/bankcard.dart';
import 'package:flutter_eg990_mobile/domain/sector/bankcard/bankcard_model.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/presentation/features/member_features/bankcard/widgets/bankcard_widget.dart';

import '../state/withdraw_store.dart';

class WithdrawDisplay extends StatefulWidget {
  final WithdrawStore store;

  WithdrawDisplay(this.store);

  @override
  _WithdrawDisplayState createState() => _WithdrawDisplayState();
}

class _WithdrawDisplayState extends State<WithdrawDisplay> {
  Bankcard bankcard;

  @override
  void initState() {
    bankcard = widget.store.bankcard.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: themeColor.defaultCardColor,
          child: (!bankcard.hasCard)
              ? Container(
                  height: 60.0,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.add,
                        color: themeColor.defaultHintSubColor,
                      ),
                      Text(
                        localeStr.hintAddBankcard,
                        style: TextStyle(
                          color: themeColor.dialogTitleColor,
                          fontSize: FontSize.MESSAGE.value,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 24.0),
                  child: BankcardWidget(bankcard),
                ),
        ),
        if (!bankcard.hasCard)
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            child: Text(
              localeStr.hintAddBankcardDesc,
              style: TextStyle(
                color: themeColor.defaultHintColor,
                fontSize: FontSize.MESSAGE.value,
              ),
            ),
          ),
      ],
    );
  }
}
