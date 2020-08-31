import 'dart:convert';

import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/internal/global.dart';
import 'package:flutter_eg990_mobile/core/internal/themes.dart';
import 'package:flutter_eg990_mobile/utils/regex_util.dart';

import '../../data/models/message_model.dart';

typedef MessageTapCall = void Function(int);

class MessageDisplayItem extends StatefulWidget {
  final MessageModel data;
  final MessageTapCall onItemTap;

  MessageDisplayItem(Key key, {@required this.data, this.onItemTap})
      : super(key: key);

  @override
  MessageDisplayItemState createState() => MessageDisplayItemState();
}

class MessageDisplayItemState extends State<MessageDisplayItem> {
  bool isRead;
  bool hasChinese;
  bool headerMultiLine;

  @override
  void initState() {
    isRead = widget.data.isRead;
    hasChinese = widget.data.title.hasChinese;
    headerMultiLine = (hasChinese)
        ? utf8.encode(widget.data.title).length * FontSize.NORMAL.value / 1.5 >
            Global.device.width - 60
        : utf8.encode(widget.data.title).length * FontSize.NORMAL.value >
            Global.device.width - 60;
    debugPrint(
        'title: ${widget.data.title}, multiline: $headerMultiLine, hasChinese: $hasChinese');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 12.0,
      ),
      decoration: new BoxDecoration(
        color: Themes.defaultCardColor,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: ConfigurableExpansionTile(
        borderColorStart: Colors.transparent,
        borderColorEnd: Colors.transparent,
        animatedWidgetFollowingHeader: const Icon(
          Icons.expand_more,
          color: const Color(0xFF707070),
        ),
        header: Container(
          constraints: BoxConstraints(
            minWidth: Global.device.width - 60,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: (isRead)
                    ? Icon(
                        Icons.check_box,
                        color: Themes.iconColorGreen,
                        size: 18.0,
                      )
                    : Icon(
                        Icons.info,
                        color: Themes.iconColorYellow,
                        size: 18.0,
                      ),
              ),
              Container(
                width: Global.device.width - 96,
                child: Text(
                  widget.data.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
        headerExpanded: Container(
          constraints: BoxConstraints(
            minWidth: Global.device.width - 60,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  right: 8.0,
                  top: (headerMultiLine && hasChinese)
                      ? 3
                      : (hasChinese) ? 2 : 1,
                ),
                child: Icon(
                  Icons.check_box,
                  color: Themes.iconColorGreen,
                  size: 18.0,
                ),
              ),
              Container(
                width: Global.device.width - 96,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        widget.data.title,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('${widget.data.msg}'),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '${widget.data.date}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
        onExpansionChanged: (isExpanded) {
          if (!isRead && isExpanded) {
            widget.onItemTap(widget.data.id);
            setState(() {
              isRead = true;
            });
          }
        },
      ),
    );
  }
}
