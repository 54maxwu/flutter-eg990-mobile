import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/font_size.dart';

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({
    Key key,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.warning, color: Colors.grey[400]),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            alignment: Alignment.center,
            child: Text(
              message.split('-')[0].trim(),
              style: TextStyle(
                  fontSize: FontSize.NORMAL.value, color: Colors.grey[400]),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
            ),
          )
        ],
      ),
    );
  }
}
