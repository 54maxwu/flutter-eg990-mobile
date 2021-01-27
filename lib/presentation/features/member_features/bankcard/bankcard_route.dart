import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/presentation/features/member_features/bankcard/widgets/bankcard_display_provider.dart';

import 'state/bankcard_store.dart';
import 'widgets/bankcard_display.dart';

class BankcardRoute extends StatefulWidget {
  final bool bindNewCard;

  BankcardRoute({this.bindNewCard = false});

  @override
  _BankcardRouteState createState() => _BankcardRouteState();
}

class _BankcardRouteState extends State<BankcardRoute> {
  BankcardStore _store;
  BankcardDisplayProvider _provider;
  List<ReactionDisposer> _disposers;
  CancelFunc toastDismiss;

  @override
  void initState() {
    _store ??= sl.get<BankcardStore>();
    super.initState();
    // execute action on init
    _store.initialize();
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
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
      /* Reaction on new bankcard action */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.waitForNewCardResult,
        // Run some logic with the content of the observed field
        (bool wait) {
          print('reaction on wait bankcard: $wait');
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
        (_) => _store.newCardResult,
        // Run some logic with the content of the observed field
        (result) {
          print('new bankcard result: $result');
          if (result == null) return;
          if (result.isSuccess) {
            callToastInfo(
                MessageMap.getSuccessMessage(result.msg, RouteEnum.BANKCARD),
                icon: Icons.check_circle_outline);
            AppNavigator.navigateTo(RoutePage.bankcard);
          } else {
            callToastError(
                MessageMap.getErrorMessage(result.msg, RouteEnum.BANKCARD));
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
    _provider ??= BankcardDisplayProvider(
      store: _store,
      startPage: (widget.bindNewCard)
          ? BankcardPageEnum.NEW_CARD
          : BankcardPageEnum.LIST,
    );
    return WillPopScope(
      onWillPop: () async {
        debugPrint('pop bankcard route');
        if (_provider.page.index == 0) {
          AppNavigator.navigateTo(RoutePage.bankcard);
        } else {
          Future.delayed(
              Duration(milliseconds: 100), () => AppNavigator.back());
        }
        return Future(() => true);
      },
      child: Scaffold(
        body: Container(
          alignment: Alignment.topCenter,
          child: Observer(
            // Observe using specific widget
            builder: (_) {
              switch (_store.state) {
                case BankcardStoreState.loading:
                  return LoadingWidget();
                case BankcardStoreState.loaded:
                  return ChangeNotifierProvider<BankcardDisplayProvider>.value(
                    value: _provider,
                    child: BankcardDisplay(),
                  );
                  break;
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
