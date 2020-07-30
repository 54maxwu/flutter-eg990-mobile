import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/exports_for_route_widget.dart';

import 'state/agent_store.dart';
import 'widgets/agent_display.dart';

class AgentRoute extends StatefulWidget {
  @override
  _AgentRouteState createState() => _AgentRouteState();
}

class _AgentRouteState extends State<AgentRoute> {
  AgentStore _store;
  List<ReactionDisposer> _disposers;
  Function toastDismiss;

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
            Future.delayed(Duration(milliseconds: 200)).then(
              (value) => FLToast.showError(
                text: message,
                showDuration: ToastDuration.DEFAULT.value,
              ),
            );
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
          print('reaction on wait agent: $wait');
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
      /* Reaction on agent request result */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.mergeAdResult,
        // Run some logic with the content of the observed field
        (result) {
          print('reaction on merge ad result: $result');
          if (result == null) return;
          if (result.isSuccess) {
            try {
              Navigator.of(context).pop();
            } on Exception {}
            FLToast.showSuccess(
              text: result.msg,
              showDuration: ToastDuration.DEFAULT.value,
            );
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
    try {
      _store.closeStreams();
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
    return Container(
      alignment: Alignment.center,
      child: Observer(
        // Observe using specific widget
        builder: (_) {
          switch (_store.state) {
            case AgentStoreState.initial:
              return SizedBox.shrink();
            case AgentStoreState.loading:
              return LoadingWidget();
            case AgentStoreState.loaded:
              return AgentDisplay(_store);
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
