import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';

import '../../data/models/notice_model.dart' show NoticeData;

class NoticeDisplayContent extends StatelessWidget {
  final List<NoticeData> dataList;

  NoticeDisplayContent({@required this.dataList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: dataList.length,
        itemBuilder: (_, index) {
          NoticeData data = dataList[index];
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data.date.replaceAll(' ~ ', ' ~ \n'),
                  style: TextStyle(
                    color: Themes.defaultAccentColor,
                    fontSize: FontSize.TITLE.value,
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  data.content,
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
