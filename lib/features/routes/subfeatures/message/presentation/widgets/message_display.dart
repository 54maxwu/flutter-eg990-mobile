import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/event/event_inject.dart';
import 'package:flutter_eg990_mobile/features/router/app_global_streams.dart'
    show getAppGlobalStreams;
import 'package:flutter_eg990_mobile/features/screen/feature_screen_inherited_widget.dart';
import 'package:flutter_eg990_mobile/injection_container.dart';

import '../state/message_store.dart';
import 'message_display_item.dart';

class MessageDisplay extends StatefulWidget {
  final MessageStore store;

  MessageDisplay(this.store);

  @override
  _MessageDisplayState createState() => _MessageDisplayState();
}

class _MessageDisplayState extends State<MessageDisplay> {
  List<GlobalKey<MessageDisplayItemState>> itemKeys;
  List<MessageDisplayItem> listItems;

  EventStore _eventStore;
  bool waitDelayedCheck = false;

  @override
  void initState() {
    _eventStore = sl.get<EventStore>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _eventStore = FeatureScreenInheritedWidget.of(context)?.eventStore;
    debugPrint('screen has new message: ${getAppGlobalStreams.hasNewMessage}');

    itemKeys ??= new List();
    listItems ??= widget.store.messageList.map((message) {
      GlobalKey<MessageDisplayItemState> key =
          new GlobalKey<MessageDisplayItemState>(debugLabel: 'm${message.id}');
      itemKeys.add(key);
      return MessageDisplayItem(
        key,
        data: message,
        onItemTap: (id) {
          widget.store.updateMessageStatus(id);
          if (!waitDelayedCheck) {
            waitDelayedCheck = true;
            Future.delayed(Duration(milliseconds: 500), () {
              _eventStore?.getNewMessageCount();
              waitDelayedCheck = false;
            });
          }
        },
      );
    }).toList();

    return ListView.builder(
      itemCount: listItems.length,
      itemBuilder: (_, index) {
        return listItems[index];
      },
    );
  }
}
