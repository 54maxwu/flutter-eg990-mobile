import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';

import '../../data/models/bankcard_model.dart';
import '../../data/models/withdraw_model.dart';
import '../state/bankcard_store.dart';
import '../state/withdraw_store.dart';
import 'bankcard_display_card.dart';
import 'withdraw_display_view.dart';

class WithdrawDisplay extends StatefulWidget {
  final BankcardStore store;
  final BankcardModel bankcard;

  WithdrawDisplay({
    @required this.store,
    @required this.bankcard,
  });

  @override
  _WithdrawDisplayState createState() => _WithdrawDisplayState();
}

class _WithdrawDisplayState extends State<WithdrawDisplay> {
  WithdrawStore _store;
  CancelFunc toastDismiss;
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    _store ??= sl.get<WithdrawStore>();
    super.initState();
    _store.getRollback();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.errorMessage,
        // Run some logic with the content of the observed field
        (String msg) {
          if (msg != null && msg.isNotEmpty) callToastError(msg);
        },
      ),
      /* Reaction on withdraw action */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.waitForWithdrawResult,
        // Run some logic with the content of the observed field
        (bool wait) {
          debugPrint('reaction on wait withdraw: $wait');
          if (wait) {
            toastDismiss = callToastLoading();
          } else if (toastDismiss != null) {
            toastDismiss();
            toastDismiss = null;
          }
        },
      ),
      /* Reaction on deposit result changed */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.withdrawResult,
        // Run some logic with the content of the observed field
        (WithdrawModel result) {
          debugPrint('withdraw result: $result');
          if (result == null) return;
          if (result.code == 0) {
            callToastInfo(
                (result.msg.isNotEmpty && result.msg.hasChinese)
                    ? result.msg
                    : localeStr.messageSuccess,
                icon: Icons.check_circle_outline);
          } else {
            callToastError((result.msg.isNotEmpty && result.msg.hasChinese)
                ? result.msg
                : localeStr.messageTaskFailed(localeStr.messageErrorWithdraw));
          }
        },
      ),
    ];
  }

  @override
  void dispose() {
    if (toastDismiss != null) {
      toastDismiss();
      toastDismiss = null;
    }
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: Global.device.width - 12,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            BankcardDisplayCard(
              store: widget.store,
              bankcard: widget.bankcard,
              nested: true,
            ),
            WithdrawDisplayView(store: _store),
          ],
        ),
      ),
    );
  }
}
