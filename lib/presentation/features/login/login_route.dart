import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';

import 'state/login_store.dart';
import 'widgets/login_display.dart';

class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  LoginStore _store;
  List<ReactionDisposer> _disposers;
  dynamic _initData;

  void initialized(dynamic data) {
    setState(() {
      _initData = data;
    });
  }

  @override
  void initState() {
    _store ??= sl.get<LoginStore>();
    super.initState();
    // execute action on init
    _store.checkHistory();
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
        debugPrint('pop login route');
        Future.delayed(Duration(milliseconds: 100), () => AppNavigator.back());
        return Future(() => true);
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.topCenter,
          child: Observer(
            // Observe using specific widget
            builder: (_) {
              switch (_store.state) {
                case LoginStoreState.loading:
                  return LoadingWidget();
                case LoginStoreState.loaded:
                  return LoginDisplay(_store);
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
