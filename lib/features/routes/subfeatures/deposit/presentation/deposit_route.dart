import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/warning_display.dart';

import 'state/deposit_store.dart';
import 'widgets/deposit_display.dart';

/// Main View of [AutoRouter.promoRoute]
///@author H.C.CHIANG
///@version 2020/3/12
class DepositRoute extends StatefulWidget {
  @override
  _DepositRouteState createState() => _DepositRouteState();
}

class _DepositRouteState extends State<DepositRoute> {
  DepositStore _store;
  List<ReactionDisposer> _disposers;

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
      // reaction(
      //   // Observe in page
      //   // Tell the reaction which observable to observe
      //   (_) => _store.hasCard,
      //   // Run some logic with the content of the observed field
      //   (bool hasCard) {
      //     if (hasCard != null && !hasCard && mounted) {
      //       AppNavigator.replaceWith(RoutePage.bankcard);
      //       callToast(localeStr.depositHintRedirectBankcard,
      //           duration: ToastDuration.LONG);
      //     }
      //   },
      // ),
    ];
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  void initState() {
    _store ??= sl.get<DepositStore>();
    super.initState();
    _store.getInitializeData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        debugPrint('pop deposit route');
        AppNavigator.back();
        return Future(() => true);
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Observer(
            builder: (_) {
              switch (_store.state) {
                case DepositStoreState.loading:
                  return LoadingWidget();
                case DepositStoreState.loaded:
                  return DepositDisplay(store: _store);
                case DepositStoreState.error:
                  return Center(
                      child: WarningDisplay(
                    message: Failure.internal(FailureCode(
                      type: FailureType.DEPOSIT,
                      code: 10,
                    )).message,
                  ));
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
