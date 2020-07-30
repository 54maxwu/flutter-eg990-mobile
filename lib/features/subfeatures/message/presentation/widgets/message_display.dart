import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/features/screen/feature_screen_inherited_widget.dart';
import 'package:flutter_ty_mobile/features/screen/feature_screen_store.dart';

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

  FeatureScreenStore _screenStore;
  bool waitDelayedCheck = false;

  @override
  Widget build(BuildContext context) {
    _screenStore = FeatureScreenInheritedWidget.of(context)?.store;
    print('screen has new message: ${_screenStore?.hasNewMessage}');

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
              _screenStore?.getNewMessageCount();
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
