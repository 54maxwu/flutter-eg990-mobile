import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';

import 'state/message_store.dart';
import 'widgets/message_display.dart';

class MessageRoute extends StatefulWidget {
  @override
  _MessageRouteState createState() => _MessageRouteState();
}

class _MessageRouteState extends State<MessageRoute> {
  MessageStore _store;
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    _store ??= sl.get<MessageStore>();
    super.initState();
    // execute action on init
    _store.getData();
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
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        debugPrint('pop message route');
        AppNavigator.back();
        return Future(() => true);
      },
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
          child: Observer(
            // Observe using specific widget
            builder: (_) {
              switch (_store.state) {
                case MessageStoreState.initial:
                  return SizedBox.shrink();
                case MessageStoreState.loading:
                  return LoadingWidget();
                case MessageStoreState.loaded:
                  return MessageDisplay(_store);
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
