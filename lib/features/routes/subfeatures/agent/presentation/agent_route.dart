import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';

import 'state/agent_store.dart';
import 'widgets/agent_display.dart';

class AgentRoute extends StatefulWidget {
  @override
  _AgentRouteState createState() => _AgentRouteState();
}

class _AgentRouteState extends State<AgentRoute> {
  AgentStore _store;
  List<ReactionDisposer> _disposers;
  CancelFunc toastDismiss;

  @override
  void initState() {
    _store ??= sl.get<AgentStore>();
    super.initState();
    // execute action on init
    _store.getAgentData();
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
      /* Reaction on new agent action */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.waitForAgentResponse,
        // Run some logic with the content of the observed field
        (bool wait) {
          debugPrint('reaction on wait agent: $wait');
          if (wait) {
            toastDismiss = callToastLoading();
          } else if (toastDismiss != null) {
            toastDismiss();
            toastDismiss = null;
          }
        },
      ),
    ];
  }

  @override
  void dispose() {
    try {
      _store.clearStreams();
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
        debugPrint('pop agent route');
        AppNavigator.returnToHome();
        return Future(() => true);
      },
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Observer(
            // Observe using specific widget
            builder: (_) {
              switch (_store.state) {
                case AgentStoreState.loading:
                  return LoadingWidget();
                case AgentStoreState.loaded:
                  return AgentDisplay();
                default:
                  return SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
