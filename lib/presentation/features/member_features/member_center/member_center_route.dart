import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';

import 'state/member_center_store.dart';
import 'widgets/member_center_display.dart';
import 'widgets/member_center_inherited_widget.dart';

class MemberCenterRoute extends StatefulWidget {
  @override
  _MemberCenterRouteState createState() => _MemberCenterRouteState();
}

class _MemberCenterRouteState extends State<MemberCenterRoute> {
  MemberCenterStore _store;
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    _store ??= sl.get<MemberCenterStore>();
    super.initState();
    _store.initialize();
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
        debugPrint('pop member detail route');
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
                case MemberCenterStoreState.loading:
                  return LoadingWidget();
                case MemberCenterStoreState.loaded:
                  return MemberCenterInheritedWidget(
                    store: _store,
                    child: MemberCenterDisplay(),
                  );
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
