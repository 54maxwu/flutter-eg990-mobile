import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/internal/global.dart';
import 'package:flutter_eg990_mobile/features/themes/theme_interface.dart';

import '../../data/models/notice_model.dart' show NoticeData;

class NoticeDisplayContent extends StatelessWidget {
  final List<NoticeData> dataList;

  NoticeDisplayContent({@required this.dataList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12.0),
      child: ListView.builder(
        primary: true,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: dataList.length,
        itemBuilder: (_, index) {
          NoticeData data = dataList[index];
          String content = '';
          switch (Global.lang.code) {
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
          if (content.isEmpty && !Global.lang.isChinese) {
            content = data.content ?? 'ERROR';
          }
          return Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 12.0,
            ),
            decoration: new BoxDecoration(
              color: themeColor.defaultCardColor,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data.date.replaceAll(' ~ ', ' ~ \n'),
                  style: TextStyle(
                    color: themeColor.defaultAccentColor,
                    fontSize: FontSize.TITLE.value,
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  content,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
