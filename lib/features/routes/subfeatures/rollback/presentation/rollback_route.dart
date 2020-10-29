import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';

import 'state/rollback_store.dart';
import 'widgets/rollback_display_table.dart';

class RollbackRoute extends StatefulWidget {
  @override
  _RollbackRouteState createState() => _RollbackRouteState();
}

class _RollbackRouteState extends State<RollbackRoute> {
  RollbackStore _store;
  List<ReactionDisposer> _disposers;
  CancelFunc toastDismiss;

  final GlobalKey<RollbackDisplayTableState> contentKey =
      new GlobalKey(debugLabel: 'content');

  void getPageData(int page) {
    if (_store == null) return;
    _store.getRecord(page: page);
  }

  @override
  void initState() {
    _store ??= sl.get<RollbackStore>();
    super.initState();
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
      /* Reaction on search action */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.waitForPageData,
        // Run some logic with the content of the observed field
        (bool wait) {
          debugPrint('reaction on wait rollback: $wait');
          if (wait) {
            toastDismiss = callToastLoading();
          } else if (toastDismiss != null) {
            toastDismiss();
            toastDismiss = null;
            if (_store.dataList != null) {
              debugPrint(
                  'updating rollback record, length: ${_store.dataList.length}');
              try {
                contentKey.currentState.updateContent = _store.dataList;
              } on Exception {
                callToastError(localeStr.messageActionFailed);
              }
            }
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
    return WillPopScope(
      onWillPop: () {
        debugPrint('pop rollback route');
        AppNavigator.back();
        return Future(() => true);
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
          alignment: Alignment.topCenter,
          child: RollbackDisplayTable(contentKey),
        ),
      ),
    );
  }
}
