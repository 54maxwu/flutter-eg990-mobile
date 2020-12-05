import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/presentation/features/member_features/balance/balance_route.dart';

import 'state/withdraw_store.dart';
import 'widgets/withdraw_display.dart';

class WithdrawRoute extends StatefulWidget {
  @override
  _WithdrawRouteState createState() => _WithdrawRouteState();
}

class _WithdrawRouteState extends State<WithdrawRoute> {
  WithdrawStore _store;
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    _store ??= sl.get<WithdrawStore>();
    super.initState();
    // execute action on init
    _store.getBankcard();
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
        debugPrint('pop withdraw route');
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
              child: BalanceRoute(actionType: BalanceGridActionType.withdraw),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Observer(
                // Observe using specific widget
                builder: (_) {
                  switch (_store.state) {
                    case WithdrawStoreState.loading:
                      return LoadingWidget();
                    case WithdrawStoreState.loaded:
                      return WithdrawDisplay(_store);
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
