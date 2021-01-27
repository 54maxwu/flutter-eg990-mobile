import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/domain/sector/bankcard/bankcard_model.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';
import 'package:mobx/mobx.dart' show ReactionDisposer, reaction;

import '../state/bankcard_store.dart';
import 'bankcard_display_provider.dart';
import 'bankcard_widget.dart';
import 'new_bankcard_page_view.dart';

class BankcardDisplay extends StatefulWidget {
  @override
  _BankcardDisplayState createState() => _BankcardDisplayState();
}

class _BankcardDisplayState extends State<BankcardDisplay> {
  List<ReactionDisposer> _disposers;
  BankcardStore _store;
  BankcardModel _bankcard;

  void initDisposer() {
    _disposers ??= [
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.bankcard,
        // Run some logic with the content of the observed field
        (card) {
          if (card != _bankcard) {
            setState(() {
              _bankcard = card;
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
  Widget build(BuildContext context) {
    _store ??= Provider.of<BankcardDisplayProvider>(context).store;
    if (_disposers == null) initDisposer();
    _bankcard ??= _store.bankcard;
    return Selector<BankcardDisplayProvider, BankcardPageEnum>(
      selector: (_, provider) => provider.page,
      builder: (_, page, __) {
        if (page.index == 0) {
          return NewBankcardPageView();
        } else if (_bankcard != null && _bankcard.hasCard) {
          return Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(24),
            child: BankcardWidget(_bankcard.data),
          );
        } else {
          return GestureDetector(
            onTap: () => Provider.of<BankcardDisplayProvider>(context).setPage =
                BankcardPageEnum.NEW_CARD,
            child: Container(
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
            ),
          );
        }
      },
    );
  }
}
