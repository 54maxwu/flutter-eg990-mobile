import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/domain/response/request_status_model.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';
import 'package:provider/provider.dart';

import 'data/balance_grid_action_type.dart';
import 'state/balance_store.dart';
import 'widgets/balance_display.dart';
import 'widgets/balance_display_provider.dart';

export 'data/balance_grid_action_type.dart';

class BalanceRoute extends StatefulWidget {
  final BalanceGridActionType actionType;
  final bool hasBackgroundColor;

  const BalanceRoute({
    @required this.actionType,
    this.hasBackgroundColor = true,
  });

  @override
  _BalanceRouteState createState() => _BalanceRouteState();
}

class _BalanceRouteState extends State<BalanceRoute> {
  BalanceStore _store;
  List<ReactionDisposer> _disposers;
  CancelFunc toastDismiss;

  @override
  void initState() {
    _store ??= sl.get<BalanceStore>();
    super.initState();
    // execute action on init
    _store.getInitializeData();
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
            callToastError(message);
          }
        },
      ),
      /* Reaction on new transfer action */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.waitForTransferResult,
        // Run some logic with the content of the observed field
        (bool wait) {
          debugPrint('reaction on wait transfer: $wait');
          if (wait) {
            toastDismiss = callToastLoading();
          } else if (toastDismiss != null) {
            toastDismiss();
            toastDismiss = null;
          }
        },
      ),
      /* Reaction on transfer result changed */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.transferResult,
        // Run some logic with the content of the observed field
        (RequestStatusModel result) {
          debugPrint('reaction on transfer result: $result');
          if (result == null) return;
          if (result.isSuccess) {
            callToastInfo(
                MessageMap.getSuccessMessage(result.msg, RouteEnum.BALANCE),
                icon: Icons.check_circle_outline);
          } else {
            callToastError(
                MessageMap.getErrorMessage(result.msg, RouteEnum.BALANCE));
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
      color: themeColor.balanceCardBackground,
      alignment: Alignment.topCenter,
      child: Observer(
        // Observe using specific widget
        builder: (_) {
          switch (_store.state) {
            case BalanceStoreState.initial:
              return SizedBox.shrink();
            case BalanceStoreState.loading:
              return LoadingWidget();
            case BalanceStoreState.loaded:
              return ChangeNotifierProvider(
                create: (_) => BalanceDisplayProvider(
                  store: _store,
                  actionType: widget.actionType,
                ),
                child: BalanceDisplay(),
              );
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
