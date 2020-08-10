import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/internal/themes.dart';

class WarningDisplay extends StatelessWidget {
  final String message;
  final bool smallText;
  final bool highlight;
  final double widthFactor;
  final bool infiniteHeight;
  final bool isFailureMsg;

  const WarningDisplay({
    Key key,
    @required this.message,
    this.smallText = false,
    this.highlight = false,
    this.widthFactor = 2,
    this.infiniteHeight = false,
    this.isFailureMsg = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width / widthFactor,
        maxHeight:
            (infiniteHeight) ? double.infinity : FontSize.NORMAL.value * 2.5,
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.warning,
                size: (smallText) ? 18 : 24,
                color: (highlight)
                    ? Themes.defaultErrorColor
                    : Themes.iconSubColor1,
              ),
              Expanded(
                child: Text(
                  (isFailureMsg) ? message.split('-')[0].trim() : message,
                  style: TextStyle(
                    fontSize: (smallText)
                        ? FontSize.SMALL.value
                        : FontSize.NORMAL.value,
                    color: Themes.iconSubColor1,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: (isFailureMsg) ? 2 : 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
