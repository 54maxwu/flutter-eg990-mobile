import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/network/handler/request_code_model.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';

import '../state/agent_store.dart';
import 'agent_display_bankcard_edit.dart';
import 'agent_display_bankcard_view.dart';

class AgentDisplayBankcard extends StatefulWidget {
  final AgentStore store;

  AgentDisplayBankcard(this.store);

  @override
  _AgentDisplayBankcardState createState() => _AgentDisplayBankcardState();
}

class _AgentDisplayBankcardState extends State<AgentDisplayBankcard> {
  List<ReactionDisposer> _disposers;
  CancelFunc toastDismiss;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.errorMessage,
        // Run some logic with the content of the observed field
        (String message) {
          if (message != null && message.isNotEmpty) {
            callToastError(message, delayedMilli: 200);
          }
        },
      ),
      /* Reaction on new bankcard action */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.waitForNewCardResult,
        // Run some logic with the content of the observed field
        (bool wait) {
          debugPrint('reaction on wait agent bankcard: $wait');
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
        (_) => widget.store.newCardResult,
        // Run some logic with the content of the observed field
        (RequestCodeModel result) {
          debugPrint('agent new bankcard result: $result');
          if (result == null) return;
          if (result.isSuccess) {
            callToastInfo(
                MessageMap.getSuccessMessage(result.msg, RouteEnum.AGENT),
                icon: Icons.check_circle_outline);
            widget.store.getBankcard();
          } else {
            callToastError(
                MessageMap.getErrorMessage(result.msg, RouteEnum.AGENT));
          }
        },
      ),
    ];
  }

  @override
  void dispose() {
    try {
      if (toastDismiss != null) {
        toastDismiss();
        toastDismiss = null;
      }
      _disposers.forEach((d) => d());
    } on Exception {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool validCard =
        widget.store.bankcard != null && widget.store.bankcard.hasCard;
    return Container(
      alignment: Alignment.topCenter,
      child: (validCard)
          ? AgentDisplayBankcardView(bankcard: widget.store.bankcard)
          : AgentDisplayBankcardEdit(bankcardStore: widget.store),
    );
  }
}
