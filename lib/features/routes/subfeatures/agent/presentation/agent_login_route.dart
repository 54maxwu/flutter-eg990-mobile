import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';

import 'agents/agent_login_display.dart';
import 'agents/agent_login_navigate.dart';
import 'state/agent_store.dart';

class AgentLoginRoute extends StatefulWidget {
  @override
  _AgentLoginRouteState createState() => _AgentLoginRouteState();
}

class _AgentLoginRouteState extends State<AgentLoginRoute> {
  AgentStore _store;
  List<ReactionDisposer> _disposers;
  CancelFunc toastDismiss;

  @override
  void initState() {
    _store ??= sl.get<AgentStore>();
    super.initState();
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
        (String message) {
          if (message != null && message.isNotEmpty) {
            callToastError(message, delayedMilli: 200);
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
    return WillPopScope(
      onWillPop: () {
        debugPrint('pop agent login route');
        AppNavigator.back();
        return Future(() => true);
      },
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(12.0),
          alignment: Alignment.topCenter,
          child: (_store.agent.hasValidToken)
              ? AgentLoginNavigate()
              : AgentLoginDisplay(store: _store),
        ),
      ),
    );
  }
}
