import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/core/network/handler/request_status_model.dart';
import 'package:flutter_ty_mobile/features/exports_for_route_widget.dart';

import 'state/bankcard_store.dart';
import 'widgets/bankcard_display.dart';
import 'widgets/bankcard_display_card.dart';
import 'widgets/withdraw_display.dart';

class BankcardRoute extends StatefulWidget {
  final bool withdraw;

  BankcardRoute({this.withdraw = false});

  @override
  _BankcardRouteState createState() => _BankcardRouteState();
}

class _BankcardRouteState extends State<BankcardRoute> {
  final Key observerKey = new Key('observer');
  BankcardStore _store;
  List<ReactionDisposer> _disposers;
  Function toastDismiss;

  @override
  void initState() {
    _store ??= sl.get<BankcardStore>();
    _store.getBankcard();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      /* Reaction on error message changed */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.errorMessage,
        // Run some logic with the content of the observed field
        (String msg) {
          if (msg != null && msg.isNotEmpty) {
            FLToast.showError(
              text: msg,
              showDuration: ToastDuration.DEFAULT.value,
            );
          }
        },
      ),
      /* Reaction on new bankcard action */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.waitForNewCardResult,
        // Run some logic with the content of the observed field
        (bool wait) {
          print('reaction on wait bankcard: $wait');
          if (wait) {
            toastDismiss = FLToast.showLoading(
              text: localeStr.messageWait,
            );
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
        (_) => _store.newCardResult,
        // Run some logic with the content of the observed field
        (RequestStatusModel result) {
          print('new bankcard result: $result');
          if (result == null) return;
          if (result.isSuccess) {
            FLToast.showSuccess(
              text: result.msg,
              showDuration: ToastDuration.DEFAULT.value,
            );
            _store.getBankcard();
          } else {
            FLToast.showError(
              text: result.msg,
              showDuration: ToastDuration.DEFAULT.value,
            );
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Observer(
        key: observerKey,
        builder: (_) {
          switch (_store.state) {
            case BankcardStoreState.loading:
              return LoadingWidget();
            case BankcardStoreState.loaded:
              bool validCard =
                  _store.bankcard != null && _store.bankcard.hasCard;
              if (!validCard && widget.withdraw) {
                Future.delayed(Duration(milliseconds: 300), () {
                  FLToast.showText(
                    text: localeStr.messageErrorBindBankcard,
                    position: FLToastPosition.top,
                    showDuration: ToastDuration.DEFAULT.value,
                  );
                });
              }
              if (validCard && widget.withdraw) {
                return WithdrawDisplay(
                  bankcardStore: _store,
                  bankcard: _store.bankcard,
                );
              } else if (validCard) {
                return BankcardDisplayCard(
                  store: _store,
                  bankcard: _store.bankcard,
                );
              } else {
                return BankcardDisplay(
                  store: _store,
                  bankcard: _store.bankcard,
                );
              }
              break;
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
