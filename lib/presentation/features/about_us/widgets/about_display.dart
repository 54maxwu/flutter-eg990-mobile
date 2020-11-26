import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/export_internal_file.dart';
import 'package:flutter_eg990_mobile/res.dart';

import '../data/about_data.dart';
import 'about_desc.dart';

class AboutDisplay extends StatelessWidget {
  // final AboutData data2 =
  //     AboutData(title: localeStr.aboutDataTitle2, subtitles: [
  //   localeStr.aboutDataSubtitle20,
  //   localeStr.aboutDataSubtitle21,
  //   localeStr.aboutDataSubtitle22,
  //   localeStr.aboutDataSubtitle23,
  // ], contents: [
  //   localeStr.aboutDataDesc20,
  //   localeStr.aboutDataDesc21,
  //   localeStr.aboutDataDesc22,
  //   localeStr.aboutDataDesc23,
  // ]);
  //
  // final AboutData data3 =
  //     AboutData(title: localeStr.aboutDataTitle3, subtitles: [
  //   localeStr.aboutDataSubtitle30,
  //   localeStr.aboutDataSubtitle31,
  //   localeStr.aboutDataSubtitle32,
  // ], contents: [
  //   localeStr.aboutDataDesc30,
  //   localeStr.aboutDataDesc31,
  //   localeStr.aboutDataDesc32,
  // ]);
  //
  // final AboutData data4 =
  //     AboutData(title: localeStr.aboutDataTitle4, subtitles: [
  //   localeStr.aboutDataSubtitle40,
  //   localeStr.aboutDataSubtitle41,
  //   localeStr.aboutDataSubtitle42,
  //   localeStr.aboutDataSubtitle43,
  // ], contents: [
  //   localeStr.aboutDataDesc40,
  //   localeStr.aboutDataDesc41,
  //   localeStr.aboutDataDesc42,
  //   localeStr.aboutDataDesc43,
  // ]);
  //
  // final AboutData data5 =
  //     AboutData(title: localeStr.aboutDataTitle5, subtitles: [
  //   localeStr.aboutDataSubtitle50,
  //   localeStr.aboutDataSubtitle51,
  //   localeStr.aboutDataSubtitle52,
  //   localeStr.aboutDataSubtitle53,
  // ], contents: [
  //   localeStr.aboutDataDesc50,
  //   localeStr.aboutDataDesc51,
  //   localeStr.aboutDataDesc52,
  //   localeStr.aboutDataDesc53,
  // ]);

  @override
  Widget build(BuildContext context) {
    List<AboutData> _dataList = [
      AboutData(),
      // data2,
      // data3,
      // data4,
      // data5,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4.0, 20.0, 4.0, 12.0),
          child: Column(
            children: [
              Image.asset(Res.logo),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  localeStr.appVersion(Global.device.appVersionSide),
                  style: TextStyle(
                    fontSize: FontSize.NORMAL.value,
                    color: themeColor.defaultHintColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: ListView.separated(
              primary: true,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: _dataList.length,
              separatorBuilder: (context, _) {
                // add divider between options
                return SizedBox(height: 16.0);
              },
              itemBuilder: (content, index) {
                final data = _dataList[index];
                if (index == 0) {
                  return AboutDesc();
                } else {
                  return Container(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                      decoration: BoxDecoration(
                          color: themeColor.defaultLayeredBackgroundColor,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Column(
                        children: [
                              Text(data.title,
                                  style: TextStyle(
                                    fontSize: FontSize.TITLE.value,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Divider(height: 8.0),
                              SizedBox(height: 16.0),
                            ] +
                            List.generate(
                                data.subtitles.length,
                                (contentIndex) =>
                                    _buildContent(data, contentIndex)),
                      ));
                }
              }),
        ),
      ],
    );
  }

  Widget _buildContent(AboutData data, int index) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        children: [
          TextSpan(
            text: '${data.subtitles[index]}\n',
            style: TextStyle(
                fontSize: FontSize.MESSAGE.value,
                fontWeight: FontWeight.bold,
                color: themeColor.defaultTextColor),
          ),
          TextSpan(
            text: '${data.contents[index]}\n\n',
            style: TextStyle(
                fontSize: FontSize.SUBTITLE.value,
                color: themeColor.defaultMessageColor),
          ),
        ],
      ),
    );
  }
}
