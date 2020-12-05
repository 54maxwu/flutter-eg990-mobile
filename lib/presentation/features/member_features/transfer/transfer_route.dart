import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/presentation/features/member_features/balance/balance_route.dart';

import 'state/transfer_store.dart';
import 'widgets/transfer_display.dart';

class TransferRoute extends StatefulWidget {
  @override
  _TransferRouteState createState() => _TransferRouteState();
}

class _TransferRouteState extends State<TransferRoute> {
  TransferStore _store;
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    _store ??= sl.get<TransferStore>();
    super.initState();
    // execute action on init
    _store.getWalletType();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction(
        // Observe store's observable in page
        (_) => _store.errorMessage,
        // Do something when the value has changed
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
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        debugPrint('pop transfer route');
        Future.delayed(Duration(milliseconds: 100), () => AppNavigator.back());
        return Future(() => true);
      },
      child: Scaffold(
        backgroundColor: themeColor.defaultLayeredBackgroundColor,
        body: ListView(
          primary: true,
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              padding: const EdgeInsets.only(top: 12.0),
              alignment: Alignment.center,
              child: BalanceRoute(actionType: BalanceGridActionType.transfer),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Observer(
                // Observe using specific widget
                builder: (_) {
                  switch (_store.state) {
                    case TransferStoreState.loading:
                      return LoadingWidget();
                    case TransferStoreState.loaded:
                      return TransferDisplay(_store);
                    default:
                      return SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
