import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';

import '../../data/models/notice_model.dart' show NoticeData;

class NoticeDisplayContent extends StatelessWidget {
  final List<NoticeData> dataList;

  NoticeDisplayContent({@required this.dataList});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 60),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Themes.defaultBorderColor),
          left: BorderSide(color: Themes.defaultBorderColor),
        ),
      ),
      child: Container(
        decoration: Themes.layerShadowDecorRoundBottom,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: dataList.length,
              itemBuilder: (_, index) {
                NoticeData data = dataList[index];
                return Container(
                  margin: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Themes.noticeBgColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 4.0),
                        child: Text(
                          data.date.replaceAll(' ~ ', ' ~ \n'),
                          style: TextStyle(
                              fontSize: FontSize.MESSAGE.value,
                              color: Themes.noticeTitleColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 20.0),
                        child: Text(
                          data.content,
                          style: TextStyle(
                              fontSize: FontSize.SUBTITLE.value,
                              color: Themes.noticeTextColor,
                              fontWeight: FontWeight.w400,
                              height: 1.5),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
