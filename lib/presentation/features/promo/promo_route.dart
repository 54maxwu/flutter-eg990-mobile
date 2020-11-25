import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/presentation/features/promo/widgets/promo_display.dart';

import 'state/promo_store.dart';

class PromoRoute extends StatefulWidget {
  @override
  _PromoRouteState createState() => _PromoRouteState();
}

class _PromoRouteState extends State<PromoRoute> {
  PromoStore _store;
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    _store ??= sl.get<PromoStore>();
    super.initState();
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
        debugPrint('pop promo route');
        Future.delayed(Duration(milliseconds: 100), () => AppNavigator.back());
        return Future(() => true);
      },
      child: Scaffold(
        body: Container(
          alignment: Alignment.topCenter,
          child: Observer(
            // Observe using specific widget
            builder: (_) {
              switch (_store.state) {
                case PromoStoreState.loading:
                  return LoadingWidget();
                case PromoStoreState.loaded:
                  return PromoDisplay(promos: _store.promos ?? []);
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
