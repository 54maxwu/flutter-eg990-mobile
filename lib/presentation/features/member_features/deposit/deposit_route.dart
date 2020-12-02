import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';
import 'package:provider/provider.dart';

import 'state/deposit_store.dart';
import 'widgets/deposit_display.dart';
import 'widgets/deposit_display_provider.dart';

class DepositRoute extends StatefulWidget {
  @override
  _DepositRouteState createState() => _DepositRouteState();
}

class _DepositRouteState extends State<DepositRoute> {
  DepositStore _store;
  List<ReactionDisposer> _disposers;
  CancelFunc toastDismiss;

  @override
  void initState() {
    _store ??= sl.get<DepositStore>();
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
        debugPrint('pop bets route');
        if (toastDismiss != null) {
          return Future(() => false);
        } else {
          Future.delayed(
            Duration(milliseconds: 100),
            () => AppNavigator.back(),
          );
          return Future(() => true);
        }
      },
      child: Scaffold(
        backgroundColor: themeColor.defaultLayeredBackgroundColor,
        body: Observer(
          // Observe using specific widget
          builder: (_) {
            switch (_store.state) {
              case DepositStoreState.initial:
                return SizedBox.shrink();
              case DepositStoreState.loading:
                return LoadingWidget();
              case DepositStoreState.loaded:
                return ChangeNotifierProvider(
                  create: (_) => DepositDisplayProvider(store: _store),
                  child: DepositDisplay(),
                );
              default:
                return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
