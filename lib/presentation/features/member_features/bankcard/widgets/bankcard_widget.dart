import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/domain/sector/bankcard/bankcard.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';

class BankcardWidget extends StatelessWidget {
  final Bankcard bankcard;

  BankcardWidget(this.bankcard);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: themeColor.defaultCardColor,
      borderRadius: BorderRadius.circular(8.0),
      elevation: 4.0,
      child: Container(
        width: 300,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                bankcard.bankName,
                style: TextStyle(
                  color: themeColor.defaultCardTitleColor,
                  fontSize: FontSize.TITLE.value,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Center(
              child: Text(
                bankcard.bankAccount,
                style: TextStyle(
                  color: themeColor.defaultTextColor,
                  fontSize: FontSize.TITLE.value,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12.0),
              alignment: Alignment.bottomRight,
              child: Text(
                bankcard.accountName,
                style: TextStyle(
                  color: themeColor.defaultTextColor,
                  fontSize: FontSize.SUBTITLE.value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
