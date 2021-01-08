import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/domain/sector/notice_board/notice_data.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';
import 'package:flutter_eg990_mobile/res.dart';

class NoticeListItem extends StatelessWidget {
  final NoticeData data;
  final bool isLast;

  const NoticeListItem({
    Key key,
    @required this.data,
    @required this.isLast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String content = '';
    switch (Global.localeCode) {
      case 'zh':
        content = data.content;
        break;
      case 'en':
        content = data.contentEN;
        break;
      case 'th':
        content = data.contentTH;
        break;
      case 'vi':
        content = data.contentVI;
        break;
    }
    if (content.isEmpty && Global.localeCode != 'zh') {
      content = data.content ?? 'ERROR';
    }
    switch (data.typeId) {
      case 1: // maintenance
        return Container(
          color: themeColor.defaultCardColor,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: GestureDetector(
            onTap: () {},
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: (isLast)
                    ? null
                    : Border(
                        bottom: BorderSide(
                        color: Colors.grey.shade300,
                        width: 0.5,
                      )),
              ),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.asset(Res.message),
                ),
                title: Text(
                  '維護通知: $content',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: themeColor.defaultTextColor,
                    fontSize: FontSize.MESSAGE.value,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  data.date,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: themeColor.defaultHintColor,
                    fontSize: FontSize.SMALLER.value,
                  ),
                ),
              ),
            ),
          ),
        );
      default: // marquee = 0 , unknown = -1
        return Container(
          color: themeColor.defaultCardColor,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: GestureDetector(
            onTap: () {},
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: (isLast)
                    ? null
                    : Border(
                        bottom: BorderSide(
                        color: Colors.grey.shade300,
                        width: 0.5,
                      )),
              ),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.asset(Res.message),
                ),
                title: Text(
                  data.date,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: themeColor.defaultTextColor,
                    fontSize: FontSize.MESSAGE.value,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  data.content,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: themeColor.defaultHintColor,
                    fontSize: FontSize.SMALLER.value,
                  ),
                ),
              ),
            ),
          ),
        );
    }
  }
}
