import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/common/toast/toast_error_widget.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';
import 'package:provider/provider.dart';

import 'state/home_store.dart';
import 'widgets/home_display.dart';
import 'widgets/home_display_provider.dart';
import 'widgets/home_display_size_calc.dart';
import 'widgets/tabs/tab_item_size.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  HomeStore _store;
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    _store ??= sl.get<HomeStore>();
    super.initState();
    // execute action on init
    _store.getInitializeData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction(
        (_) => _store.errorMessage,
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
    return Container(
      padding: EdgeInsets.all(4.0),
      alignment: Alignment.center,
      child: Observer(
        // Observe using specific widget
        builder: (_) {
          switch (_store.state) {
            case HomeStoreState.loading:
              return LoadingWidget();
            case HomeStoreState.loaded:
              return ChangeNotifierProvider(
                create: (_) => HomeDisplayProvider(
                  homeStore: _store,
                  calc: HomeDisplaySizeCalc(),
                  tabItemSize: TabItemSize(),
                ),
                child: HomeDisplay(),
              );
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
